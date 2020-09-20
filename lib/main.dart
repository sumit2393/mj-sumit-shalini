import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/initialScreen.dart';

import 'Screen/landing_screen.dart';

import 'Screen/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Color(0xFF670e1e),
            unselectedWidgetColor: Color(0xFF670e1e),
            buttonTheme: ButtonThemeData(
                buttonColor: Color(0xFF670e1e),
                textTheme: ButtonTextTheme.primary)),
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext ctx) => Initial()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext ctx) => LandingScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Color(0xFF670e1e),
      body: new Center(
        child: Image.asset("assets/images/Mbj.png", height: 300, width: 300),
      ),
    );
  }
}
