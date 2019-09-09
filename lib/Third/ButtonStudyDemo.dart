/*const FlatButton({
...
@required this.onPressed, //按钮点击回调
this.textColor, //按钮文字颜色
this.disabledTextColor, //按钮禁用时的文字颜色
this.color, //按钮背景颜色
this.disabledColor,//按钮禁用时的背景颜色
this.highlightColor, //按钮按下时的背景颜色
this.splashColor, //点击时，水波动画中水波的颜色
this.colorBrightness,//按钮主题，默认是浅色主题
this.padding, //按钮的填充
this.shape, //外形
@required this.child, //按钮的内容
})*/

// Flutter 中没有提供去除背景的设置，假若我们需要去除背景，则可以通过将背景颜色设置为全透明来实现。
// 对应上面的代码，便是将 color: Colors.blue 替换为 color: Color(0x000000)。

// 按钮类型
// RaisedButton  即"漂浮"按钮，它默认带有阴影和灰色背景
// FlatButton    即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色
// OutlineButton 默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
// IconButton    是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景，

//RaisedButton、FlatButton、OutlineButton都有一个icon 构造函数，通过它可以轻松创建带图标的按钮，


import 'package:flutter/material.dart';

class ButtonStudyWidget extends StatelessWidget {

  void _onPressed() {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("normal"),
              onPressed: () {},
            ),
            FlatButton(
              child: Text("normal"),
              onPressed: () {},
            ),
            OutlineButton(
              child: Text("normal"),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            RaisedButton.icon(
              icon: Icon(Icons.send),
              label: Text("发送"),
              onPressed: _onPressed,
            ),
            OutlineButton.icon(
              icon: Icon(Icons.add),
              label: Text("添加"),
              onPressed: _onPressed,
            ),
            FlatButton.icon(
              icon: Icon(Icons.info),
              label: Text("详情"),
              onPressed: _onPressed,
            )
          ],
        ),
      ),
    );
  }
}
