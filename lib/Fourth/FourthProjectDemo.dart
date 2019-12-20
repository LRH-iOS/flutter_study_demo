import 'package:flutter/material.dart';
import 'RowColumnDemo.dart';
import 'FlexDemo.dart';
import 'WrapAndFlowDemo.dart';
import 'Stack、PositionedDemo.dart';
import 'AlignDemo.dart';

class FourthProjectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('布局类组件'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: Text('线性布局'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return RowColumnWidget();
              }));
            },
          ),
          FlatButton(
              child: Text('弹性布局Flex'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FlexWeight();
                }));
              }),
          FlatButton(
              child: Text('流式布局Wrap Flow'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return WrapAndFlowWeight();
                }));
              }),
          FlatButton(
              child: Text('层叠布局Stack Positioned'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return StackAndPositionedWeight();
                }));
              }),
          FlatButton(
              child: Text('对齐与相对定位Align'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AlignWeight();
                }));
              }),
        ],
      ),
    );
  }
}
