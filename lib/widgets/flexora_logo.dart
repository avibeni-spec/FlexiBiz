import 'package:flutter/material.dart';

class FlexoraLogoAnimated extends StatefulWidget {
  final double width;
  final double height;

  const FlexoraLogoAnimated({
    super.key,
    this.width = 300,
    this.height = 120,
  });

  @override
  State<FlexoraLogoAnimated> createState() => _FlexoraLogoAnimatedState();
}

class _FlexoraLogoAnimatedState extends State<FlexoraLogoAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _FlexoraPainter(),
        ),
      ),
    );
  }
}

class _FlexoraPainter extends CustomPainter {
  final Color gold1 = const Color(0xFFF9E5BC);
  final Color gold2 = const Color(0xFFD4AF37);
  final Color gold3 = const Color(0xFF8A6D3B);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final Paint goldPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [gold1, gold2, gold3],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // FLEX
    _drawText(
        canvas, "FLEX", Offset(size.width * 0.1, center.dy - 20), goldPaint);

    // RA
    _drawText(
        canvas, "RA", Offset(size.width * 0.75, center.dy - 20), goldPaint);

    // Halo drop shape
    final Path drop = Path();
    double cx = size.width / 2;
    double cy = center.dy - 5;

    drop.moveTo(cx, cy - 40);
    drop.cubicTo(cx - 30, cy - 20, cx - 35, cy + 30, cx, cy + 40);
    drop.cubicTo(cx + 35, cy + 30, cx + 30, cy - 20, cx, cy - 40);

    canvas.drawPath(drop, goldPaint);

    // Circle
    canvas.drawCircle(Offset(cx, cy + 5), 18, goldPaint);

    // Line to F
    canvas.drawLine(
      Offset(cx, cy + 40),
      Offset(cx, cy + 55),
      goldPaint,
    );

    // Small F
    _drawText(
      canvas,
      "F",
      Offset(cx - 5, cy + 55),
      goldPaint,
      fontSize: 18,
      isBold: true,
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    Paint paint, {
    double fontSize = 40,
    bool isBold = false,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w300,
          foreground: paint,
          fontFamily: 'Times New Roman',
          letterSpacing: 4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
