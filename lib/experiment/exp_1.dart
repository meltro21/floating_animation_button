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
  late Animation<double> subAnimation1;
  late AnimationController animationcontroller;

  @override
  void initState() {
    animationcontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animation = Tween<double>(begin: 0, end: 70).animate(
        CurvedAnimation(parent: animationcontroller, curve: Interval(0, 0.5)));

    animation1 = Tween<double>(begin: 0, end: 6.28319).animate(
        CurvedAnimation(parent: animationcontroller, curve: Interval(0, 0.5)));

    animation2 = Tween<double>(begin: 0, end: 2).animate(
        CurvedAnimation(parent: animationcontroller, curve: Interval(0.6, 1)));

    subAnimation1 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationcontroller, curve: Interval(0.7, 0.8)));

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
    var mediaWidth = MediaQuery.of(context).size.width;
    var mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        // CustomPaint(
        //   painter: MyCircle(animation.value),
        // ),
        Container(
          height: 300,
          width: 310,
          color: Colors.orange,
          child: Stack(
            children: [
              Container(
                child: CustomPaint(painter: OpenPainter1(animation1.value)),
              ),
              Container(
                child: CustomPaint(painter: OpenPainter2(animation2.value)),
              ),
              Positioned(
                left: 220,
                top: 170,
                child: Opacity(
                  opacity: subAnimation1.value,
                  child: Column(
                    children: [Icon(Icons.close), Text('Close')],
                  ),
                ),
              )
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              animationcontroller.reverse();
            },
            child: Text('Press me'))
        // Container(
        //   color: Colors.red,
        //   height: animation.value,
        //   width: 20,
        //   child: Column(children: [
        //     // Container(
        //     //   height: animation.value,
        //     //   width: animation.value,
        //     //   color: Colors.red,
        //     // ),
        //     // AnimatedBuilder(
        //     //     animation: animation,
        //     //     builder: (context, child) {
        //     //       return CustomPaint(
        //     //         painter: MyShape(animation.value),
        //     //         child: Container(),
        //     //       );
        //     //     }),
        //     Icon(
        //       Icons.percent,
        //       size: animation1.value,
        //     ),
        //     Icon(
        //       Icons.people,
        //       size: animation2.value,
        //     ),
        //     // Icon(
        //     //   Icons.close,
        //     //   size: animation.value / 10,
        //     // ),
        //   ]),
        // ),
        // SizedBox(
        //   height: 200,
        // ),
        // ElevatedButton(
        //     onPressed: () {
        //       animationcontroller.reverse();
        //     },
        //     child: Text('Press me'))
      ])),
    );
  }
}

class MyCircle extends CustomPainter {
  var myRadius;
  MyCircle(this.myRadius);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    var path = Path();
    path.addOval(Rect.fromCircle(center: Offset(100, 100), radius: myRadius));

    canvas.drawPath(path, paint);
    print(path.computeMetrics());
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter1 extends CustomPainter {
  var myRadius;
  OpenPainter1(this.myRadius);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;
    //draw arc
    canvas.drawArc(
        Offset(100, 100) & Size(140, 140),
        0, //radians
        myRadius, //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter2 extends CustomPainter {
  var myRadius;
  OpenPainter2(this.myRadius);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromARGB(255, 99, 125, 170)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;
    //draw arc
    canvas.drawArc(
        Offset(100, 100) & Size(140, 140),
        0, //radians
        myRadius, //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MyArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('size is $size');
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    var path = Path();
    path.arcTo(
        Rect.fromLTWH(
            size.width / 2, size.height / 2, size.width / 4, size.height / 4),
        1,
        2,
        true);
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
