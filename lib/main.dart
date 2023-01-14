import 'package:animated_floatingbutton/experiment/exp_1.dart';
import 'package:animated_floatingbutton/experiment/exp_2.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Hello',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationcontroller;

  double startVal = 0;
  double endVal = 0;
  bool flag = true;
  bool firstTime = true;

  @override
  void initState() {
    animationcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    animation = Tween<double>(begin: 0, end: 500).animate(animationcontroller);
    animation.addListener(() {
      setState(() {});
      //set animation listiner and set state to update UI on every animation value change
    });

    super.initState();
  }

  setAnimation(double mediaHeight, double mediaWidth) {
    animation = Tween<double>(
      begin: 0,
      end: mediaWidth * 1.5,
    ).animate(animationcontroller);
    firstTime = false;
  }

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    if (firstTime == true) {
      setAnimation(mediaHeight, mediaWidth);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.pink,
        height: mediaHeight,
        width: mediaWidth,
        child: Stack(
          children: [
            //outer circle
            Positioned(
              bottom: -mediaWidth * 1.5 / 2,
              right: -mediaWidth * 1.5 / 2,
              child: Stack(children: [
                Container(
                  color: Colors.purple,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, //making box to circle
                          color:
                              Colors.deepOrangeAccent //background of container
                          ),
                      height: animation.value, //value from animation controller
                      width: animation.value, //value from animation controller
                    ),
                  ),
                ),

                // Positioned(
                //   bottom: -10,
                //   child: Container(
                //     height: 300,
                //     width: 10,
                //     color: Colors.yellow,
                //   ),
                // ),
                //inner circle
                Positioned(
                  bottom: mediaWidth * 1.5 / 4,
                  right: mediaWidth * 1.5 / 4,
                  child: Container(
                    color: Colors.blue,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, //making box to circle
                            color: Colors.white //background of container
                            ),
                        height: animation.value /
                            2, //value from animation controller
                        width: animation.value /
                            2, //value from animation controller
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            CustomPaint(
              painter: OpenPainter(animation.value),
            ),
            //button
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  onPressed: () {
                    startVal = 0;
                    endVal = mediaWidth * 0.6;

                    if (flag == true) {
                      animationcontroller.forward();
                      flag = false;
                    } else {
                      animationcontroller.animateBack(0);
                      flag = true;
                    }
                  },
                  child: Text(flag == true ? 'S' : 'H'),
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class OpenPainter extends CustomPainter {
  double mySize;
  OpenPainter(this.mySize);
  // @override
  // void paint(Canvas canvas, Size size) {
  //   var paint1 = Paint()
  //     ..color = Color(0xff63aa65)
  //     ..style = PaintingStyle.stroke
  //     ..strokeWidth = 20;
  //   //draw arc
  //   canvas.drawArc(
  //       Offset(120, 450) & Size(mySize, mySize),
  //       3.14159, //radians
  //       1.5708, //radians
  //       false,
  //       paint1);
  // }

  @override
  void paint(Canvas canvas, Size size) {
    print('size is $size');
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.moveTo(0, mySize / 2);
    path.quadraticBezierTo(mySize / 2, mySize, mySize, mySize / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SmilyFaceSmile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2 + (size.height * 0.15)),
        height: size.height,
        width: size.width,
      ),
      -pi,
      -pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class NotAmused extends CustomPainter {
  double mySize;
  NotAmused(this.mySize);
  @override
  void paint(Canvas canvas, Size size) {
    //mouth
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(mySize / 2, mySize / 2 + mySize * 0.28),
        height: mySize * 0.2,
        width: mySize * 0.4,
      ),
      0,
      -pi,
      false,
      Paint()..color = Colors.black,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
