import 'package:flutter/material.dart';

class StartMarker extends CustomPainter {
  final int minutes;
  final String destination;

  StartMarker({
    required this.minutes,
    required this.destination,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tealPaint = Paint()..color = Colors.teal;
    final whitePaint = Paint()..color = Colors.white;
    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleBlackRadius,
      tealPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    final path = Path();
    path.moveTo(30, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 120);
    path.lineTo(30, 120);
    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(path, whitePaint);

    const blackBox = Rect.fromLTWH(30, 20, 85, 100);
    canvas.drawRect(blackBox, tealPaint);

    final textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w400,
      ),
      text: '$minutes',
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    textPainter.paint(canvas, const Offset(35, 30));

    const minutesText = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: 'Min',
    );

    final minutesPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    minutesPainter.paint(canvas, const Offset(35, 70));

    final locationText = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: destination,
    );

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
        minWidth: size.width - 135,
        maxWidth: size.width - 135,
      );
    final double offsetY = (destination.length > 20) ? 35 : 48;
    locationPainter.paint(canvas, Offset(120, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
