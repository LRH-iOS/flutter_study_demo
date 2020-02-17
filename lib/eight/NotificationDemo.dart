import 'package:flutter/material.dart';

/*
NotificationListener定义如下：
class NotificationListener<T extends Notification> extends StatelessWidget {
  const NotificationListener({
    Key key,
    @required this.child,
    this.onNotification,
  }) : super(key: key);
  ...//省略无关代码
}
我们可以看到：
NotificationListener 继承自StatelessWidget类，所以它可以直接嵌套到Widget树中。
NotificationListener 可以指定一个模板参数，该模板参数类型必须是继承自Notification；
当显式指定模板参数时，NotificationListener 便只会接收该参数类型的通知。举个例子，如果我们将上例子代码给为：
*/

class NotificationRoute extends StatefulWidget {

  @override NotificationRouteState createState() => new NotificationRouteState();
}

class NotificationRouteState extends State<NotificationRoute> {

  @override Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('通知'),
      ),
      //指定监听通知的类型为滚动结束通知(ScrollEndNotification)
      //如果这里指定ScrollEndNotification，那么只会在滚动结束时在控制台打印出通知的信息
      //NotificationListener<ScrollEndNotification>(
      body: NotificationListener(
        //onNotification回调为通知处理回调，其函数签名如下：
        //
        //typedef NotificationListenerCallback<T extends Notification> = bool Function(T notification);
        //它的返回值类型为布尔值，当返回值为true时，阻止冒泡，其父级Widget将再也收不到该通知；
        // 当返回值为false 时继续向上冒泡通知。
        onNotification: (notification){
          switch (notification.runtimeType){
            case ScrollStartNotification: print("开始滚动"); break;
            case ScrollUpdateNotification: print("正在滚动"); break;
            case ScrollEndNotification: print("滚动停止"); break;
            case OverscrollNotification: print("滚动到边界"); break;
          }
        },
        child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(title: Text("$index"),);
            }
        ),
      ),
    );
  }
}
