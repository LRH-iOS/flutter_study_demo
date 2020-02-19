import 'package:flutter/material.dart';

// 如果我们封装的是StatefulWidget，那么一定要注意在组件更新时是否需要同步状态
// 当我们在State中会缓存某些依赖Widget参数的数据时，一定要注意在组件更新时是否需要同步状态。
class MyRichText extends StatefulWidget {
  MyRichText({
    Key key,
    this.text, // 文本字符串
    this.linkStyle, // url链接样式
  }) : super(key: key);

  final String text;
  final TextStyle linkStyle;

  @override
  _MyRichTextState createState() => _MyRichTextState();
}

class _MyRichTextState extends State<MyRichText> {

  TextSpan _textSpan;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _textSpan,
    );
  }
  /* 由于解析文本字符串，构建出TextSpan是一个耗时操作，为了不在每次build的时候都解析一次，
   所以我们在initState中对解析的结果进行了缓存，然后再build中直接使用解析的结果_textSpan。
   这看起来很不错，但是上面的代码有一个严重的问题，就是父组件传入的text发生变化时（组件树结构不变），
   那么MyRichText显示的内容不会更新，原因就是initState只会在State创建时被调用，
   所以在text发生变化时，parseText没有重新执行，导致_textSpan任然是旧的解析值。
   要解决这个问题也很简单，我们只需添加一个didUpdateWidget回调，然后再里面重新调用parseText即可：*/
  @override
  void didUpdateWidget(MyRichText oldWidget) {
    if (widget.text != oldWidget.text) {
      _textSpan = parseText(widget.text);
    }
    super.didUpdateWidget(oldWidget);
  }


  TextSpan parseText(String text) {
    // 耗时操作：解析文本字符串，构建出TextSpan。
    // 省略具体实现。
  }

  @override
  void initState() {
    _textSpan = parseText(widget.text);
    super.initState();
  }
}