import 'package:flutter/material.dart';
/*
GridView可以构建一个二维网格列表
Flutter中提供了两个SliverGridDelegate的子类
SliverGridDelegateWithFixedCrossAxisCount和SliverGridDelegateWithMaxCrossAxisExtent
*/

/*SliverGridDelegateWithFixedCrossAxisCount
该子类实现了一个横轴为固定数量子元素的layout算法，其构造函数为：
SliverGridDelegateWithFixedCrossAxisCount({
@required double crossAxisCount, 横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，
即ViewPort横轴长度除以crossAxisCount的商。
double mainAxisSpacing = 0.0, 主轴方向的间距。
double crossAxisSpacing = 0.0, 横轴方向子元素的间距。
double childAspectRatio = 1.0, 子元素在横轴长度和主轴长度的比例。
由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
}
可以发现，子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的。
注意，这里的子元素指的是子组件的最大显示空间，注意确保子组件的实际大小不要超出子元素的空间。
*/
/*
SliverGridDelegateWithMaxCrossAxisExtent
该子类实现了一个横轴子元素为固定最大长度的layout算法，其构造函数为：
SliverGridDelegateWithMaxCrossAxisExtent({
double maxCrossAxisExtent, maxCrossAxisExtent为子元素在横轴上的最大长度，
之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的，
double mainAxisSpacing = 0.0,
double crossAxisSpacing = 0.0,
double childAspectRatio = 1.0,
})*/

class GridViewRoute extends StatefulWidget {
  @override
  _GridViewRouteState createState() => new _GridViewRouteState();
}

class _GridViewRouteState extends State<GridViewRoute> {
  List<IconData> _icons = []; //保存Icon数据
  var _curCount = 0;


  @override
  void initState() {
    // 初始化数据
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GridView"),
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _curCount > 3 ? 2 : 3, //每行三列
                childAspectRatio: 1.0 //显示区域宽高相等
            ),
            itemCount: _icons.length,
            itemBuilder: (context, index) {
              //如果显示到最后一个并且Icon总数小于200时继续获取数据
              if (index == _icons.length - 1 && _icons.length < 200) {
                _retrieveIcons();
              }
              return Icon(_icons[index]);
            }),
    );
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _curCount += 1;
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('GridView'),
//      ),
//      body: gridView4,
//    );
//  }

  Widget gridView1 = GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, //横轴三个子widget
          childAspectRatio: 1.0 //宽高比为1时，子widget
      ),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ]);

  /* GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount，
   * 我们通过它可以快速的创建横轴固定数量子元素的GridView，上面的示例代码等价于：*/
  Widget gridView2 = GridView.count(
    crossAxisCount: 3,
    childAspectRatio: 1.0,
    children: <Widget>[
      Icon(Icons.ac_unit),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast),
    ],
  );

  // SliverGridDelegateWithMaxCrossAxisExtent
  Widget gridView3 = GridView(
    padding: EdgeInsets.zero,
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 130.0, childAspectRatio: 2.0 //宽高比为2
    ),
    children: <Widget>[
      Icon(Icons.ac_unit),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast),
    ],
  );

  // GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent
  Widget gridView4 = GridView.extent(
    maxCrossAxisExtent: 120.0,
    childAspectRatio: 2.0,
    children: <Widget>[
      Icon(Icons.ac_unit),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast),
    ],
  );
}
