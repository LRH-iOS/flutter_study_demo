/*const TextField({
...
TextEditingController controller,   //编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件。
                                      大多数情况下我们都需要显式提供一个controller来与文本框交互。如果没有提供controller，则TextField内部会自动创建一个。
FocusNode focusNode,                //用于控制TextField是否占有当前键盘的输入焦点。它是我们和键盘交互的一个句柄（handle）。
InputDecoration decoration = const InputDecoration(),   //用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
TextInputType keyboardType,         //用于设置该输入框默认的键盘输入类型，取值如下：
                                      TextInputType枚举值	含义
                                      text	文本输入键盘
                                      multiline	多行文本，需和maxLines配合使用(设为null或大于1)
                                      number	数字；会弹出数字键盘
                                      phone	优化后的电话号码输入键盘；会弹出数字键盘并显示“* #”
                                      datetime	优化后的日期输入键盘；Android上会显示“: -”
                                      emailAddress	优化后的电子邮件地址；会显示“@ .”
                                      url	优化后的url输入键盘； 会显示“/ .”

TextInputAction textInputAction,    //键盘动作按钮图标(即回车键位图标)，它是一个枚举值，有多个可选值，全部的取值列表读者可以查看API文档，
TextStyle style,                    //正在编辑的文本样式。
TextAlign textAlign = TextAlign.start,  //输入框内编辑文本在水平方向的对齐方式。
bool autofocus = false,             //是否自动获取焦点。
bool obscureText = false,           //是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。
int maxLines = 1,                   //输入框的最大行数，默认为1；如果为null，则无行数限制。
int maxLength,                      //maxLength代表输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数。
bool maxLengthEnforced = true,      //maxLengthEnforced决定当输入文本长度超过maxLength时是否阻止输入，为true时会阻止输入，为false时不会阻止输入但输入框会变红。
ValueChanged<String> onChanged,     //输入框内容改变时的回调函数；注：内容改变事件也可以通过controller来监听。
VoidCallback onEditingComplete,     //这两个回调都是在输入框输入完成时触发，比如按了键盘的完成键（对号图标）或搜索键（🔍图标）。不同的是两个回调签名不同，
                                    onSubmitted回调是ValueChanged<String>类型，它接收当前输入内容做为参数，而onEditingComplete不接收参数。
ValueChanged<String> onSubmitted,
List<TextInputFormatter> inputFormatters,   //用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验。
bool enabled,                       //如果为false，则输入框会被禁用，禁用状态不接收输入和事件，同时显示禁用态样式（在其decoration中定义）。
this.cursorWidth = 2.0,             //自定义输入框光标宽度
this.cursorRadius,                  //圆角
this.cursorColor,                   //颜色
...
})*/

import 'package:flutter/material.dart';

class TextFieldStudyWidget extends StatefulWidget {
  TextFieldStudyWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TextFieldStudyWidget createState() => new _TextFieldStudyWidget();
}

class _TextFieldStudyWidget extends State<TextFieldStudyWidget> {
  var name = '';
  var pwd = '';
  TextEditingController _unameController = TextEditingController();

  TextEditingController _selectionController = TextEditingController();

  //两种方式相比，onChanged是专门用于监听文本变化，而controller的功能却多一些，除了能监听文本变化外，它还可以设置默认值、选择文本，
  @override
  void initState() {
    //监听输入变化
    _unameController.addListener(() {
      print('controller方式=' + _unameController.text);
    });

    _selectionController.text = "hello world!";
    _selectionController.selection = TextSelection(
        baseOffset: 2, extentOffset: _selectionController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),
              onChanged: (value) {
                name = value;
                print('$name');
              },
            ),
            TextField(
              controller: _selectionController,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              //obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => new _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;


  @override
   void initState() {
    super.initState();

    focusNode1.addListener(() {
      print(focusNode1.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入框、表单'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNode1, //关联focusNode1
            decoration: InputDecoration(labelText: "input1"),
          ),
          TextField(
            focusNode: focusNode2, //关联focusNode2
            decoration: InputDecoration(labelText: "input2"),
          ),
          Builder(
            builder: (ctx) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      //将焦点从第一个TextField移到第二个TextField
                      // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                      // 这是第二种写法
                      if (null == focusScopeNode) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode.requestFocus(focusNode2);
                    },
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      // 当所有编辑框都失去焦点时键盘就会收起
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}


// 表单
class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Form Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)
                  ),
                  // 校验用户名
                  validator: (v) {
                    return v
                        .trim()
                        .length > 0 ? null : "用户名不能为空";
                  }

              ),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v
                        .trim()
                        .length > 5 ? null : "密码不能少于6位";
                  }
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if((_formKey.currentState as FormState).validate()){
                            //验证通过提交数据
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
