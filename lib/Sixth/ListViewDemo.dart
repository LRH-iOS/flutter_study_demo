import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
/*
ListView是最常用的可滚动组件之一，它可以沿一个方向线性排布所有子组件，并且它也支持基于Sliver的延迟构建模型。我们看看ListView的默认构造函数定义：

ListView({
...
//可滚动widget公共参数
Axis scrollDirection = Axis.vertical,
bool reverse = false,
ScrollController controller,
bool primary,
ScrollPhysics physics,
EdgeInsetsGeometry padding,

//ListView各个构造函数的共同参数
double itemExtent,
bool shrinkWrap = false,
bool addAutomaticKeepAlives = true,
bool addRepaintBoundaries = true,
double cacheExtent,

//子widget列表
List<Widget> children = const <Widget>[],
})
上面参数分为两组：第一组是可滚动组件的公共参数，本章第一节中已经介绍过，不再赘述；第二组是ListView各个构造函数（ListView有多个构造函数）的共同参数，我们重点来看看这些参数，：

itemExtent：该参数如果不为null，则会强制children的“长度”为itemExtent的值；这里的“长度”是指滚动方向上子组件的长度，也就是说如果滚动方向是垂直方向，则itemExtent代表子组件的高度；如果滚动方向为水平方向，则itemExtent就代表子组件的宽度。在ListView中，指定itemExtent比让子组件自己决定自身长度会更高效，这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，而无需每次构建子组件时都去再计算一下，尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。
shrinkWrap：该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。默认情况下，ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true。
addAutomaticKeepAlives：该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，在该列表项滑出视口时它也不会被GC（垃圾回收），它会使用KeepAliveNotification来保存其状态。如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
addRepaintBoundaries：该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中。当可滚动组件滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，不添加RepaintBoundary反而会更高效。和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false
*/

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => new _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    //return listView1;
    //return listView2;
    //return listView3;
    return listView4;
    /*return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        //如果到了表尾
        if (_words[index] == loadingTag) {
          //不足100条，继续获取数据
          if (_words.length - 1 < 100) {
            //获取数据
            _retrieveData();
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0)),
            );
          } else {
            //已经加载了100条数据，不再获取数据。
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ));
          }
        }
        //显示单词列表项
        return ListTile(title: Text(_words[index]));
      },
      separatorBuilder: (context, index) => Divider(height: .0),
    );*/
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {
        //重新构建列表
      });
    });
  }

  /* 默认构造函数（重点：这种方式适合只有少量的子组件的情况，）
   * 默认构造函数有一个children参数，它接受一个Widget列表（List）。
   * 因为这种方式需要将所有children都提前创建好（这需要做大量工作），而不是等到子widget真正显示的时候再创建，
   * 也就是说通过默认构造函数构建的ListView没有应用基于Sliver的懒加载模型。
   * 实际上通过此方式创建的ListView和使用SingleChildScrollView+Column的方式没有本质的区别。
   * 下面是一个例子：*/
  Widget listView1 = ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.all(20.0),
    children: <Widget>[
      const Text('I\'m dedicating every day to you'),
      const Text('Domestic life was never quite my style'),
      const Text('When you smile, you knock me out, I fall apart'),
      const Text('And I thought I was so smart'),
    ],
  );

  /* ListView.builder适合列表项比较多（或者无限）的情况，
   * 因为只有当子组件真正显示的时候才会被创建，也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的*/
  /* itemBuilder：它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。
   * 当列表滚动到具体的index位置时，会调用该构建器构建列表项。
   * itemCount：列表项的数量，如果为null，则为无限列表。*/
  Widget listView2 = ListView.builder(
      itemCount: 100,
      itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
      });

  //下划线widget预定义以供复用。
  Widget divider1 = Divider(
    color: Colors.blue,
  );
  Widget divider2 = Divider(color: Colors.green);

  /* ListView.separated可以在生成的列表项之间添加一个分割组件，
   * 它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。*/
  Widget listView3 = ListView.separated(
    itemCount: 100,
    //列表项构造器
    itemBuilder: (BuildContext context, int index) {
      return ListTile(title: Text("$index"));
    },
    //分割器构造器
    separatorBuilder: (BuildContext context, int index) {
      return index % 2 == 0
          ? Divider(color: Colors.blue)
          : Divider(color: Colors.green);
    },
  );

  // 添加表头
  Widget listView4 = Column(children: <Widget>[
    ListTile(title: Text("商品列表")),
    Expanded(
      child: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
      }),
    ),
  ]);
}
