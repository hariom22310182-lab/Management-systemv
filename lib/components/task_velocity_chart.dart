import 'package:flutter/material.dart';

class TaskVelocityChart extends StatefulWidget {
  const TaskVelocityChart({super.key});

  @override
  State<TaskVelocityChart> createState() => _TaskVelocityChartState();
}

class _TaskVelocityChartState extends State<TaskVelocityChart> {
  int? hoveredPointIndex;
  Offset? mousePosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Task Velocity Trend',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '8 weeks',
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // simple custom chart using canvas with hover detection
          MouseRegion(
            onHover: (event) {
              setState(() {
                mousePosition = event.localPosition;
                hoveredPointIndex = _getHoveredPointIndex(event.localPosition);
              });
            },
            onExit: (_) {
              setState(() {
                hoveredPointIndex = null;
                mousePosition = null;
              });
            },
            child: SizedBox(
              height: 160,
              width: 460, // Increased width for longer chart
              child: Stack(
                children: [
                  CustomPaint(
                    painter: _TrendChartPainter(hoveredPointIndex: hoveredPointIndex),
                    size: Size.infinite,
                  ),
                  if (hoveredPointIndex != null && mousePosition != null)
                    Positioned(
                      left: mousePosition!.dx + 10,
                      top: mousePosition!.dy - 40,
                      child: _HoverTooltip(pointIndex: hoveredPointIndex!),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 4,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Completed',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 4,
                    color: Colors.teal,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Added',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  int? _getHoveredPointIndex(Offset position) {
    const double hitRadius = 12;
    final completedPoints = [
      Offset(20, 160 * 0.6),
      Offset(70, 160 * 0.4),
      Offset(120, 160 * 0.5),
      Offset(170, 160 * 0.65),
      Offset(220, 160 * 0.55),
      Offset(270, 160 * 0.45),
      Offset(320, 160 * 0.3),
    ];

    for (int i = 0; i < completedPoints.length; i++) {
      final distance = (position - completedPoints[i]).distance;
      if (distance < hitRadius) {
        return i;
      }
    }
    return null;
  }
}

class _TrendChartPainter extends CustomPainter {
  final int? hoveredPointIndex;

  _TrendChartPainter({this.hoveredPointIndex});

  @override
  void paint(Canvas canvas, Size size) {
    // completed line data
    final completedPoints = [
      Offset(20, size.height * 0.6),
      Offset(70, size.height * 0.4),
      Offset(120, size.height * 0.5),
      Offset(170, size.height * 0.65),
      Offset(220, size.height * 0.55),
      Offset(270, size.height * 0.45),
      Offset(320, size.height * 0.3),
    ];

    // added line data
    final addedPoints = [
      Offset(20, size.height * 0.75),
      Offset(70, size.height * 0.55),
      Offset(120, size.height * 0.65),
      Offset(170, size.height * 0.45),
      Offset(220, size.height * 0.4),
      Offset(270, size.height * 0.35),
      Offset(320, size.height * 0.2),
    ];

    final bluePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final tealPaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final blueDotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final tealDotPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    final blueDotOutlinePaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // draw completed line
    for (int i = 0; i < completedPoints.length - 1; i++) {
      canvas.drawLine(completedPoints[i], completedPoints[i + 1], bluePaint);
    }

    // draw added line
    for (int i = 0; i < addedPoints.length - 1; i++) {
      canvas.drawLine(addedPoints[i], addedPoints[i + 1], tealPaint);
    }

    // draw dots at each point
    for (int i = 0; i < completedPoints.length; i++) {
      if (hoveredPointIndex == i) {
        // Draw larger circle with outline when hovered
        canvas.drawCircle(completedPoints[i], 6, blueDotPaint);
        canvas.drawCircle(completedPoints[i], 6, blueDotOutlinePaint);
      } else {
        canvas.drawCircle(completedPoints[i], 4, blueDotPaint);
      }
    }

    for (int i = 0; i < addedPoints.length; i++) {
      if (hoveredPointIndex == i) {
        // Draw larger circle with outline when hovered
        canvas.drawCircle(addedPoints[i], 6, tealDotPaint);
        final tealOutlinePaint = Paint()
          ..color = Colors.teal.withOpacity(0.3)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas.drawCircle(addedPoints[i], 6, tealOutlinePaint);
      } else {
        canvas.drawCircle(addedPoints[i], 4, tealDotPaint);
      }
    }

    // draw x-axis labels
    final labelStyle = TextStyle(fontSize: 10, color: Colors.black);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final weeks = ['Dec 9', 'Dec 16', 'Dec 23', 'Jan 6', 'Jan 13', 'Jan 20', 'Feb 10'];
    for (int i = 0; i < weeks.length; i++) {
      textPainter.text = TextSpan(text: weeks[i], style: labelStyle);
      textPainter.layout();
      final offset = Offset(
        20 + (50 * i) - textPainter.width / 2,
        size.height + 4,
      ); 
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.hoveredPointIndex != hoveredPointIndex;
  }
}

class _HoverTooltip extends StatelessWidget {
  final int pointIndex;

  const _HoverTooltip({required this.pointIndex});

  @override
  Widget build(BuildContext context) {
    // Data for each week
    final weeks = ['Dec 9', 'Dec 16', 'Dec 23', 'Jan 6', 'Jan 13', 'Jan 20', 'Feb 10'];
    final completedValues = [5, 8, 7, 6, 7, 8, 10];
    final addedValues = [3, 6, 5, 8, 9, 10, 12];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            weeks[pointIndex],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                'Added: ',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                addedValues[pointIndex].toString(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Completed: ',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                completedValues[pointIndex].toString(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
