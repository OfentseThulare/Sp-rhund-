import 'package:flutter/material.dart';
import '../../theme/colours.dart';

class ShieldCrest extends StatelessWidget {
  final double size;

  const ShieldCrest({super.key, this.size = 72});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.15,
      child: CustomPaint(
        painter: _ShieldPainter(),
      ),
    );
  }
}

class _ShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    // Shield shape path
    final shieldPath = Path();
    shieldPath.moveTo(cx, 0);
    // Top right curve
    shieldPath.quadraticBezierTo(w * 0.85, 0, w * 0.95, h * 0.08);
    shieldPath.lineTo(w, h * 0.12);
    // Right side
    shieldPath.lineTo(w, h * 0.45);
    // Bottom right curve to point
    shieldPath.quadraticBezierTo(w * 0.95, h * 0.72, cx, h);
    // Bottom left curve from point
    shieldPath.quadraticBezierTo(w * 0.05, h * 0.72, 0, h * 0.45);
    // Left side
    shieldPath.lineTo(0, h * 0.12);
    shieldPath.lineTo(w * 0.05, h * 0.08);
    // Top left curve
    shieldPath.quadraticBezierTo(w * 0.15, 0, cx, 0);
    shieldPath.close();

    // Background gradient fill
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColours.primaryPurple.withValues(alpha: 0.25),
          AppColours.deepViolet.withValues(alpha: 0.15),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(shieldPath, bgPaint);

    // Border gradient
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColours.primaryPurple.withValues(alpha: 0.8),
          AppColours.deepViolet.withValues(alpha: 0.4),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(shieldPath, borderPaint);

    // Inner glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.2),
        radius: 0.7,
        colors: [
          AppColours.primaryPurple.withValues(alpha: 0.12),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(shieldPath, glowPaint);

    // Hound mark: diagonal slashes (matching the Spürhund logo pattern)
    canvas.save();
    canvas.clipPath(shieldPath);

    final slashPaint = Paint()
      ..color = AppColours.primaryPurple
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Upper group (3 slashes going top-right to bottom-left)
    final upperSlashes = [
      [Offset(cx - w * 0.18, h * 0.22), Offset(cx + w * 0.02, h * 0.38)],
      [Offset(cx - w * 0.08, h * 0.20), Offset(cx + w * 0.12, h * 0.36)],
      [Offset(cx + w * 0.02, h * 0.18), Offset(cx + w * 0.22, h * 0.34)],
    ];

    for (final slash in upperSlashes) {
      canvas.drawLine(slash[0], slash[1], slashPaint);
    }

    // Lower group (3 slashes offset downward)
    final lowerSlashes = [
      [Offset(cx - w * 0.22, h * 0.42), Offset(cx - w * 0.02, h * 0.58)],
      [Offset(cx - w * 0.12, h * 0.40), Offset(cx + w * 0.08, h * 0.56)],
      [Offset(cx - w * 0.02, h * 0.38), Offset(cx + w * 0.18, h * 0.54)],
    ];

    for (final slash in lowerSlashes) {
      canvas.drawLine(slash[0], slash[1], slashPaint);
    }

    // Centre connecting slash (bridging upper and lower groups)
    canvas.drawLine(
      Offset(cx - w * 0.10, h * 0.32),
      Offset(cx + w * 0.10, h * 0.48),
      slashPaint..color = AppColours.primaryPurple.withValues(alpha: 0.7),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
