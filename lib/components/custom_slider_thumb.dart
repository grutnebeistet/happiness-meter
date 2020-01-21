import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSliderThumb extends SliderComponentShape {
  final double width;

  const CustomSliderThumb({
    this.width = 10.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(width);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromCenter(center: center, width: 40, height: 80);

    final rectLine = Rect.fromCenter(center: center, width: 6, height: 64);

    final fillPaint = Paint()
      ..color = sliderTheme.activeTrackColor
      ..style = PaintingStyle.fill;

    final fillPaintLine = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path rectPath = Path();
    final rrect = RRect.fromRectXY(rect, 6, 6);
    rectPath.addRRect(rrect);



    Path linePath = Path();
    linePath.addRect(rectLine);

    canvas.drawShadow(rectPath, Colors.black, 16, true);
    canvas.drawShadow(linePath, Colors.black, 14, false);

    canvas.drawPath(rectPath, fillPaint);
    canvas.drawPath(linePath, fillPaintLine);
  }
}
