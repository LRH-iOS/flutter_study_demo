import 'package:flutter/material.dart';
import 'package:flutter_study_demo/eight/GestureRecognizerDemo.dart';
import 'ListenerDemo.dart';
import 'GestureDemo.dart';
import 'DragDemo.dart';
import 'ScaleDemo.dart';
import 'GestureDemo.dart';
import 'NotificationDemo.dart';
import 'CustomNotificationDemo.dart';

/*
事件处理与通知
Flutter中的手势系统有两个独立的层。第一层为原始指针(pointer)事件，它描述了屏幕上指针（例如，触摸、鼠标和触控笔）的位置和移动。 第二层为手势，描述由一个或多个指针移动组成的语义动作，如拖动、缩放、双击等。
*/
/*
Listener({
Key key,
this.onPointerDown, //手指按下回调
this.onPointerMove, //手指移动回调
this.onPointerUp,//手指抬起回调
this.onPointerCancel,//触摸事件取消回调
this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现
Widget child
})*/

class EightRoute extends StatefulWidget {
  @override
  _EightRouteState createState() => new _EightRouteState();
}

class _EightRouteState extends State<EightRoute> {

  final List<String> _titles = ['原始指针事件处理', '手势识别', '手势移动', '垂直滑动', '缩放',
    'GestureRecognizer', '通知', '自定义通知'];
  final List<Widget> _widgetArray = [ListenerRoute(), GestureDetectorTestRoute(), Drag(), DragVertical(),
    ScaleTestRoute(), GestureRecognizerTestRoute(), NotificationRoute(), CustomNotificationRoute()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('事件处理与通知'),
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
          FlatButton(
            child: Text(_titles[5]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[5];
              }));
            },
          ),
          FlatButton(
            child: Text(_titles[6]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[6];
              }));
            },
          ),
          FlatButton(
            child: Text(_titles[7]),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _widgetArray[7];
              }));
            },
          ),
        ],
      ),
    );
  }
}
