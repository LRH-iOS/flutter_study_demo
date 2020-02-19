import 'package:flutter/material.dart';
import 'package:flutter_study_demo/Second/SecondProjectDemo.dart';
import 'package:flutter_study_demo/Third/ThirdProjectDemo.dart';
import 'package:flutter_study_demo/Fourth/FourthProjectDemo.dart';
import 'package:flutter_study_demo/Fiveth/FivethProjectDemo.dart';
import 'package:flutter_study_demo/Sixth/SixProjectDemo.dart';
import 'package:flutter_study_demo/Seventh/SevenProjectDemo.dart';
import 'package:flutter_study_demo/eight/EightProjectDemo.dart';
import 'package:flutter_study_demo/night/NightProjectDemo.dart';
import 'package:flutter_study_demo/ten/TenProjectDemo.dart';
import 'package:flutter_study_demo/eleven/ElevenProjectDemo.dart';
import 'package:flutter_study_demo/twelve/TwelveProjectDemo.dart';
import 'package:flutter_study_demo/Thirdth/ThirdthProjectDemo.dart';
import 'package:flutter_study_demo/Fourteenth/FourteenthProjectDemo.dart';
import 'package:flutter_study_demo/fiveteenth/FiveteenthProject.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

      ),
      // 注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
        "test_page": (context) => TestRouter(),
        "block_page": (context) => TipRoute(text: "hahaha"),
        "block_page2": (context) {
          return TipRoute(text: ModalRoute.of(context).settings.arguments);
        },
        "/": (context) => MyHomePage(title: "首页"),
        "echo": (context) => EcRouter(),
      },

      //MaterialApp有一个onGenerateRoute属性，它在打开命名路由时可能会被调用，之所以说可能，
      //是因为当调用Navigator.pushNamed(...)打开命名路由时，如果指定的路由名在路由表中已注册，
      //则会调用路由表中的builder函数来生成路由组件；如果路由表中没有注册，才会调用onGenerateRoute来生成路由。
      //注意，onGenerateRoute只会对命名路由生效。
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
        });
      },
      //获得应用程序性能图
      //showPerformanceOverlay: true,
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      //显示屏幕网格
      //debugShowMaterialGrid: true,

      //debugShowCheckedModeBanner: true,
      //显示控件
      //showSemanticsDebugger: true,

      //默认设置主页
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("路由、包、资源管理、调试"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return SetupWidget(
                            title: "路由、包、资源管理、调试",
                          );
                        }));
              },
            ),
            FlatButton(
              child: Text("基础组件"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: false,
                    builder: (context) {
                      return CounterWidget();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("布局类组件"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return FourthProjectWidget();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("容器类组件"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return FivethWidget();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("滚动组件"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return SixWeight();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("功能性组件"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return SevenWeight();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("事件处理与通知"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return EightRoute();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("动画"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return NightRoute();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("自定义组件"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return TenRoute();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("文件操作和网络请求"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return ElevenRoute();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("包与插件"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return NightRoute();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("国际化"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return NightRoute();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("Flutter核心原理"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return NightRoute();
                    }
                ));
              },
            ),
            FlatButton(
              child: Text("一个完整的Flutter应用"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute (
                    fullscreenDialog: false,
                    builder: (context) {
                      return NightRoute();
                    }
                ));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
