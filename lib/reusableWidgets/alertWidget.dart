import 'package:flutter/material.dart';
import 'dart:ui';

class BigCardWidget extends StatefulWidget {
  final Color baseColor;
  final IconData icon;
  final String text;

  const BigCardWidget({
    Key? key,
    required this.baseColor,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  _BigCardWidgetState createState() => _BigCardWidgetState();
}

class _BigCardWidgetState extends State<BigCardWidget> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double elevation = _isPressed ? 4 : 12;
    final double scale = _isPressed ? 0.95 : 1.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(scale),
        child: Material(
          color: Colors.transparent,
          elevation: elevation,
          borderRadius: BorderRadius.circular(28),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: CustomPaint(
                painter: ElegantCardPainter(baseColor: widget.baseColor),
                child: Container(
                  height: 240,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon,
                        size: 80,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 12,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 3),
                              blurRadius: 8,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ElegantCardPainter extends CustomPainter {
  final Color baseColor;

  ElegantCardPainter({required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(28));

    Path path = Path()..addRRect(rrect);
    canvas.drawShadow(path, Colors.black.withOpacity(0.9), 14, false);

    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        baseColor.withOpacity(1.0),
        baseColor.withOpacity(0.75),
        baseColor.withOpacity(0.5),
      ],
    );
    final Paint backgroundPaint = Paint()..shader = backgroundGradient.createShader(rect);
    canvas.drawRRect(rrect, backgroundPaint);

    final Paint borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, borderPaint);

    final Path highlightPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.6, 0)
      ..lineTo(0, size.height * 0.6)
      ..close();

    final Paint highlightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}