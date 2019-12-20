import 'package:flutter/material.dart';
import 'PaddingDemo.dart';
import 'BoxDemo.dart';
import 'DecoratedBoxDemo.dart';
import 'TransformDemo.dart';
import 'ContainerDemo.dart';
import 'ScaffoldAndTabBarDemo.dart';
import 'ClipDemo.dart';

class FivethWidget extends StatelessWidget {

  @override Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      appBar: AppBar(
        title: Text('容器类组件'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('填充 Padding'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PaddingWidget();
              }));
            },
          ),
          FlatButton(
            child: Text('尺寸限制类容器'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BoxWidget();
              }));
            },
          ),
          FlatButton(
            child: Text('装饰容器DecoratedBox'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DecoratedBoxWidget();
              }));
            },
          ),
          FlatButton(
            child: Text('变换（Transform）'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TransformWidget();
              }));
            },
          ),
          FlatButton(
            child: Text('容器 Container'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ContainerWidget();
              }));
            },
          ),
          FlatButton(
            child: Text('Scaffold、TabBar、底部导航'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScaffoldAndTabbarWidget();
              }));
            },
          ),
          FlatButton(
            child: Text('剪裁（Clip）'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ClipWidget();
              }));
            },
          ),
        ],
      ),
    );
  }
}