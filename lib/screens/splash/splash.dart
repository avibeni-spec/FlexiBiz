import 'package:flutter/material.dart';

class FlexoraSplash extends StatefulWidget {
  const FlexoraSplash({super.key});

  @override
  State<FlexoraSplash> createState() => _FlexoraSplashState();
}

class _FlexoraSplashState extends State<FlexoraSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _glow = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacement(...)
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.amber.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: AnimatedBuilder(
                animation: _glow,
                builder: (context, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "FLEX",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 52,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 8,
                          color: Colors.amber,
                          shadows: [
                            Shadow(
                              color:
                                  Colors.amber.withOpacity(0.8 * _glow.value),
                              blurRadius: 35 * _glow.value,
                            ),
                          ],
                        ),
                      ),
                      CustomPaint(
                        painter: FlexoraLogoPainter(glow: _glow.value),
                        size: const Size(120, 120),
                      ),
                      Text(
                        "RA",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 52,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 8,
                          color: Colors.amber,
                          shadows: [
                            Shadow(
                              color:
                                  Colors.amber.withOpacity(0.8 * _glow.value),
                              blurRadius: 35 * _glow.value,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlexoraLogoPainter extends CustomPainter {
  final double glow;

  const FlexoraLogoPainter({required this.glow});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 10);
    final radius = size.width * 0.28;

    const gradient = SweepGradient(
      colors: [
        Color(0xFFFFE7A0),
        Color(0xFFF3C14E),
        Color(0xFFB8860B),
        Color(0xFFFFE7A0),
      ],
      startAngle: 0,
      endAngle: 6.28,
    );

    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final path = Path();

    path.moveTo(center.dx, center.dy - radius * 1.4);
    path.quadraticBezierTo(
      center.dx + radius * 1.2,
      center.dy - radius * 0.2,
      center.dx,
      center.dy + radius * 1.4,
    );
    path.quadraticBezierTo(
      center.dx - radius * 1.2,
      center.dy - radius * 0.2,
      center.dx,
      center.dy - radius * 1.4,
    );

    canvas.drawPath(path, paint);

    final innerPaint = Paint()
      ..color = Colors.amber.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, radius * 0.55, innerPaint);

    final linePaint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 3;

    canvas.drawLine(
      Offset(center.dx, center.dy + radius * 1.4),
      Offset(center.dx, center.dy + radius * 2.1),
      linePaint,
    );

    final fPaint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final fY = center.dy + radius * 2.1;

    canvas.drawLine(
      Offset(center.dx - 8, fY),
      Offset(center.dx + 8, fY),
      fPaint,
    );

    canvas.drawLine(
      Offset(center.dx - 8, fY),
      Offset(center.dx - 8, fY - 14),
      fPaint,
    );
  }

  @override
  bool shouldRepaint(covariant FlexoraLogoPainter oldDelegate) =>
      oldDelegate.glow != glow;
}
