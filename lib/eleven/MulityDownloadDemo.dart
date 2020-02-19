import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

/*
分块下载真的能提高下载速度吗？
其实下载速度的主要瓶颈是取决于网络速度和服务器的出口速度，如果是同一个数据源，分块下载的意义并不大，
因为服务器是同一个，出口速度确定的，主要取决于网速，而上面的例子正式同源分块下载，
读者可以自己对比一下分块和不分块的的下载速度。
如果有多个下载源，并且每个下载源的出口带宽都是有限制的，这时分块下载可能会更快一下，之所以说“可能”，
是由于这并不是一定的，比如有三个源，三个源的出口带宽都为1G/s，而我们设备所连网络的峰值假设只有800M/s，
那么瓶颈就在我们的网络。即使我们设备的带宽大于任意一个源，下载速度依然不一定就比单源单线下载快，
试想一下，假设有两个源A和B，速度A源是B源的3倍，如果采用分块下载，两个源各下载一半的话，
读者可以算一下所需的下载时间，然后再算一下只从A源下载所需的时间，看看哪个更快。

分块下载的最终速度受设备所在网络带宽、源出口速度、每个块大小、以及分块的数量等诸多因素影响，
实际过程中很难保证速度最优。在实际开发中，读者可可以先测试对比后再决定是否使用。

分块下载有什么实际的用处吗？
分块下载还有一个比较使用的场景是断点续传，可以将文件分为若干个块，然后维护一个下载状态文件用以记录每一个块的状态，
这样即使在网络中断后，也可以恢复中断前的状态，具体实现读者可以自己尝试一下，还是有一些细节需要特别注意的，
比如分块大小多少合适？下载到一半的块如何处理？要不要维护一个任务队列？
*/

class MulityDownloadRoute extends StatefulWidget {
  @override MulityDownloadRouteState createState() => MulityDownloadRouteState();
}

class MulityDownloadRouteState extends State<MulityDownloadRoute> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('分块下载'),
      ),
      body: RaisedButton(
        child: Text('开始下载'),
        onPressed: () {

          main() async {
            print('开始下载');
            var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
            var savePath = "./example/HBuilder.9.0.2.macosx_64.dmg";
            await downloadWithChunks(url, savePath,
                onReceiveProgress: (received, total) {
                  if (total != -1) {
                    print("${(received / total * 100).floor()}%");
                  }
                });
          }
        },
      ),
    );
  }

  /// Downloading by spiting as file in chunks
  Future downloadWithChunks(
    url,
    savePath, {
    ProgressCallback onReceiveProgress,
  }) async {
    const firstChunkSize = 102;
    const maxChunk = 3;

    int total = 0;
    var dio = Dio();
    var progress = <int>[];
    print('1231321');
    createCallback(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      progress.add(0);
      --end;
      return dio.download(
        url,
        savePath + "temp$no",
        onReceiveProgress: createCallback(no),
        options: Options(
          headers: {"range": "bytes=$start-$end"},
        ),
      );
    }

    Future mergeTempFiles(chunk) async {
      File f = File(savePath + "temp0");
      IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File _f = File(savePath + "temp$i");
        await ioSink.addStream(_f.openRead());
        await _f.delete();
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {
      total = int.parse(response.headers
          .value(HttpHeaders.contentRangeHeader)
          .split("/")
          .last);
      int reserved = total -
          int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }
}
