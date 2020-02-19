import 'package:flutter/material.dart';
import 'dart:math';

/*
CustomPaint({
Key key,
this.painter,
this.foregroundPainter,
this.size = Size.zero,
this.isComplex = false,
this.willChange = false,
Widget child, //子节点，可以为空
})
painter: 背景画笔，会显示在子节点后面;
foregroundPainter: 前景画笔，会显示在子节点前面
size：当child为null时，代表默认绘制区域大小，如果有child则忽略此参数，画布尺寸则为child尺寸。
如果有child但是想指定画布为特定大小，可以使用SizeBox包裹CustomPaint实现。
isComplex：是否复杂的绘制，如果是，Flutter会应用一些缓存策略来减少重复渲染的开销。
willChange：和isComplex配合使用，当启用缓存时，该属性代表在下一帧中绘制是否会改变。
可以看到，绘制时我们需要提供前景或背景画笔，两者也可以同时提供。
我们的画笔需要继承CustomPainter类，我们在画笔类中实现真正的绘制逻辑。
*/
/*
注意
如果CustomPaint有子节点，为了避免子节点不必要的重绘并提高性能，通常情况下都会将子节点包裹在RepaintBoundary组件中，
这样会在绘制时就会创建一个新的绘制层（Layer），其子组件将在新的Layer上绘制，而父组件将在原来Layer上绘制，
也就是说RepaintBoundary 子组件的绘制将独立于父组件的绘制，
RepaintBoundary会隔离其子节点和CustomPaint本身的绘制边界。示例如下：
CustomPaint(
size: Size(300, 300), //指定画布大小
painter: MyPainter(),
child: RepaintBoundary(child:...)),
)*/

// 实际上Flutter提供的所有组件最终都是通过调用Canvas绘制出来的
// 读者有兴趣可以查看具有外观样式的组件源码，找到其对应的RenderObject对象，
// 如Text对应的RenderParagraph对象最终会通过Canvas实现文本绘制逻辑。
class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomPoint、Canvas'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300), //指定画布大小
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
      Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );

    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
