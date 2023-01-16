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
  late AnimationController _animationController;

  bool toggle = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    //radius
    _outerCircleAnimation = Tween<double>(begin: 0, end: 150).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 1)));

    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  toggleHelper() {
    if (toggle == false) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    toggle = !toggle;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;
    var mediaHeight = height - padding.top - padding.bottom;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          CustomPaint(
            painter: OuterCircle(
                mediaHeight, mediaWidth, _outerCircleAnimation.value),
            child: Container(),
          ),
          // CustomPaint(
          //   painter: InnerHalfCircle(mediaHeight, mediaWidth),
          //   child: Container(),
          // ),
          Positioned(
            top: mediaHeight - 70,
            left: mediaWidth - 70,
            child: GestureDetector(
              onTap: () {
                toggleHelper();
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

class InnerHalfCircle extends CustomPainter {
  double mediaHeight;
  double mediaWidth;
  double myRadius;
  InnerHalfCircle(this.mediaHeight, this.mediaWidth, this.myRadius);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 193, 147, 147).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0;

    // Method to convert degree to radians
    double degToRad(num deg) => deg * (pi / 180.0);

    Path path = Path();
    // path.arcTo(Rect.from  Rect.fromLTWH(mediaWidth - 40, mediaHeight - 40, 100, 100),
    //     degToRad(90), degToRad(270), true);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(mediaWidth - 40, mediaHeight - 40),
            radius: myRadius),
        degToRad(90),
        degToRad(270),
        true);
    canvas.drawPath(path, paint);
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
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 100.0;

    canvas.drawCircle(
        Offset(mediaWidth - 40, mediaHeight - 40), myRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
