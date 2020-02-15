import 'package:flutter/material.dart';

/*AppBar({
Key key,
this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
this.title,// 页面标题
this.actions, // 导航栏右侧菜单
this.bottom, // 导航栏底部菜单，通常为Tab按钮组
this.elevation = 4.0, // 导航栏阴影
this.centerTitle, //标题是否居中
this.backgroundColor,
...   //其它属性见源码注释
})*/
/*
Tab({
Key key,
this.text, // 菜单文本
this.icon, // 菜单图标
this.child, // 自定义组件样式
})*/

class ScaffoldAndTabbarWidget extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldAndTabbarWidget>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;

  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text("App Name"),
//自定义左边按钮
//        leading: Builder(builder: (context) {
//          return IconButton(
//            icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
//            onPressed: () {
//              // 打开抽屉菜单
//              // 通过Scaffold.of(context)可以获取父级最近的Scaffold 组件的State对象。
//              Scaffold.of(context).openDrawer();
//            },
//          );
//        }),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
        bottom: TabBar(
            //生成Tab菜单
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      //TabBarView组件，通过它不仅可以轻松的实现Tab页，而且可以非常容易的配合TabBar来实现同步切换和滑动状态同步
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          //创建3个Tab页
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      ),
      drawer: new MyDrawer(),
      //leftDraw,
//      drawer: Drawer(
//        child:Container(
//          alignment: Alignment.center,
//          child: Text('我是Drawer',style: TextStyle(fontSize: 30),),
//        ),
//      ), //抽屉
      bottomNavigationBar: bottomNavigationBar/*BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      )*/,
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}

  Widget leftDraw = Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text('wo shi Email'),
          accountName: Text('我是Drawer'),
          onDetailsPressed: () {},
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('images/1.png'),
          ),
        ),
        ListTile(
          title: Text('ListTile1'),
          subtitle: Text(
            'ListSubtitle1',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          leading: CircleAvatar(child: Text("1")),
          onTap: () {
            /*Navigator.pop(context);*/
          },
        ),
        Divider(), //分割线
        ListTile(
          title: Text('ListTile2'),
          subtitle: Text(
            'ListSubtitle2',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          leading: CircleAvatar(child: Text("2")),
          onTap: () {
            /*Navigator.pop(context);*/
          },
        ),
        Divider(), //分割线
        ListTile(
          title: Text('ListTile3'),
          subtitle: Text(
            'ListSubtitle3',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          leading: CircleAvatar(child: Text("3")),
          onTap: () {
            /*Navigator.pop(context);*/
          },
        ),
        Divider(), //分割线
        new AboutListTile(
          icon: new CircleAvatar(child: new Text("4")),
          child: new Text("AboutListTile"),
          applicationName: "AppName",
          applicationVersion: "1.0.1",
          applicationIcon: new Image.asset(
            'images/bb.jpg',
            width: 55.0,
            height: 55.0,
          ),
          applicationLegalese: "applicationLegalese",
          aboutBoxChildren: <Widget>[new Text("第一条..."), new Text("第二条...")],
        ),
        Divider(), //分割线
      ],
    ),
  );

  Widget bottomNavigationBar = BottomAppBar(
    color: Colors.white,
    //BottomAppBar的shape属性决定洞的外形，CircularNotchedRectangle实现了一个圆形的外形，我们也可以自定义外形，
    shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
    child: Row(
      children: [
        IconButton(icon: Icon(Icons.home)),
        SizedBox(), //中间位置空出
        IconButton(icon: Icon(Icons.business)),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
    ),
  );
}

//抽屉
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "imgs/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
