import 'package:flutter/material.dart';

// 总结
// 通过Switch和Checkbox我们可以看到，虽然它们本身是与状态（是否选中）关联的，但它们却不是自己来维护状态，而是需要父组件来管理状态，
// 然后当用户点击时，再通过事件通知给父组件，这样是合理的，因为Switch和Checkbox是否选中本就和用户数据关联，而这些用户数据也不可能是它们的私有状态。
// 我们在自定义组件时也应该思考一下哪种状态的管理方式最为合理。

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRouteState createState() =>
      new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单选框、复选框'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Switch(
              value: _switchSelected, //当前状态
              onChanged: (value) {
                //重新构建页面
                // 调用setState()通知Flutter framework重新构建UI
                //如果不调用setState则不会刷新界面
                setState(() {
                  _switchSelected = value;
                });
              },
            ),
            Checkbox(
              value: _checkboxSelected,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
