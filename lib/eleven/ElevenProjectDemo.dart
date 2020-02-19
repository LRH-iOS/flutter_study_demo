import 'package:flutter/material.dart';
import 'FileManagerDemo.dart';
import 'HttpClientDemo.dart';
import 'DioDemo.dart';
import 'MulityDownloadDemo.dart';
import 'WebSocketDemo.dart';

class ElevenRoute extends StatefulWidget {
  @override
  _ElevenRouteState createState() => new _ElevenRouteState();
}

class _ElevenRouteState extends State<ElevenRoute> {

  final List<String> _titles = ['文件操作', 'HttpClient', 'Dio', '分块下载', 'webSocket'];
  final List<Widget> _widgetArray = [FileOperationRoute(), HttpTestRoute(), FutureBuilderRoute(),
    MulityDownloadRoute(), WebSocketRoute()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('文件操作与网络请求'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text(_titles[0]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[0];
              }));
            },
          ),
          FlatButton(
            child: Text(_titles[1]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[1];
              }));
            },
          ),
          FlatButton(
            child: Text(_titles[2]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[2];
              }));
            },
          ),
          FlatButton(
            child: Text(_titles[3]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[3];
              }));
            },
          ),
          FlatButton(
            child: Text(_titles[4]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[4];
              }));
            },
          ),
//          FlatButton(
//            child: Text(_titles[5]),
//            textColor: Colors.red,
//            onPressed: () {
//              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                return _widgetArray[5];
//              }));
//            },
//          ),
//          FlatButton(
//            child: Text(_titles[6]),
//            textColor: Colors.red,
//            onPressed: () {
//              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                return _widgetArray[6];
//              }));
//            },
//          ),
//          FlatButton(
//            child: Text(_titles[7]),
//            textColor: Colors.red,
//            onPressed: () {
//              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                return _widgetArray[7];
//              }));
//            },
//          ),
        ],
      ),
    );
  }
}

