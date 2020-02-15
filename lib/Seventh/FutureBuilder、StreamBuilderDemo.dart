import 'package:flutter/material.dart';

/*
异步UI更新（FutureBuilder、StreamBuilder）
通过StatefulWidget我们完全可以实现上述这些功能。但由于在实际开发中依赖异步数据更新UI的这种场景非常常见，
因此Flutter专门提供了FutureBuilder和StreamBuilder两个组件来快速实现这种功能。
*/
/*
FutureBuilder会依赖一个Future，它会根据所依赖的Future的状态来动态构建自身。
FutureBuilder({
this.future,  FutureBuilder依赖的Future，通常是一个异步耗时任务。
this.initialData, 初始数据，用户设置默认数据。
@required this.builder, Widget构建器；该构建器会在Future执行的不同阶段被多次调用，构建器签名如下：
})
Function (BuildContext context, AsyncSnapshot snapshot)
snapshot会包含当前异步任务的状态信息及结果信息 ，
比如我们可以通过snapshot.connectionState获取异步任务的状态信息、
通过snapshot.hasError判断异步任务是否有错误等等，完整的定义读者可以查看AsyncSnapshot类定义。*/

/*enum ConnectionState {
  /// 当前没有异步任务，比如[FutureBuilder]的[future]为null时
  none,
  /// 异步任务处于等待状态
  waiting,
  /// Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
  active,
  /// 异步任务已经终止.
  done,
}
注意，ConnectionState.active只在StreamBuilder中才会出现*/

/* 在Dart中Stream 也是用于接收异步事件数据，和Future 不同的是，它可以接收多个异步操作的结果，
 * 它常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。
 * StreamBuilder正是用于配合Stream来展示流上事件（数据）变化的UI组件。
 * 下面看一下StreamBuilder的默认构造函数*/

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

//我们创建一个计时器的示例：每隔1秒，计数加1。这里，我们使用Stream来实现每隔一秒生成一个数字:
Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

class FutureAndStreamBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FutureBuilder、StreamBuilder'),
        ),
//      body: Center(
//        child: FutureBuilder<String>(
//          future: mockNetworkData(),
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            // 请求已结束
//            if (snapshot.connectionState == ConnectionState.done) {
//              if (snapshot.hasError) {
//                // 请求失败，显示错误
//                return Text("Error: ${snapshot.error}");
//              } else {
//                // 请求成功，显示数据
//                return Text("Contents: ${snapshot.data}");
//              }
//            } else {
//              // 请求未结束，显示loading
//              return CircularProgressIndicator();
//            }
//          },
//        ),
//      ),
        body: StreamBuilder<int>(
          stream: counter(), //
          //initialData: ,// a Stream<int> or null
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('没有Stream');
              case ConnectionState.waiting:
                return Text('等待数据...');
              case ConnectionState.active:
                return Text('active: ${snapshot.data}');
              case ConnectionState.done:
                return Text('Stream已关闭');
            }
            return null; // unreachable
          },
        ),
    );
  }
}
