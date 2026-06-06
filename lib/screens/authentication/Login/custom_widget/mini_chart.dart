import 'package:flutter/cupertino.dart';

class MiniChart extends StatelessWidget {
  const MiniChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 60),
      painter: _ChartPainter(),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [0.6, 0.5, 0.55, 0.35, 0.4, 0.25, 0.3, 0.15, 0.2, 0.1];
    final w = size.width / (points.length - 1);

    final linePaint = Paint()
      ..color = const Color(0xFF4ADE80).withValues(alpha: 0.8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = i * w;
      final y = points[i] * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, linePaint);

    // Fill area
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(fillPath, Paint()
      ..color = const Color(0xFF4ADE80).withValues(alpha: 0.08)
      ..style = PaintingStyle.fill);

    // End dot
    canvas.drawCircle(
      Offset(size.width, points.last * size.height),
      4,
      Paint()..color = const Color(0xFF4ADE80),
    );
  }

  @override
  bool shouldRepaint(_) => false;
}