import 'package:flutter/material.dart';

import 'constants.dart';
import 'constants.dart';

class Backcircles extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the paint color to be white
    paint.color = Colors.white;
    // Create a rectangle with size and width same as the canvas
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);
    // set the color property of the paint

    //cen cir
    paint.color = patientColor;
    // center of the canvas is (x,y) => (width/2, height/2)
    var center1 = Offset(size.width / 2, 0);
    // draw the circle with center having radius 75.0
    canvas.drawCircle(center1, size.width * 0.85, paint);
  }

//#5C02D1
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}
