import 'package:flutter/material.dart';
import 'SingleChildScrollviewDemo.dart';
import 'ListViewDemo.dart';
import 'GridViewDemo.dart';
import 'CustomScrollViewDemo.dart';
import 'ScrollControllerDemo.dart';
import 'ScrollControllerNotificationDemo.dart';

// 还有一些如SliverPadding、SliverAppBar等是和可滚动组件无关的，
// 它们主要是为了结合CustomScrollView一起使用，这是因为CustomScrollView的子组件必须都是Sliver。

class SixWeight extends StatelessWidget {

  @override Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(
        title: Text('可滚动组件'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('SingleChildScrollView'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SingleChildScrollViewTestRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('ListView'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return InfiniteListView();
              }));
            },
          ),
          FlatButton(
            child: Text('GridView'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GridViewRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('CustomScrollView'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CustomScrollViewTestRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('ScrollController'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScrollControllerTestRoute();
              }));
            },
          ),
          FlatButton(
            child: Text('ScrollControllerNotification'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScrollNotificationTestRoute();
              }));
            },
          ),
        ],
      ),
    );
  }
}