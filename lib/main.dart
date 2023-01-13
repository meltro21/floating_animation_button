import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Animations'),
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
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, //making box to circle
                        color: Colors.deepOrangeAccent //background of container
                        ),
                    height: animation.value, //value from animation controller
                    width: animation.value, //value from animation controller
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
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, //making box to circle
                          color: Colors.white //background of container
                          ),
                      height:
                          animation.value / 2, //value from animation controller
                      width:
                          animation.value / 2, //value from animation controller
                    ),
                  ),
                ),
              ]),
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
