import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class Exp3 extends StatefulWidget {
  Exp3();

  @override
  State<StatefulWidget> createState() {
    return Exp3State();
  }
}

class Exp3State extends State<Exp3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Path _path;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    //_controller.forward();
    _path = drawPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 300,
          width: 350,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                child: CustomPaint(
                  painter: PathPainter(_path),
                ),
              ),
              Positioned(
                top: calculate(_animation.value).dy,
                left: calculate(_animation.value).dx,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  width: 10,
                  height: 10,
                ),
              ),
              Positioned(
                top: calculate(_animation.value - 0.3).dy,
                left: calculate(_animation.value - 0.3).dx,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  width: 10,
                  height: 10,
                ),
              ),
              Positioned(
                top: calculate(_animation.value - 0.6).dy,
                left: calculate(_animation.value - 0.6).dx,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  width: 10,
                  height: 10,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _controller.forward();
              //_controller.reverse();
            },
            child: Text('Press me'))
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path drawPath() {
    Size size = Size(300, 300);
    Path path = Path();
    path.moveTo(0, size.height / 2);

    // Method to convert degree to radians
    double degToRad(num deg) => deg * (pi / 180.0);
    // path.quadraticBezierTo(
    //     size.width / 2, size.height, size.width, size.height / 2);

    path.arcTo(Rect.fromCircle(center: Offset(100, 100), radius: 120),
        degToRad(90), degToRad(270), true);
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
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
      ..strokeWidth = 30.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
