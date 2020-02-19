import 'package:flutter/material.dart';
import 'CustomPartDemo.dart';
import 'CustomPaint、Canvas.dart';
import 'GradientCircularProgressDemo.dart';


class TenRoute extends StatefulWidget {
  @override
  _TenRouteState createState() => new _TenRouteState();
}

class _TenRouteState extends State<TenRoute> {

  final List<String> _titles = ['组合现有组件demo', 'CustomPaintRoute、Canvas',
    '自绘实例：圆形背景渐变进度条'];
  final List<Widget> _widgetArray = [GradientButtonRoute(), CustomPaintRoute(),
    GradientCircularProgressRoute()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义组件'),
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
//          FlatButton(
//            child: Text(_titles[3]),
//            textColor: Colors.red,
//            onPressed: () {
//              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                return _widgetArray[3];
//              }));
//            },
//          ),
//          FlatButton(
//            child: Text(_titles[4]),
//            textColor: Colors.red,
//            onPressed: () {
//              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                return _widgetArray[4];
//              }));
//            },
//          ),
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

