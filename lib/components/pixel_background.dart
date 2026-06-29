import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class PixelBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.secundaryColor.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    const pixelSize = 32.0;

    for (var x = 0.0; x < size.width; x += pixelSize) {
      for (var y = 0.0; y < size.height; y += pixelSize) {
        canvas.drawRect(Rect.fromLTWH(x, y, pixelSize, pixelSize), paint);
      }
    }

    final dotPaint = Paint()
      ..color = AppColor.secundaryColor.withValues(alpha: 0.04);

    for (var x = 0.0; x < size.width; x += pixelSize) {
      for (var y = 0.0; y < size.height; y += pixelSize) {
        canvas.drawCircle(Offset(x + 2, y + 2), 1.5, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PixelBackgroundWidget extends StatelessWidget {
  const PixelBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: PixelBackground(),
      ),
    );
  }
}
