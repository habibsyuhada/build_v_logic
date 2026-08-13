import 'package:flutter/material.dart';

/// CRT scanline effect (§1.8): a subtle horizontal-line overlay, toggle
/// off by default. Purely decorative — never gates functionality — so it's
/// safe to skip entirely when reduce-motion or the setting itself is off.
class ScanlineOverlay extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const ScanlineOverlay({super.key, required this.child, required this.enabled});

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _ScanlinePainter()),
          ),
        ),
      ],
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScanlinePainter oldDelegate) => false;
}
