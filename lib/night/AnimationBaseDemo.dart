import 'package:flutter/material.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>  with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;
//
//  initState() {
//
//    super.initState();
//
//    controller = new AnimationController(
//        duration: const Duration(seconds: 3), vsync: this);
//    //使用弹性曲线
//    //animation=CurvedAnimation(parent: controller, curve: Curves.bounceIn);
//    //animation = new Tween(begin: 0.0, end: 300.0).animate(animation)
//
//    //图片宽高从0变到300
//    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
//      ..addListener(() {
//        setState(()=>{});
//      });
//    //启动动画(正向执行)
//    controller.forward();
//  }

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画（正向）
    controller.forward();
  }

//  @override
//  Widget build(BuildContext context) {
//
//    return new Center(
//      child: Image.asset("./images/1.png",
//          width: animation.value,
//          height: animation.value
//      ),
//    );
//  }
  // 封装后
//  @override Widget build(BuildContext context) {
//    return AnimatedImage(animation: animation);
//  }
  @override
  Widget build(BuildContext context) {
    return GrowTransition(
      child: Image.asset("./images/1.png"),
      animation: animation,
    );
  }

  // AnimatedBuilder将渲染逻辑分离出来
//  @override
//  Widget build(BuildContext context) {
//    //return AnimatedImage(animation: animation,);
//    return AnimatedBuilder(
//      animation: animation,
//      child: Image.asset("./images/1.png"),
//      builder: (BuildContext ctx, Widget child) {
//        return new Center(
//          child: Container(
//            height: animation.value,
//            width: animation.value,
//            child: child,
//          ),
//        );
//      },
//    );
//  }


  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}


/*
使用AnimatedWidget简化
细心的读者可能已经发现上面示例中通过addListener()和setState() 来更新UI这一步其实是通用的，
如果每个动画中都加这么一句是比较繁琐的。
AnimatedWidget类封装了调用setState()的细节，并允许我们将widget分离出来，重构后的代码如下
*/
//AnimatedWidget从动画中分离出widget
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset("./images/1.png",
          width: animation.value,
          height: animation.value
      ),
    );
  }
}

// 通过AnimatedBuilder可以封装常见的过渡效果来复用动画。
// 下面我们通过封装一个GrowTransition来说明，它可以对子widget实现放大动画：
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value,
                width: animation.value,
                child: child
            );
          },
          child: child
      ),
    );
  }
}