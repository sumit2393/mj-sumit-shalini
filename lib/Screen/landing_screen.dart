import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_mbj/Screen/SignUp.dart';
import 'package:flutter_app_mbj/Screen/login.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:flutter_page_indicator/flutter_page_indicator.dart';
class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen> {
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 430,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/curve.jpg"),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(190),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage(
                                "assets/images/background_maroon.png"),
                            fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(80))
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10)
                                  )
                                  ]
                              ),
                            ),
                            Container(
                              height: 70,
                              child: Image.asset("assets/images/compicon.png"),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 120, right: 120),
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 3,
                                )),
                            SizedBox(
                              height: 70,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: ButtonTheme(
                                  minWidth: 300.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                     padding: EdgeInsets.only(right:20),
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            22.0),
                                      ),
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment
                                            .center,

                                        children: <Widget>[
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(

                                            "Login",
                                            style: TextStyle(
                                                color: Color(0xFF670e1e),
                                                fontSize: 18,),
                                          ),

                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      })),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: ButtonTheme(
                                padding: EdgeInsets.only(left: 10),
                                  height: 50.0,
                                  child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            22.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[

                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Register",

                                            style: TextStyle(
                                              color: Color(0xFF670e1e),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Signup()));
                                      })),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
