import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/*
const AlertDialog({
Key key,
this.title, //对话框标题组件
this.titlePadding, // 标题填充
this.titleTextStyle, //标题文本样式
this.content, // 对话框内容组件
this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0), //内容的填充
this.contentTextStyle,// 内容文本样式
this.actions, // 对话框操作按钮组
this.backgroundColor, // 对话框背景色
this.elevation,// 对话框的阴影
this.semanticLabel, //对话框语义化标签(用于读屏软件)
this.shape, // 对话框外形
})*/
/*
Future<T> showDialog<T>({
@required BuildContext context,
bool barrierDismissible = true, //点击对话框barrier(遮罩)时是否关闭它
WidgetBuilder builder, // 对话框UI的builder
如果我们是通过点击对话框遮罩关闭的，则Future的值为null，
否则为我们通过Navigator.of(context).pop(result)返回的result值，
})*/

/* 注意：如果AlertDialog的内容过长，内容将会溢出，这在很多时候可能不是我们期望的，
 * 所以如果对话框内容过长时，可以用SingleChildScrollView将内容包裹起来。*/

// SimpleDialog也是Material组件库提供的对话框，它会展示一个列表，用于列表选择的场景。
// 实际上AlertDialog和SimpleDialog都使用了Dialog类，
// 由于AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，
// 这就导致他们的子组件不能是延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）
// 如果我们就是需要嵌套一个ListView应该怎么做？这时，我们可以直接使用Dialog类

/*
showDialog方法正是showGeneralDialog的一个封装
Future<T> showGeneralDialog<T>({
@required BuildContext context,
@required RoutePageBuilder pageBuilder, //构建对话框内部UI
bool barrierDismissible, //点击遮罩是否关闭对话框
String barrierLabel, // 语义化标签(用于读屏软件)
Color barrierColor, // 遮罩颜色
Duration transitionDuration, // 对话框打开/关闭的动画时长
RouteTransitionsBuilder transitionBuilder, // 对话框打开/关闭的动画
})*/

/*
对话框实现原理
直接调用Navigator的push方法打开了一个新的对话框路由_DialogRoute，然后返回了push的返回值。
可见对话框实际上正是通过路由的形式实现的，这也是为什么我们可以使用Navigator的pop 方法来退出对话框的原因。
*/

//showModalBottomSheet方法可以弹出一个Material风格的底部菜单列表模态对话框

class AlertDialogRoute extends StatefulWidget {
  @override
  _AlertDialogRoute createState() => new _AlertDialogRoute();
}

class _AlertDialogRoute extends State<AlertDialogRoute> {
  bool _withTree = false; // 复选框选中状态

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialog'),
      ),
      body: AlertDialog(
        title: Text("提示"),
        content: Text("您确定要删除当前文件吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), //关闭对话框
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              // ... 执行删除操作
              Navigator.of(context).pop(true); //关闭对话框
            },
          ),
          //点击该按钮后弹出对话框
          RaisedButton(
            child: Text("对话框1"),
            onPressed: () async {
              //弹出对话框并等待其关闭
              bool delete = await showDeleteConfirmDialog1(context);
              if (delete == null) {
                print("取消删除");
              } else {
                print("已确认删除");
                //... 删除文件
              }
            },
          ),
          FlatButton(
            child: Text("列表框"),
            onPressed: () {
              changeLanguage(context);
            },
          ),
          FlatButton(
            child: Text('嵌套ListView'),
            onPressed: () {
              showListDialog(context);
            },
          ),
          FlatButton(
            child: Text('自定义Dialog'),
            onPressed: () {
              showCustomDialogClick(context);
            },
          ),
          FlatButton(
            child: Text('复选框'),
            onPressed: () {
              showDeleteConfirmDialog2(context);
            },
          ),
          FlatButton(
            child: Text('底部菜单列表'),
            onPressed: () {
              _showModalBottomSheet(context);
            },
          ),
          FlatButton(
            child: Text('底部全屏菜单列表'),
            onPressed: () {
              _showBottomSheet(context);
            },
          ),
          FlatButton(
            child: Text('自定义Loading'),
            onPressed: () {
              showLoadingDialog(context);
            },
          ),
          FlatButton(
            child: Text('日历选择1'),
            onPressed: () {
              _showDatePicker1(context);
            },
          ),
          FlatButton(
            child: Text('日历选择2'),
            onPressed: () {
              _showDatePicker2(context);
            },
          ),
        ],
      ),
    );
  }

  // 弹出对话框
  Future<bool> showDeleteConfirmDialog1(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  // 复选框
  Future<bool> showDeleteConfirmDialog2(BuildContext context) {
    _withTree = false; // 默认复选框不选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  // 通过Builder来获得构建Checkbox的`context`，
                  // 这是一种常用的缩小`context`范围的方式
                  Builder(
                    builder: (BuildContext context) {
                      return Checkbox(
                        value: _withTree,
                        onChanged: (bool value) {
                          (context as Element).markNeedsBuild();
                          _withTree = !_withTree;
                        },
                      );
                    },
                  ),

//                  Checkbox(
//                    value: withTree,
//                    onChanged: (bool value) {
//                      //复选框选中状态发生变化时重新构建UI
//                      // setState方法只会针对当前context的子树重新build，
//                      setState(() {
//                        //更新复选框状态
//                        withTree = !withTree;
//                      });
//                    },
//                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //执行删除操作
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }
}

// 列表框
Future<void> changeLanguage(BuildContext context) async {
  int i = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // 返回1
                Navigator.pop(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('中文简体'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('美国英语'),
              ),
            ),
          ],
        );
      });

  if (i != null) {
    print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
  }
}

// 嵌套listView
Future<void> showListDialog(BuildContext context) async {
  int index = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      var child = Column(
        children: <Widget>[
          ListTile(title: Text("请选择")),
          Expanded(
              child: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          )),
        ],
      );
      //使用AlertDialog会报错
      //return AlertDialog(content: child);
      return Dialog(child: child);

      //也可以用下面代码实现自定义
//      return UnconstrainedBox(
//        constrainedAxis: Axis.vertical,
//        child: ConstrainedBox(
//          constraints: BoxConstraints(maxWidth: 280),
//          child: Material(
//            child: child,
//            type: MaterialType.card,
//          ),
//        ),
//      );
    },
  );
  if (index != null) {
    print("点击了：$index");
  }
}

// showGeneralDialog
/* Material风格对话框打开/关闭动画是一个Fade（渐隐渐显）动画，
 * 如果我们想使用一个缩放动画就可以通过transitionBuilder来自定义。
 * 下面我们自己封装一个showCustomDialog方法，它定制的对话框动画为缩放动画，并同时制定遮罩颜色为Colors.black87：*/
Future<void> showCustomDialogClick(BuildContext context) async {
  showCustomDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text("您确定要删除当前文件吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
// 执行删除操作
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

// 弹出底部菜单列表模态对话框
Future<int> _showModalBottomSheet(BuildContext context) {
  return showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
            onTap: () => Navigator.of(context).pop(index),
          );
        },
      );
    },
  );
}

// 返回的是一个controller
// showBottomSheet方法，该方法会从设备底部向上弹出一个全屏的菜单列表
/* PersistentBottomSheetController中包含了一些控制对话框的方法比如close方法可以关闭该对话框，
 * 功能比较简单，读者可以自行查看源码。唯一需要注意的是，
 * showBottomSheet和我们上面介绍的弹出对话框的方法原理不同：
 * showBottomSheet是调用widget树顶部的Scaffold组件的ScaffoldState的showBottomSheet同名方法实现，
 * 也就是说要调用showBottomSheet方法就必须得保证父级组件中有Scaffold。*/
PersistentBottomSheetController<int> _showBottomSheet(BuildContext context) {
  return showBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
            onTap: () {
              // do something
              print("$index");
              Navigator.of(context).pop();
            },
          );
        },
      );
    },
  );
}

// 其实Loading框可以直接通过showDialog+AlertDialog来自定义：
showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, //点击遮罩不关闭对话框
    builder: (context) {
//      return AlertDialog(
//        content: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            CircularProgressIndicator(),
//            Padding(
//              padding: const EdgeInsets.only(top: 26.0),
//              child: Text("正在加载，请稍后..."),
//            )
//          ],
//        ),
//      );
      /* 如果我们嫌Loading框太宽，想自定义对话框宽度，这时只使用SizedBox或ConstrainedBox是不行的，
       * 原因是showDialog中已经给对话框设置了宽度限制，根据我们在第五章“尺寸限制类容器”一节中所述，
       * 我们可以使用UnconstrainedBox先抵消showDialog对宽度的限制，然后再使用SizedBox指定宽度，代码如下：*/
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: SizedBox(
          width: 280,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(
                  value: .8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Text("正在加载，请稍后..."),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}


// 日历选择
Future<DateTime> _showDatePicker1(BuildContext context) {
  var date = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: date,
    firstDate: date,
    lastDate: date.add( //未来30天可选
      Duration(days: 30),
    ),
  );
}

// iOS风格的日历选择器需要使用showCupertinoModalPopup方法和CupertinoDatePicker组件来实现：
Future<DateTime> _showDatePicker2(BuildContext context) {
  var date = DateTime.now();
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: date,
          maximumDate: date.add(
            Duration(days: 30),
          ),
          maximumYear: date.year + 1,
          onDateTimeChanged: (DateTime value) {
            print(value);
          },
        ),
      );
    },
  );
}