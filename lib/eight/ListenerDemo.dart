import 'package:flutter/material.dart';

/*
参数PointerDownEvent、PointerMoveEvent、PointerUpEvent都是PointerEvent的一个子类，
PointerEvent类中包括当前指针的一些信息，如：
position：它是鼠标相对于当对于全局坐标的偏移。
delta：两次指针移动事件（PointerMoveEvent）的距离。
pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
orientation：指针移动方向，是一个角度值。
*/

/*
behavior属性，它决定子组件如何响应命中测试，它的值类型为HitTestBehavior，这是一个枚举类，有三个枚举值：
deferToChild：子组件会一个接一个的进行命中测试，如果子组件中有测试通过的，则当前组件通过，
这就意味着，如果指针事件作用于子组件上时，其父级组件也肯定可以收到该事件。
opaque：在命中测试时，将当前组件当成不透明处理(即使本身是透明的)，最终的效果相当于当前Widget的整个区域都是点击区域。
translucent：当点击组件透明区域时，可以对自身边界内及底部可视区域都进行命中测试，
这意味着点击顶部组件透明区域时，顶部组件和底部组件都可以接收到事件
*/

class ListenerRoute extends StatefulWidget {
  @override
  _ListenerRouteState createState() => new _ListenerRouteState();
}

class _ListenerRouteState extends State<ListenerRoute> {
  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('原始指针事件处理'),
        ),
        body: Column(
          children: <Widget>[
            Listener(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 300.0,
                height: 150.0,
                child: Text(_event?.toString() ?? "",
                    style: TextStyle(color: Colors.white)),
              ),
              onPointerDown: (PointerDownEvent event) =>
                  setState(() => _event = event),
              onPointerMove: (PointerMoveEvent event) =>
                  setState(() => _event = event),
              onPointerUp: (PointerUpEvent event) =>
                  setState(() => _event = event),
            ),
            //behavior的三个值
            Stack(
              children: <Widget>[
                Listener(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.blue)),
                  ),
                  onPointerDown: (event) => print("down0"),
                ),
                Listener(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                    child: Center(
                        child: Text(
                      "左上角200*100范围内非文本区域点击",
                      style: TextStyle(
                        backgroundColor: Colors.red,
                      ),
                    )),
                  ),
                  onPointerDown: (event) => print("down1"),
                  behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
                )
              ],
            ),
            //忽略PointerEvent
            // 点击Container时，由于它在AbsorbPointer的子树上，所以不会响应指针事件，所以日志不会输出"in"，
            // 但AbsorbPointer本身是可以接收指针事件的，所以会输出"up"。
            // 如果将AbsorbPointer换成IgnorePointer，那么两个都不会输出
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 200.0,
                    height: 100.0,
                  ),
                  onPointerDown: (event)=>print("in"),
                ),
              ),
              onPointerDown: (event)=>print("up"),
            ),
          ],
        ));
  }
}
