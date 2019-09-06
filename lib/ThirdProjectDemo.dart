import 'package:flutter/material.dart';

//基础组件


void main() => runApp(CounterWidget());

class CounterWidget extends StatefulWidget {

  const CounterWidget({Key key, this.initValue: 0});

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  //initState：当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter framework只会调用一次该回调
  //所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.initValue;
    print("initState");
  }

  @override
  // build()：此回调它主要是用于构建Widget子树的，会在如下场景被调用：
  // 在调用initState()之后。
  // 在调用didUpdateWidget()之后。
  // 在调用setState()之后。
  // 在调用didChangeDependencies()之后。
  // 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text('基础组件、生命周期'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed: () => setState(
            () => ++_counter,
          ),
        ),
      ),
    );
  }
//  Widget build(BuildContext context) {
//    return CounterWidget();
//  }

  @override
  // didUpdateWidget()：在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中同一位置的新旧节点，然后决定是否需要更新
  // 如果Widget.canUpdate返回true则会调用此回调。
  // 正如之前所述，Widget.canUpdate会在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时相等时didUpdateWidget()就会被调用。
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  // deactivate()：当State对象从树中被移除时，会调用此回调。
  // 在一些场景下，Flutter framework会将State对象重新插到树中，如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。
  // 如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  // dispose()：当State对象从树中被永久移除时调用；通常在此回调中释放资源
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  // reassemble()：此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  // didChangeDependencies()：当State对象的依赖发生变化时会被调用；
  // 例如：在之前build() 中包含了一个InheritedWidget，然后在之后的build() 中InheritedWidget发生了变化，那么此时InheritedWidget的子widget的didChangeDependencies()回调都会被调用。
  // 典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
