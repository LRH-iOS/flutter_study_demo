import 'package:flutter/material.dart';
import 'AnimationBaseDemo.dart';
import 'HeroAnimationDemo.dart';
import 'StaggerAnimationDemo.dart';


class NightRoute extends StatefulWidget {
  @override
  _NightRouteState createState() => new _NightRouteState();
}

class _NightRouteState extends State<NightRoute> {

  final List<String> _titles = ['动画结构', 'Hero', '交织动画'];
  final List<Widget> _widgetArray = [ScaleAnimationRoute(), HeroAnimationRoute(), StaggerRoute()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
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

