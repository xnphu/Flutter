import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_challenger/login.dart';
import 'package:flutter_trip_challenger/utils/support_device.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return  Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: '#FAD99A'.toColor(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
//            Stack(
//              fit: StackFit.expand,
//              children: <Widget>[
//                Container(
//                    height: mHeight(context: context, height: 243.2),
//                    width: double.infinity,
//                    child: Image(
//                      image: AssetImage('assets/images/rectangle-82.png'),
//                      fit: BoxFit.fill,
//                    )
//                ),
//                Positioned(
//                  top: mHeight(context: context, height: 105),
//                  left: mWidth(context: context, width: 25),
//                  width: mWidth(context: context, width: 331.85),
//                  height: 47,
//                  child: Container(
//                    child: Text(
//                        'Trip Challenger',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontStyle: FontStyle.normal,
//                        shadows: [
//                          Shadow(
//                            color: Color.fromARGB((0.25 * 255 ).toInt(), 0, 0, 0),
//                            offset: Offset(0,4),
//                            blurRadius: 4
//                          )
//                        ],
//                        fontSize: 40,
//                        color: Colors.red,
//                        letterSpacing: 0.085,
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20),
//              child: Container(
//                height: mHeight(context: context, height: 300),
//                width: double.infinity,
//                child: Stack(
//                  children: <Widget>[
//                    Align(
//                      alignment: Alignment.topLeft,
//                      child: Container(
//                          height: mHeight(context: context, height: 162),
//                          width: mWidth(context: context, width: 135.46),
//                          child: Image(
//                            image: AssetImage('assets/images/splash-triangle-1.png'),
//                            fit: BoxFit.cover,
//                          )
//                      ),
//                    ),
//                    Transform.rotate(
//                      angle: -math.pi / 18.0,
//                      child: Align(
//                        alignment: Alignment.center,
//                        child: Container(
//                            height: mHeight(context: context, height: 217.51),
//                            width: mWidth(context: context, width: 307.27),
//                            child: Image(
//                              image: AssetImage('assets/images/flash.png'),
//                              fit: BoxFit.cover,
//                            )
//                        ),
//                      ),
//                    ),
//                    Align(
//                      alignment: Alignment.bottomRight,
//                      child: Container(
//                          height: mHeight(context: context, height: 159),
//                          width: mWidth(context: context, width: 132),
//                          child: Image(
//                            image: AssetImage('assets/images/splash-triangle-2.png'),
//                            fit: BoxFit.cover,
//                          )
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Stack(
//              children: <Widget>[
//                Container(
//                    height: mHeight(context: context, height: 268.57),
//                    width: double.infinity,
//                    child: Image(
//                      image: AssetImage('assets/images/rectangle-81.png'),
//                      fit: BoxFit.fill,
//                    )
//                ),
//                Positioned(
//                  top: 120,
//                  left: 8,
//                  width: mWidth(context: context, width: 356),
//                  height: mHeight(context: context, height: 24),
//                  child: Container(
//                    child: Text(
//                      'Love is like a butterfly if you let it go and it comes back',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontWeight: FontWeight.w300,
//                        fontStyle: FontStyle.normal,
//                        fontSize: 13,
//                        color: Colors.black,
//                        letterSpacing: 0.666667,
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
          ],
        ),
      ),
    );
  }
}
