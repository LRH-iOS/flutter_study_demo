import 'package:flutter/material.dart';


// fontSize：该属性和Text的textScaleFactor都用于控制字体大小。但是有两个主要区别：
// fontSize可以精确指定字体大小，而textScaleFactor只能通过缩放比例来控制。
// textScaleFactor主要是用于系统字体大小设置改变时对Flutter应用字体进行全局调整，而fontSize通常用于单个文本，字体大小不会跟随系统字体大小变化。
// TextSpan:富文本


class TextStudyWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    DefaultTextStyle(
      //1.设置文本默认样式
      style: TextStyle(
        color:Colors.red,
        fontSize: 20.0,
      ),
      textAlign: TextAlign.start,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("hello world"),
          Text("I am Jack"),
          Text("I am Jack",
            style: TextStyle(
                inherit: false, //2.不继承默认样式
                color: Colors.grey
            ),
          ),
        ],
      ),
    );

    // 要使用Package中定义的字体，必须提供package参数。例如，假设上面的字体声明位于my_package包中。然后创建TextStyle的过程如下：
    const textStyle = const TextStyle(
      fontFamily: 'Raleway',
      package: 'my_package', //指定包名
    );

    return Scaffold (

      appBar: AppBar(
        title: Text('Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello', textAlign: TextAlign.left),
            //TextOverflow 截断方式  TextOverflow.ellipsis，它会将多余文本截断后以省略符“...”
            //TextStyle用于指定文本显示的样式如颜色、字体、粗细、背景等
            Text(' hello world' * 6, maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20), textAlign: TextAlign.left,),
            Text('my name is xxx', textScaleFactor: 2.5), //倍数大小
            Text.rich(TextSpan(
                children: [
                  TextSpan(
                      text: "Home: "
                  ),
                  TextSpan(
                      text: "https://flutterchina.club",
                      style: TextStyle(
                          color: Colors.blue
                      ),
                      //recognizer: _tapRecognizer
                  ),
                ]
            )),
            Text('默认格式字体', style: TextStyle(inherit: false, color: Colors.purple))
          ],
        ),
      ),
    );
  }
}