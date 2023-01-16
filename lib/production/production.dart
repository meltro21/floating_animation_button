import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Production extends StatefulWidget {
  const Production({super.key});

  @override
  State<Production> createState() => _ProductionState();
}

class _ProductionState extends State<Production>
    with SingleTickerProviderStateMixin {
  late Animation _outerCircleAnimation;
  late Animation _innerCircleAnimation;
  late AnimationController _animationController;
  late Path _path;
  bool toggle = false;
  bool onlyOnce = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    //radius
    _outerCircleAnimation = Tween<double>(begin: 0, end: 150).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 0.5)));
    _innerCircleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.5, 1.0),
    ));

    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  toggleHelper(double mediaHeight, double mediaWidth, double myRadius) {
    onlyOnce = false;
    if (toggle == false) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    toggle = !toggle;
  }

  Path drawPath(double mediaHeight, double mediaWidth, double myRadius) {
    // Method to convert degree to radians
    double degToRad(num deg) => deg * (pi / 180.0);
    Path path = Path();
    path.arcTo(
        Rect.fromCircle(
            center: Offset(mediaWidth - 40, mediaHeight - 40),
            radius: myRadius),
        degToRad(120),
        degToRad(200),
        true);
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;
    var mediaHeight = height - padding.top - padding.bottom;

    if (onlyOnce) {
      _path = drawPath(mediaHeight, mediaWidth, 150);
      onlyOnce = false;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          CustomPaint(
            painter: OuterCircle(
                mediaHeight, mediaWidth, _outerCircleAnimation.value),
            child: Container(),
          ),
          onlyOnce == false
              ? Positioned(
                  top: calculate(_innerCircleAnimation.value - 0.26).dy - 12,
                  left: calculate(_innerCircleAnimation.value - 0.26).dx - 30,
                  // top: 100,
                  // left: 100,
                  child:
                      Column(children: [Icon(Icons.ac_unit), Text('Ac Unit')]),
                )
              : SizedBox(),
          onlyOnce == false
              ? Positioned(
                  top: calculate(_innerCircleAnimation.value - 0.48).dy - 10,
                  left: calculate(_innerCircleAnimation.value - 0.48).dx - 40,
                  // top: 100,
                  // left: 100,
                  child: Column(
                      children: [Icon(Icons.access_time), Text('AccessTime')]),
                )
              : SizedBox(),

          onlyOnce == false
              ? Positioned(
                  top: calculate(_innerCircleAnimation.value - 0.66).dy,
                  left: calculate(_innerCircleAnimation.value - 0.66).dx - 26,
                  // top: 100,
                  // left: 100,
                  child:
                      Column(children: [Icon(Icons.ac_unit), Text('Ac Unit')]),
                )
              : SizedBox(),

          // CustomPaint(
          //   painter: PathPainter(_path),
          //   child: Container(),
          // ),
          // CustomPaint(
          //   painter: InnerHalfCircle(mediaHeight, mediaWidth),
          //   child: Container(),
          // ),
          Positioned(
            top: mediaHeight - 70,
            left: mediaWidth - 70,
            child: GestureDetector(
              onTap: () {
                toggleHelper(
                    mediaHeight, mediaWidth, _innerCircleAnimation.value);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(50)),
                height: 60,
                width: 60,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 100.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OuterCircle extends CustomPainter {
  double mediaHeight;
  double mediaWidth;
  double myRadius;
  OuterCircle(this.mediaHeight, this.mediaWidth, this.myRadius);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 100.0;

    canvas.drawCircle(
        Offset(mediaWidth - 40, mediaHeight - 40), myRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
