import 'package:flutter/material.dart';
import 'WillPopScopeDemo.dart';
import 'InheritedWidgetDemo.dart';
import 'ProviderDemo.dart';
import 'ThemeDemo.dart';
import 'FutureBuilder、StreamBuilderDemo.dart';
import 'AlertDialogDemo.dart';

class SevenWeight extends StatefulWidget {
  @override
  _SevenWeightState createState() {
    return new _SevenWeightState();
  }
}

class _SevenWeightState extends State<SevenWeight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('功能性组件'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('导航返回拦截（WillPopScope）'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return WillPopScopeTestRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('数据共享（InheritedWidget）'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return InheritedWidgetTestRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('跨组件状态共享（Provider）'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ProviderRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('颜色和主题（Theme）'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ThemeRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('异步UI更新（FutureBuilder、StreamBuilder）'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FutureAndStreamBuilderRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('对话框详解'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AlertDialogRoute();
              }));
            },
          ),
        ],
      ),
    );
  }
}
