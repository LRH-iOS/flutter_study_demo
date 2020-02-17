import 'package:flutter/material.dart';

// 普通push页面
/*
Navigator.push(context, CupertinoPageRoute(
builder: (context)=>PageB(),
));
CupertinoPageRoute是Cupertino组件库提供的iOS风格的路由切换组件，它实现的就是左右滑动切换。
那么我们如何来自定义路由切换动画呢？答案就是PageRouteBuilder。
下面我们来看看如何使用PageRouteBuilder来自定义路由切换动画。例如我们想以渐隐渐入动画来实现路由过渡，实现代码如下：
*/
/*
Navigator.push(
context,
PageRouteBuilder(
transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
pageBuilder: (BuildContext context, Animation animation,
Animation secondaryAnimation) {
return new FadeTransition(
//使用渐隐渐入过渡,
opacity: animation,
child: PageB(), //路由B
);
},
),
);*/
/*我们可以看到pageBuilder 有一个animation参数，这是Flutter路由管理器提供的，
在路由切换时pageBuilder在每个动画帧都会被回调，因此我们可以通过animation对象来自定义过渡动画。
无论是MaterialPageRoute、CupertinoPageRoute，还是PageRouteBuilder，它们都继承自PageRoute类，
而PageRouteBuilder其实只是PageRoute的一个包装，我们可以直接继承PageRoute类来实现自定义路由，
上面的例子可以通过如下方式实现：*/

// 这样直接用自己封装的跳转动画
/*
Navigator.push(context, FadeRoute(builder: (context) {
return PageB();
}));*/


class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) => builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //举个例子，假如我们只想在打开新路由时应用动画，而在返回时不使用动画，
    // 那么我们在构建过渡动画时就必须判断当前路由isActive属性是否为true
//    //当前路由被激活，是打开新路由
//    if(isActive) {
//      return FadeTransition(
//        opacity: animation,
//        child: builder(context),
//      );
//    }else{
//      //是返回，则不应用过渡动画
//      return Padding(padding: EdgeInsets.zero);
//    }

    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}
