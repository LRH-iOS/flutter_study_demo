import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

/*
Dart IO库中提供了用于发起Http请求的一些类，我们可以直接使用HttpClient来发起请求。
使用HttpClient发起请求分为五步：
1、创建一个HttpClient：
HttpClient httpClient = new HttpClient();

2、打开Http连接，设置请求头：
HttpClientRequest request = await httpClient.getUrl(uri);
这一步可以使用任意Http Method，如httpClient.post(...)、httpClient.delete(...)等。
如果包含Query参数，可以在构建uri时添加，如：
Uri uri=Uri(scheme: "https", host: "flutterchina.club", queryParameters: {
  "xx":"xx",
  "yy":"dd"
});
通过HttpClientRequest可以设置请求header，如：
request.headers.add("user-agent", "test");

如果是post或put等可以携带请求体方法，可以通过HttpClientRequest对象发送request body，如：
String payload="...";
request.add(utf8.encode(payload));
//request.addStream(_inputStream); //可以直接添加输入流

3、等待连接服务器：
HttpClientResponse response = await request.close();
这一步完成后，请求信息就已经发送给服务器了，返回一个HttpClientResponse对象，
它包含响应头（header）和响应流(响应体的Stream)，接下来就可以通过读取响应流来获取响应内容。

4、读取响应内容：
String responseBody = await response.transform(utf8.decoder).join();
我们通过读取响应流来获取服务器返回的数据，在读取时我们可以设置编码格式，这里是utf8。

5、请求结束，关闭HttpClient：
httpClient.close();
关闭client后，通过该client发起的所有请求都会中止。
*/

/*
HttpClient配置
HttpClient有很多属性可以配置，常用的属性列表如下：
idleTimeout：	对应请求头中的keep-alive字段值，为了避免频繁建立连接，httpClient在请求结束后会保持连接一段时间，
超过这个阈值后才会关闭连接。

connectionTimeout：	和服务器建立连接的超时，如果超过这个值则会抛出SocketException异常。
maxConnectionsPerHost：	同一个host，同时允许建立连接的最大数量。
autoUncompress：	对应请求头中的Content-Encoding，如果设置为true，则请求头中Content-Encoding的值为当前HttpClient支持的压缩算法列表，目前只有"gzip"
userAgent：	对应请求头中的User-Agent字段。
可以发现，有些属性只是为了更方便的设置请求头，对于这些属性，你完全可以通过HttpClientRequest直接设置header，
不同的是通过HttpClient设置的对整个httpClient都生效，而通过HttpClientRequest设置的只对当前请求生效。
*/



class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => new _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('httpClient'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                  child: Text("获取百度首页"),
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() {
                            _loading = true;
                            _text = "正在请求...";
                          });
                          try {
                            //创建一个HttpClient
                            HttpClient httpClient = new HttpClient();
                            //打开Http连接
                            HttpClientRequest request = await httpClient
                                .getUrl(Uri.parse("https://www.baidu.com"));
                            //使用iPhone的UA
                            request.headers.add("user-agent",
                                "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                            //等待连接服务器（会将请求信息发送给服务器）
                            HttpClientResponse response = await request.close();
                            //读取响应内容
                            _text =
                                await response.transform(utf8.decoder).join();
                            //输出响应头
                            print(response.headers);

                            //关闭client后，通过该client发起的所有请求都会中止。
                            httpClient.close();
                          } catch (e) {
                            _text = "请求失败：$e";
                          } finally {
                            setState(() {
                              _loading = false;
                            });
                          }
                        }),
              Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  child: Text(_text.replaceAll(new RegExp(r"\s"), "")))
            ],
          ),
        ),
      ),
    );
  }
}
