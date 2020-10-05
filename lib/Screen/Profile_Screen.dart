import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_mbj/Screen/initialScreen.dart';
import 'package:flutter_app_mbj/Screen/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_mbj/Screen/login.dart';

class Profile_Screen extends StatefulWidget {
  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  int userid;
  String email = "", name = "", phone = "", dob = "", anniversary_date = "";
  @override
  void initState() {
    super.initState();
    restore();
  }

  restore() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      userid = sharedPrefs.getInt("id");
      email = sharedPrefs.getString("email");

      name = sharedPrefs.getString("name");
      phone = sharedPrefs.getString("phone");
      anniversary_date = sharedPrefs.getString("anniversary_date");
      dob = sharedPrefs.getString("dob");
    });
    //TODO: More restoring of settings would go here...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(bottom: 18),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            width: 400,
            height: 400,
            decoration: BoxDecoration(
                color: Color(0xFF670e1e),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150),
                )),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) => Initial()));
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                    GestureDetector(
                      child: Text(
                        "Profile",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.person_outline,
                      color: Color(0xFF670e1e),
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  name ?? 'MBj',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            children: <Widget>[
              Container(
                height: 40,
                color: Colors.grey[300],
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.call,
                      size: 12,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Phone:                     " + '$phone',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                color: Colors.grey[300],
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      size: 10,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Email:                      " + '$email',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                color: Colors.grey[300],
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      size: 12,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "DOB:                        " + '$dob',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                color: Colors.grey[300],
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      size: 12,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Anniversary:           " + '$anniversary_date',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  buttonColor: Theme.of(context).primaryColor,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs?.clear();
                        prefs.setBool('isLoggedIn', false);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) => LandingScreen()),
                            (r) => false);
                      }))
            ],
          )
          /* Container(
              height: 290,
              width: 350,
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: Text(
                      "Email:                                    " + '$email',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    //    subtitle: Text('$email',style: TextStyle( color:Color(0xFF670e1e),fontWeight: FontWeight.w600),),
                  ),
                  ListTile(
                    title: Text(
                      "Date Of Birth:                      " + '$dob',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    // subtitle: Text('$dob',style: TextStyle( color:Color(0xFF670e1e),fontWeight: FontWeight.w600),),
                  ),
                  ListTile(
                    title: Text(
                      "Anniversary date:               " + '$anniversary_date',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    // subtitle: Text('$anniversary_date',style: TextStyle( color:Color(0xFF670e1e),fontWeight: FontWeight.w600),),
                  ),
                  ListTile(
<<<<<<< HEAD
                    title: Text('Log out',style: TextStyle( fontSize:18,fontWeight: FontWeight.w600),),
                    onTap: ()  async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
=======
                    title: Text(
                      'Log out',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
>>>>>>> origin/master
                      prefs?.clear();
                      prefs.setBool('isLoggedIn', false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => LandingScreen()));
                    },
                  ),
                ]).toList(),
              ))*/
        ],
      ),
    );
  }
}
