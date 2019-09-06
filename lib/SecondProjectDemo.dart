import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:developer'; //debugger() 声明
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart' show rootBundle;

/*
最好统一使用命名路由的管理方式，这将会带来如下好处：
1、语义化更明确。
2、代码更好维护；如果使用匿名路由，则必须在调用Navigator.push的地方创建新路由页，这样不仅需要import新路由页的dart文件，而且这样的代码将会非常分散。
3、可以通过onGenerateRoute做一些全局的路由跳转前置处理逻辑。
*/

/*加载文本assets
  通过rootBundle 对象加载：
  每个Flutter应用程序都有一个rootBundle对象， 通过它可以轻松访问主资源包，
  直接使用package:flutter/services.dart中全局静态的rootBundle对象来加载asset即可。
*/

void main() => runApp(SetupWidget());

class SetupWidget extends StatefulWidget {
  SetupWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.red,
              onPressed: () {
                //导航-跳转
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: false,
                        builder: (context) {
                          return NewRoute();
                        }));
              },
            ),
            FlatButton(
              child: Text("传值-回调"),
              textColor: Colors.blue,
              onPressed: () async {
                //打开新的页面，并等待返回结果
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TipRoute(
                        //路由参数
                        text: "我的数据xxx",
                      );
                    },
                  ),
                );
                //输出结果
                print("路由结果:$result");
              },
            ),
            FlatButton(
              child: Text("通过已注册的路由跳转"),
              textColor: Colors.orange,
              onPressed: () {
                //导航-跳转
                Navigator.pushNamed(context, "block_page");
              },
            ),
            FlatButton(
              child: Text("命名路由参数传递"),
              textColor: Colors.purple,
              onPressed: () {
                //导航-跳转
                Navigator.of(context).pushNamed("echo", arguments: "hello");
              },
            ),
            FlatButton(
              child: Text("命名路由参数传递-不改变原来结构体"),
              textColor: Colors.purple,
              onPressed: () {
                //导航-跳转
                Navigator.of(context)
                    .pushNamed("block_page2", arguments: "bloppp");
              },
            ),
            FlatButton(
              child: Text("debug-调试应用程序层"),
              textColor: Colors.yellow,
              onPressed: () {
                //转储Widgets库的状态
                debugDumpApp();
              },
            ),
            FlatButton(
              child: Text("debug-调试渲染层"),
              textColor: Colors.red,
              onPressed: () {
                //转储Widgets库的状态
                debugDumpRenderTree();
              },
            ),
            FlatButton(
              child: Text("debug-调试合成"),
              textColor: Colors.red,
              onPressed: () {
                //转储Widgets库的状态
                debugDumpLayerTree();
              },
            ),
            FlatButton(
              child: Text("可视化调试"),
              textColor: Colors.red,
              onPressed: () {
                debugPaintSizeEnabled = true;
                debugPaintBaselinesEnabled = true;
                debugPaintPointersEnabled = true;
                debugPaintLayerBordersEnabled = true;
                debugRepaintRainbowEnabled = true;
              },
            ),
            RandomWordsWidget(),
          ],
        ),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route"),
      ),
      body: Center(
        child: Text("this is a new route"),
      ),
    );
  }
}

class TestRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("test page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            //打开新的页面，并等待返回结果
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TipRoute(
                    //路由参数
                    text: "我的数据xxx",
                  );
                },
              ),
            );
            //输出结果
            print("路由结果:$result");
          },
          child: Text("打开提示页"),
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("第三个页面"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回的数据"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EcRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var args = ModalRoute.of(context).settings.arguments;
    var name = ModalRoute.of(context).settings.name;

    print("路由结果111:$args");

    return Scaffold(
      appBar: AppBar(
        title: Text("Echo Route"),
      ),
      body: Center(
        child: Text("this is a new route"),
      ),
    );
  }
}

//生成随机字符
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair = new WordPair.random();

    //debugger(when: true);

    //间隔
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Text(wordPair.toString()),
    );
  }
}

/* 加载图片 */
//使用默认的 asset bundle 加载资源时，内部会自动处理分辨率等，这些处理对开发者来说是无感知的。
//(如果使用一些更低级别的类，如 ImageStream或 ImageCache 时你会注意到有与缩放相关的参数)
class LoadImageWidget extends StatelessWidget {
  @override
  //要加载图片，可以使用 AssetImage类。例如，我们可以从上面的asset声明中加载背景图片：
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('graphics/background.png'),
        ),
      ),
    );
  }

//  注意，AssetImage 并非是一个widget， 它实际上是一个ImageProvider
//  有些时候你可能期望直接得到一个显示图片的widget，那么你可以使用Image.asset()方法，如：
//  Widget build(BuildContext context) {
//    return Image.asset('graphics/background.png');
//  }

//  要加载依赖包中的图像，必须给AssetImage提供package参数。
//  例如，假设您的应用程序依赖于一个名为“my_icons”的包，它具有如下目录结构
//  …/pubspec.yaml
//  …/icons/heart.png
//  new AssetImage('icons/heart.png', package: 'my_icons')
//  new Image.asset('icons/heart.png', package: 'my_icons')
}

//加载文本assets
//通常，可以使用DefaultAssetBundle.of()在应用运行时来间接加载asset（例如JSON文件），
//而在widget上下文之外，或其它AssetBundle句柄不可用时，可以使用rootBundle直接加载这些asset，
//例如:
Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
