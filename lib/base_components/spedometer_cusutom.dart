// import 'package:cray/utils/base_colors.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';
//
// class CustomGauge extends StatelessWidget {
//   final double value;
//
//   const CustomGauge({super.key, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: const Size(300, 300),
//       painter: GaugePainter(value),
//     );
//   }
// }
//
// class GaugePainter extends CustomPainter {
//   final double value;
//
//   GaugePainter(this.value);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 3;
//
//     // Background Arc (Gradient from Green to Red)
//     const gradient = SweepGradient(
//       startAngle: pi,
//       endAngle: 2 * pi,
//       colors: [BaseColors.speedometerSecClr, BaseColors.speedometerClr],
//     );
//
//     final rect = Rect.fromCircle(center: center, radius: radius);
//     final paint = Paint()
//       ..shader = gradient.createShader(rect)
//       ..strokeWidth = 35
//       ..style = PaintingStyle.stroke;
//
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius - 10),
//       pi,
//       pi,
//       false,
//       paint,
//     );
//
//     // Needle Paint
//     final needlePaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     // Calculate needle position
//     double angle = pi + (pi * (value / 100));
//     final needleStart = Offset(
//       center.dx + radius * 0.15 * cos(angle - pi),
//       center.dy + radius * 0.15 * sin(angle - pi),
//     );
//     final needleEnd = Offset(
//       center.dx + radius * 0.6 * cos(angle),
//       center.dy + radius * 0.6 * sin(angle),
//     );
//
//     // Draw the needle
//     canvas.drawLine(needleStart, needleEnd, needlePaint);
//
//     // Draw circular pivot
//     final pivotPaint = Paint()..color = Colors.black;
//     canvas.drawCircle(center, 8, pivotPaint);
//
//     // Inner circle for better aesthetics
//     final innerCirclePaint = Paint()..color = Colors.white;
//     canvas.drawCircle(center, 4, innerCirclePaint);
//
//
//     // Draw value text
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: value.toInt().toString(),
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(
//       canvas,
//       Offset(center.dx - textPainter.width / 2, center.dy + radius * 0.4),
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
