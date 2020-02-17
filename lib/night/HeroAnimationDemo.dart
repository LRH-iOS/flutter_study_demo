import 'package:flutter/material.dart';

/*
我们可以看到，实现Hero动画只需要用Hero组件将要共享的widget包装起来，并提供一个相同的tag即可，
中间的过渡帧都是Flutter Framework自动完成的。
必须要注意， 前后路由页的共享Hero的tag必须是相同的，
Flutter Framework内部正是通过tag来确定新旧路由页widget的对应关系的。
Hero动画的原理比较简单，Flutter Framework知道新旧路由页中共享元素的位置和大小，
所以根据这两个端点，在动画执行过程中求出过渡时的插值（中间态）即可，而感到幸运的是，这些事情不需要我们自己动手，
Flutter已经帮我们做了！
*/

//路由A:
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          child: Hero(
            tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
            child: ClipOval(
              child: Image.asset(
                "./images/1.png",
                width: 50.0,
              ),
            ),
          ),
          onTap: () {
            //打开B路由
            Navigator.push(context, PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
              return new FadeTransition(
                opacity: animation,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("原图"),
                  ),
                  body: HeroAnimationRouteB(),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

//路由B:
class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("./images/1.png"),
      ),
    );
  }
}
