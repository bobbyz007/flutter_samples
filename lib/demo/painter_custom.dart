import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(PiePage());

class PiePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Paint'),
        ),
        body: Center(
          child: CustomPaint(
            size: Size(300, 300),
            painter: PiePainter(),
          ),
        )
      ),
    );
  }
}

class PiePainter extends CustomPainter {
  Paint getPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double wheelSize = min(size.width, size.height) / 2;
    double nbElements = 6;
    double radius = (2 * pi) / nbElements;
    
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);
    canvas.drawArc(boundingRect, 0, radius, false, getPaint(Colors.red));
    canvas.drawArc(boundingRect, radius, radius, true, getPaint(Colors.black38));
    canvas.drawArc(boundingRect, radius * 2, radius, false, getPaint(Colors.green));
    canvas.drawArc(boundingRect, radius * 3, radius, true, getPaint(Colors.amber));
    canvas.drawArc(boundingRect, radius * 4, radius, false, getPaint(Colors.blue));
    canvas.drawArc(boundingRect, radius * 5, radius, true, getPaint(Colors.purple));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}