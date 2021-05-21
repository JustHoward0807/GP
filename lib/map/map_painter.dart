import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final String label, number;

  MyPainter(this.label, this.number);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(25));

    paint.color = appbarcolor;
    canvas.drawRRect(rRect, paint);

    paint.color = Colors.white;

    canvas.drawCircle(
        Offset(size.width / 2 + 65, size.height / 2), size.height / 3, paint);

    final textPainter = TextPainter(
        text: TextSpan(
            text: this.label,
            style: TextStyle(fontSize: 40, color: Colors.black)),
        maxLines: 1,
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: 150);
    textPainter.paint(
        canvas,
        Offset(size.width / 2 - 110,
            size.height / 2 - textPainter.size.height / 2));

    final textPainter2 = TextPainter(
        text: TextSpan(
            text: this.number,
            style: TextStyle(fontSize: 35, color: Colors.black)),
        maxLines: 1,
        textDirection: TextDirection.ltr);

    textPainter2.layout(minWidth: 0, maxWidth: 100);
    textPainter2.paint(
        canvas,
        Offset(size.width / 2 + 52,
            size.height / 2 - textPainter2.size.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
