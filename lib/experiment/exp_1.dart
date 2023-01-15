import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Exp1 extends StatefulWidget {
  const Exp1({super.key});

  @override
  State<Exp1> createState() => _Exp1State();
}

class _Exp1State extends State<Exp1> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late AnimationController animationcontroller;

  @override
  void initState() {
    animationcontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animation = Tween<double>(begin: 0, end: 60).animate(
        CurvedAnimation(parent: animationcontroller, curve: Interval(0, 1)));

    animation1 = Tween<double>(begin: 0, end: 30).animate(CurvedAnimation(
        parent: animationcontroller, curve: Interval(0.0, 0.5)));

    animation2 = Tween<double>(begin: 0, end: 30).animate(
        CurvedAnimation(parent: animationcontroller, curve: Interval(0.5, 1)));

    animation.addListener(() {
      setState(() {});
      //set animation listiner and set state to update UI on every animation value change
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {}
    });
    animationcontroller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Container(
          color: Colors.red,
          height: animation.value,
          width: 20,
          child: Column(children: [
            // Container(
            //   height: animation.value,
            //   width: animation.value,
            //   color: Colors.red,
            // ),
            // AnimatedBuilder(
            //     animation: animation,
            //     builder: (context, child) {
            //       return CustomPaint(
            //         painter: MyShape(animation.value),
            //         child: Container(),
            //       );
            //     }),
            Icon(
              Icons.percent,
              size: animation1.value,
            ),
            Icon(
              Icons.people,
              size: animation2.value,
            ),
            // Icon(
            //   Icons.close,
            //   size: animation.value / 10,
            // ),
          ]),
        ),
        SizedBox(
          height: 200,
        ),
        ElevatedButton(
            onPressed: () {
              animationcontroller.reverse();
            },
            child: Text('Press me'))
      ])),
    );
  }
}

class MyCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MyShape extends CustomPainter {
  double mySize;
  MyShape(this.mySize);

  @override
  void paint(Canvas canvas, Size size) {
    print('size is $size');
    print('mySize is $mySize');
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40;

    Path path = Path();
    //path.moveTo(0, 0);
    //path.quadraticBezierTo(10, 40, 100, mySize);
    path.lineTo(0, mySize);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
