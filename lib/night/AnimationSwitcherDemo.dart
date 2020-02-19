import 'package:flutter/material.dart';

/*
AnimatedSwitcher 可以同时对其新、旧子元素添加显示、隐藏动画。
也就是说在AnimatedSwitcher的子元素发生变化时，会对其旧元素和新元素，我们先看看AnimatedSwitcher 的定义：

const AnimatedSwitcher({
Key key,
this.child,
@required this.duration, // 新child显示动画时长
this.reverseDuration,// 旧child隐藏的动画时长
this.switchInCurve = Curves.linear, // 新child显示的动画曲线
this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
})
当AnimatedSwitcher的child发生变化时（类型或Key不同），旧child会执行隐藏动画，新child会执行执行显示动画。
究竟执行何种动画效果则由transitionBuilder参数决定，
该参数接受一个AnimatedSwitcherTransitionBuilder类型的builder，定义如下：
typedef AnimatedSwitcherTransitionBuilder =
Widget Function(Widget child, Animation<double> animation);
该builder在AnimatedSwitcher的child切换时会分别对新、旧child绑定动画：

对旧child，绑定的动画会反向执行（reverse）
对新child，绑定的动画会正向指向（forward）
这样一下，便实现了对新、旧child的动画绑定。AnimatedSwitcher的默认值是AnimatedSwitcher.defaultTransitionBuilder ：
Widget defaultTransitionBuilder(Widget child, Animation<double> animation) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}
可以看到，返回了FadeTransition对象，也就是说默认情况，AnimatedSwitcher会对新旧child执行“渐隐”和“渐显”动画。
*/

//注意：AnimatedSwitcher的新旧child，如果类型相同，则Key必须不相等。

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationSwitcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween =
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                return SlideTransitionX(
                  child: child,
                  direction: AxisDirection.down, //上入下出
                  position: animation,
                );
              },
              // 从左向右
              // 通过这种巧妙的方式实现了类似路由进场切换的动画，
              // 实际上Flutter路由切换也正是通过AnimatedSwitcher来实现的。
//            AnimatedSwitcher(
//              duration: Duration(milliseconds: 200),
//              transitionBuilder: (Widget child, Animation<double> animation) {
//                var tween = Tween<Offset>(
//                    begin: Offset(1, 0), end: Offset(0, 0));
//                return MySlideTransition(
//                  child: child,
//                  position: tween.animate(animation),
//                );
//              },
//        AnimatedSwitcher(
//              duration: const Duration(milliseconds: 500),
//              transitionBuilder: (Widget child, Animation<double> animation) {
//                //执行缩放动画
//                return ScaleTransition(child: child, scale: animation);
//              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              child: const Text(
                '+1',
              ),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//我们想实现一个类似路由平移切换的动画：旧页面屏幕中向左侧平移退出，新页面重屏幕右侧平移进入。
class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

//封装通用的SlideTransitionX 来实现这种“出入滑动动画”
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
