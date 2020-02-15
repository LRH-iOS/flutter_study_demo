import 'package:flutter/material.dart';

/*
如何将颜色字符串转成Color对象
如Web开发中的色值通常是一个字符串如"#dc380d"，它是一个RGB值，我们可以通过下面这些方法将其转为Color类：
Color(0xffdc380d); //如果颜色固定可以直接使用整数值
//颜色是一个字符串变量
var c = "dc380d";
Color(int.parse(c,radix:16)|0xFF000000) //通过位运算符将Alpha设置为FF
Color(int.parse(c,radix:16)).withAlpha(255)  //通过方法将Alpha设置为FF*/

//Color类中提供了一个computeLuminance()方法，它可以返回一个[0-1]的一个值，数字越大颜色就越浅，

/* MaterialColor是实现Material Design中的颜色的类，它包含一种颜色的10个级别的渐变色。
 * MaterialColor通过"[]"运算符的索引值来代表颜色的深度，
 * 有效的索引有：50，100，200，…，900，数字越大，颜色越深。
 * MaterialColor的默认值为索引等于500的颜色。举个例子，Colors.blue是预定义的一个MaterialColor*/

/* ThemeData用于保存是Material 组件库的主题数据，
Material组件需要遵守相应的设计规范，而这些规范可自定义部分都定义在ThemeData中了，
所以我们可以通过ThemeData来自定义应用主题。在子组件中，我们可以通过Theme.of方法来获取当前的ThemeData。*/
/*ThemeData({
Brightness brightness, //深色还是浅色
MaterialColor primarySwatch, //主题颜色样本，见下面介绍
Color primaryColor, //主色，决定导航栏颜色
Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
Color cardColor, //卡片颜色
Color dividerColor, //分割线颜色
ButtonThemeData buttonTheme, //按钮主题
Color cursorColor, //输入框光标颜色
Color dialogBackgroundColor,//对话框背景颜色
String fontFamily, //文字字体
TextTheme textTheme,// 字体主题，包括标题、body等文字样式
IconThemeData iconTheme, // Icon的默认样式
TargetPlatform platform, //指定平台，应用特定平台控件风格
...
})*/

//颜色亮度
class NavBar extends StatelessWidget {
  final String title;
  final Color color; //背景颜色

  NavBar({
    Key key,
    this.color,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
//阴影
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //根据背景色亮度来确定Title颜色
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}

// 我们实现一个路由换肤功能：
class ThemeRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => new _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeRoute> {
  Color _themeColor = Colors.teal; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
          ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NavBar(color: Colors.blue[100], title: "标题"),
//背景为白色，则title自动为黑色
            NavBar(color: Colors.blue[200], title: "标题"),
            NavBar(color: Colors.blue[500], title: "标题"),
            NavBar(color: Colors.blue[900], title: "标题"),
            NavBar(color: Colors.white, title: "标题"),

            //第一行Icon使用主题中的iconTheme
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(Icons.favorite),
              Icon(Icons.airport_shuttle),
              Text("  颜色跟随主题")
            ]),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色")
                  ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => //切换主题
                setState(() => _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal),
            child: Icon(Icons.palette)),
      ),
    );
  }
}
