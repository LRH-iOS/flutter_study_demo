import 'package:flutter/material.dart';

/*尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器，如ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio等，本节将介绍一些常用的。*/

/*
 实际上ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的
 我们可以看到ConstrainedBox和SizedBox的createRenderObject()方法都返回的是一个RenderConstrainedBox对象：
  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
  return new RenderConstrainedBox(
    additionalConstraints: ...,
  );
}*/

/*多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。实际上，只有这样才能保证父限制与子限制不冲突。*/

class BoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('尺寸限制类容器'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: double.infinity, //宽度尽可能大
                      minHeight: 50.0 //最小高度为50像素
                      ),
                  child: Container(height: 5.0, child: redBox),
                ),
                Padding(padding: const EdgeInsets.all(10.0)),

                SizedBox(width: 80.0, height: 80.0, child: redBox),

                //实际上SizedBox只是ConstrainedBox的一个定制，上面代码等价于：
                Padding(padding: const EdgeInsets.all(10.0)),
                ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: 80.0, height: 80.0),
                  child: redBox,
                ),

                // 而BoxConstraints.tightFor(width: 80.0,height: 80.0)等价于：
                Padding(padding: const EdgeInsets.all(10.0)),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: 80.0,
                      maxHeight: 80.0,
                      minWidth: 80.0,
                      maxWidth: 80.0),
                  child: redBox,
                ),

                // 多重限制
                Padding(padding: const EdgeInsets.all(10.0)),
                ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
                      child: redBox,
                    )),

                Padding(padding: const EdgeInsets.all(10.0)),

                ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: 60.0, minHeight: 60.0),
                      child: redBox,
                    )),

                Padding(padding: const EdgeInsets.all(10.0)),
                ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 60.0, maxHeight: 60.0), //父
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 90.0, maxHeight: 20.0), //子
                      child: redBox,
                    )),

                Padding(padding: const EdgeInsets.all(10.0)),

                ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 90.0, maxHeight: 20.0),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 60.0, maxHeight: 60.0),
                      child: redBox,
                    )),

                // 由于UnconstrainedBox “去除”了父ConstrainedBox的限制，则最终会按照子ConstrainedBox的限制来绘制redBox，即90×20：
                // 但是，读者请注意，UnconstrainedBox对父组件限制的“去除”并非是真正的去除：上面例子中虽然红色区域大小是90×20，但上方仍然有80的空白空间。
                // 也就是说父限制的minHeight(100.0)仍然是生效的，只不过它不影响最终子元素redBox的大小，但仍然还是占有相应的空间，
                // 可以认为此时的父ConstrainedBox是作用于子UnconstrainedBox上，而redBox只受子ConstrainedBox限制，
                ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: 60.0, minHeight: 100.0), //父
                    child: UnconstrainedBox(
                      //“去除”父级限制
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
                        child: redBox,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );
}
