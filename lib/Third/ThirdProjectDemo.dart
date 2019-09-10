import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //Cupertino组件
import 'StateManager.dart';
import 'TextStudyDemo.dart';
import 'ButtonStudyDemo.dart';
import 'ImageStudyDemo.dart';
import 'SwitchStudyDemo.dart';
import 'FormAndTextField.dart';
import 'ProgressStudyDemo.dart';

//《基础组件》
//Text：该组件可让您创建一个带格式的文本。
//Row、 Column： 这些具有弹性空间的布局类Widget可让您在水平（Row）和垂直（Column）方向上创建灵活的布局。其设计是基于Web开发中的Flexbox布局模型。
//Stack： 取代线性布局 (译者语：和Android中的FrameLayout相似)，Stack允许子 widget 堆叠， 你可以使用 Positioned 来定位他们相对于Stack的上下左右四条边的位置。
//       Stacks是基于Web开发中的绝对定位（absolute positioning )布局模型设计的。
//Container： Container 可让您创建矩形视觉元素。container 可以装饰一个BoxDecoration, 如 background、一个边框、或者一个阴影。
//            Container 也可以具有边距（margins）、填充(padding)和应用于其大小的约束(constraints)。另外， Container可以使用矩阵在三维空间中对其进行变换。

//《Material组件》
// Flutter提供了一套丰富的Material组件，它可以帮助我们构建遵循Material Design设计规范的应用程序。
// Material应用程序以MaterialApp 组件开始， 该组件在应用程序的根部创建了一些必要的组件，比如Theme组件，它用于配置应用的主题。
// 是否使用MaterialApp完全是可选的，但是使用它是一个很好的做法。
// 在之前的示例中，我们已经使用过多个Material 组件了，如：Scaffold、AppBar、FlatButton等。要使用Material 组件，需要先引入它：
// import 'package:flutter/material.dart';

// 《Cupertino组件》
// Flutter也提供了一套丰富的Cupertino风格的组件，尽管目前还没有Material 组件那么丰富，但是它仍在不断的完善中。
// 值得一提的是在Material 组件库中有一些组件可以根据实际运行平台来切换表现风格，
// 比如MaterialPageRoute，在路由切换时，如果是Android系统，它将会使用Android系统默认的页面切换动画(从底向上)；
// 如果是iOS系统，它会使用iOS系统默认的页面切换动画（从右向左）。

void main() => runApp(CounterWidget());

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  /* 
     《GlobalKey》 是Flutter提供的一种在整个APP中引用element的机制。
     如果一个widget设置了GlobalKey，那么我们便可以通过globalKey.currentWidget获得该widget对象、globalKey.currentElement来获得widget对应的element对象
     如果当前widget是StatefulWidget，则可以通过globalKey.currentState来获得该widget对应的state对象。
     注意：使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复
   */
  // 方法三：Flutter还有一种通用的获取State对象的方法——通过GlobalKey来获取！
  // 步骤分两步：
  // 第1步：给目标StatefulWidget添加GlobalKey
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

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
      // 第2步：通过GlobalKey来获取State对象
      key: _globalKey, //设置key
      appBar: AppBar(
        title: Text('基础组件、生命周期'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Text('$_counter'),
              //点击后计数器自增
              onPressed: () => setState(
                () => ++_counter,
              ),
            ),
            RaisedButton(
              child: Text('显示SnackBar'),
              onPressed: () {
                //获取state三种方法：
                // 方法一：查找父级最近的Scaffold对应的ScaffoldState对象
                //ScaffoldState _state = context.ancestorStateOfType(TypeMatcher<ScaffoldState>());

                // 在Flutter开发中便有了一个默认的约定：
                // 如果StatefulWidget的状态是希望暴露出的，应当在StatefulWidget中提供一个of静态方法来获取其State对象，开发者便可直接通过该方法来获取；
                // 如果State不希望暴露，则不提供of方法

                // 方法二：直接通过of静态方法来获取ScaffoldState
                ScaffoldState _state = Scaffold.of(context);

                //调用ScaffoldState的showSnackBar来弹出SnackBar
                _state.showSnackBar(
                  SnackBar(
                    content: Text('我是SnackBar'),
                  ),
                );
              },
            ),
            FlatButton(
              child: Text('Cupertino组件'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return CupertinoTestRoute();
                }));
              },
            ),
            FlatButton(
              child: Text('Widget状态管理'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return TapboxA();
                }));
              },
            ),
            FlatButton(
              child: Text('Text'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return TextStudyWidget();
                }));
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.info),
              label: Text("按钮"),
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ButtonStudyWidget();
                }));
              }
            ),
            RaisedButton.icon(onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return ImageStudyWidget();
              }));
            }, icon: Icon(Icons.access_time), label: Text('Image')),
            FlatButton.icon(
                icon: Icon(Icons.info),
                label: Text("单选框、复选框"),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) {
                    return SwitchAndCheckBoxTestRoute();
                  }));
                }
            ),
            FlatButton(
              child: Text('输入框'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return TextFieldStudyWidget(title: '输入框、表单',);//FocusTestRoute();
                }));
              },
            ),
            FlatButton(
              child: Text('表单'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return FormTestRoute();//FocusTestRoute();
                }));
              },
            ),
            FlatButton(
              child: Text('进度条'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ProgressTestWidget();//FocusTestRoute();
                }));
              },
            ),
          ],
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

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoButton(
              child: Text('Press'),
              color: CupertinoColors.activeBlue,
              onPressed: () {
                print('点击了按钮');
              }),
          Text(
              'Flutter也提供了一套丰富的Cupertino风格的组件，尽管目前还没有Material 组件那么丰富，但是它仍在不断的完善中。'
              '值得一提的是在Material 组件库中有一些组件可以根据实际运行平台来切换表现风格，比如MaterialPageRoute，在路由切换时，'
              '如果是Android系统，它将会使用Android系统默认的页面切换动画(从底向上)；'
              '如果是iOS系统，它会使用iOS系统默认的页面切换动画（从右向左）',
              style: new TextStyle(fontSize: 14.0, color: Colors.purple)),
        ],
      )),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Demo'),
      ),
    );
  }
}
