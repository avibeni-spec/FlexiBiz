import 'package:flutter/material.dart';

class FlexoraSymbolPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint lead = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF2D39B),
          Color(0xFFD0A45A),
          Color(0xFF8A6A32),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    final Paint follow = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE8C98A),
          Color(0xFFC89A4F),
          Color(0xFF7A5A28),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final Path leadPath = Path()
      ..moveTo(size.width * 0.10, size.height * 0.70)
      ..quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.40,
        size.width * 0.55,
        size.height * 0.45,
      )
      ..quadraticBezierTo(
        size.width * 0.80,
        size.height * 0.50,
        size.width * 0.90,
        size.height * 0.30,
      );

    final Path followPath = Path()
      ..moveTo(size.width * 0.08, size.height * 0.78)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.50,
        size.width * 0.50,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.60,
        size.width * 0.88,
        size.height * 0.38,
      );

    canvas.drawPath(leadPath, lead);
    canvas.drawPath(followPath, follow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FlexoraSymbol extends StatelessWidget {
  const FlexoraSymbol({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: FlexoraSymbolPainter(),
      ),
    );
  }
}
