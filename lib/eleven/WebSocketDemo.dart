import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/* WebSocket协议本质上是一个基于tcp的协议，它是先通过HTTP协议发起一条特殊的http请求进行握手后，
 * 如果服务端支持WebSocket协议，则会进行协议升级。
 * WebSocket会使用http协议握手后创建的tcp链接，和http协议不同的是，WebSocket的tcp链接是个长链接（不会断开），
 * 所以服务端与客户端就可以通过此TCP连接进行实时通信。
 * 有关WebSocket协议细节，读者可以看RFC文档，下面我们重点看看Flutter中如何使用WebSocket。*/

/*
步骤:
1、连接到WebSocket服务器。
2、监听来自服务器的消息。
3、将数据发送到服务器。
4、关闭WebSocket连接。

1. 连接到WebSocket服务器
web_socket_channel package 提供了我们需要连接到WebSocket服务器的工具。
该package提供了一个WebSocketChannel允许我们既可以监听来自服务器的消息，又可以将消息发送到服务器的方法。
在Flutter中，我们可以创建一个WebSocketChannel连接到一台服务器：
final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

2. 监听来自服务器的消息
现在我们建立了连接，我们可以监听来自服务器的消息，在我们发送消息给测试服务器之后，它会返回相同的消息。
我们如何收取消息并显示它们？在这个例子中，我们将使用一个StreamBuilder 来监听新消息， 并用一个Text来显示它们。
new StreamBuilder(
stream: widget.channel.stream,
builder: (context, snapshot) {
return new Text(snapshot.hasData ? '${snapshot.data}' : '');
},
);
工作原理
WebSocketChannel提供了一个来自服务器的消息Stream 。该Stream类是dart:async包中的一个基础类。
它提供了一种方法来监听来自数据源的异步事件。与Future返回单个异步响应不同，Stream类可以随着时间推移传递很多事件。
该StreamBuilder 组件将连接到一个Stream， 并在每次收到消息时通知Flutter重新构建界面。

3. 将数据发送到服务器
为了将数据发送到服务器，我们会add消息给WebSocketChannel提供的sink。
channel.sink.add('Hello!');
工作原理
WebSocketChannel提供了一个StreamSink，它将消息发给服务器。
StreamSink类提供了给数据源同步或异步添加事件的一般方法。

4. 关闭WebSocket连接
在我们使用WebSocket后，要关闭连接：
channel.sink.close();
*/

class WebSocketRoute extends StatefulWidget {
  @override
  _WebSocketRouteState createState() => new _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";


  @override
  void initState() {
    //创建websocket连接
    channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WebSocket(内容回显)"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: new TextFormField(
                controller: _controller,
                decoration: new InputDecoration(labelText: 'Send a message'),
              ),
            ),
            new StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                //网络不通会走到这
                if (snapshot.hasError) {
                  _text = "网络不通...";
                } else if (snapshot.hasData) {
                  _text = "echo: "+snapshot.data;
                }
                return new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: new Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: new Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
