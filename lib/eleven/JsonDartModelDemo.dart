/*
返回的数据就是JSON格式的字符串，为了方便我们在代码中操作JSON，我们先将JSON格式的字符串转为Dart对象，
这个可以通过dart:convert中内置的JSON解码器json.decode() 来实现，
该方法可以根据JSON字符串具体内容将其转为List或Map，这样我们就可以通过他们来查找所需的值，如：
//一个JSON格式的用户列表字符串
String jsonStr='[{"name":"Jack"},{"name":"Rose"}]';
//将JSON字符串转为Dart对象(此处是List)
List items=json.decode(jsonStr);
//输出第一个用户的姓名
print(items[0]["name"]);
*/

/*
{
"name": "John Smith",
"email": "john@example.com"
}
我们可以通过调用json.decode方法来解码JSON ，使用JSON字符串作为参数:
Map<String, dynamic> user = json.decode(json);
print('Howdy, ${user['name']}!');
print('We sent the verification link to ${user['email']}.');
*/

// 好的解决方法即“Json Model化”
// 具体做法就是，通过预定义一些与Json结构对应的Model类，然后在请求到数据后再动态根据数据创建出Model类的实例
// 例如：
/*
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'name': name,
        'email': email,
      };
}*/
/*
现在，序列化逻辑移到了模型本身内部。采用这种新方法，我们可以非常容易地反序列化user.
Map userMap = json.decode(json);
var user = new User.fromJson(userMap);
print('Howdy, ${user.name}!');
print('We sent the verification link to ${user.email}.');

要序列化一个user，我们只是将该User对象传递给该json.encode方法。我们不需要手动调用toJson这个方法，
因为`JSON.encode内部会自动调用。
String json = json.encode(user);
这样，调用代码就不用担心JSON序列化了*/


// 自动生成Model
// 介绍一下官方推荐的json_serializable package包。
// 它是一个自动化的源代码生成器，可以在开发阶段为我们生成JSON序列化模板，
// 这样一来，由于序列化代码不再由我们手写和维护，我们将运行时产生JSON序列化异常的风险降至最低。

/*
在项目中设置json_serializable
要包含json_serializable到我们的项目中，我们需要一个常规和两个开发依赖项。
简而言之，开发依赖项是不包含在我们的应用程序源代码中的依赖项，它是开发过程中的一些辅助工具、脚本，
和node中的开发依赖项相似。

pubspec.yaml

dependencies:
# Your other regular dependencies here
json_annotation: ^2.0.0

dev_dependencies:
# Your other dev_dependencies here
build_runner: ^1.0.0
json_serializable: ^2.0.0
在您的项目根文件夹中运行 flutter packages get (或者在编辑器中点击 “Packages Get”) 以在项目中使用这些新的依赖项.
*/
