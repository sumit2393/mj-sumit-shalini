import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_mbj/Screen/productdetail.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'package:flutter_app_mbj/Provider/httpservices.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  String _date = "Date Of Birth";
  String _anniversary="Anniversary";
  String email, name, number, dob,anniversary_date;
  bool _secureText = true;
  bool checkBoxValue = false;

  TextEditingController _dobController = new TextEditingController();
  TextEditingController _anniversaryController = new TextEditingController();
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  @override
  void initState() {
    super.initState();
    email = "";
    name = "";
    dob="";
    number="";
    anniversary_date="";
  }
  save() async {
    Map<dynamic,dynamic> rawBody = {
      "name": name,
      "email": email,
      "dob": dob,
      "phone":number,
      "anniversary_date":anniversary_date,
    };
    final response = await http.post("http://portal.mbj.in/api/auth/sign-up", body: rawBody);
    var data = jsonDecode(response.body);
    print(data.toString());
    if(data["status"]=='success'){
      String message = data['data']['message'];

//      setState(() {
//        Navigator.pop(context);
//      });
//      registerToast(message);

      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 20),
              child: Stack(overflow: Overflow.visible, children: [
                Container(
                  height: 360,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 90, bottom: 20),
                      ),
                      const Text("We are Verifying your details, Your account will be activated in next 1-2 working days.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 35),
                        color: Colors.white,
                        height: 1.5,
                        width: 40.0,
                      ),
                      Contactbutton(label: "Connect With Experts",type: "call",),
                      SizedBox(height: 12),
                      Contactbutton(label: "Connect with Whatsapp", type:"message"),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Business hours 10am-7pm",style: TextStyle(fontSize: 10, color: Colors.white),)
                    ],
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: Color(0xFF670e1e),
                    ),
                    height: 60,
                    width: 60,
                    child: Icon(Icons.info_outline,color:Colors.white ,),
                  ),
                ),
              ]),
            );

          },
          backgroundColor: Color(0xFF670e1e),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
      );



    }else{
      List<dynamic> errors = data["errors"];
      errors.forEach((element) {
        registerToast(element["errorMessage"]);
      });
    }
  }
  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          child: Stack(
              children: <Widget>[
                Container(
                  height: 440,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/curve.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Column(
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
                            padding: EdgeInsets.all(40),
                            child: new  Column(
                              children: <Widget>[
                                Container(
                                //  margin: EdgeInsets.only(top: 10),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'Register',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))
                                    ]),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                                  child: TextField(

                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                       // fontWeight: FontWeight.bold
                                    ),
                                    cursorColor: Colors.white,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12),
                                      filled: true,
                                      fillColor: Color.fromRGBO(83, 0, 23, 3.0),
                                      hintText: 'Name',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onChanged: (input) {
                                      setState(() {
                                        name = input;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                       // fontWeight: FontWeight.bold
                                    ),
                                    cursorColor: Colors.white,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12),
                                      filled: true,
                                      fillColor: Color.fromRGBO(83, 0, 23, 3.0),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onChanged: (input) {
                                      setState(() {
                                        email = input;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(13),
                                      filled: true,
                                      fillColor: Color.fromRGBO(83, 0, 23, 3.0),
                                      hintText: 'Number',
                                      counterText: "",
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                                      prefixIcon: Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                          size:15
                                      ),
                                    ),
                                    onChanged: (input) {
                                      setState(() {
                                        number=input;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                                  child: TextField(
                                    controller: _dobController,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      //  fontWeight: FontWeight.bold
                                    ),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(13),
                                      filled: true,
                                      fillColor: Color.fromRGBO(83, 0, 23, 3.0),
                                      hintText: 'Date Of Birth',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: (){
                                      DatePicker.showDatePicker(context,
                                        theme: DatePickerTheme(
                                          containerHeight: 250.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime(1950, 1, 1),
                                        maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
                                          print('confirm $date');
                                          var date1 = date.toString();
                                          var date2=date1.split(" ");
                                          print(date2);
                                          setState(() {
                                            dob=date2[0].toString();
                                            _dobController.text=date2[0].toString();
                                          });
                                          _date = '${date.year} - ${date.month} - ${date.day}';
                                        },
                                      );
                                    },
                                    onChanged: (input) {
                                      setState(() {
                                        dob=input;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                                  child: TextField(
                                    controller: _anniversaryController,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        //fontWeight: FontWeight.bold
                                    ),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(13),
                                      filled: true,
                                      fillColor: Color.fromRGBO(83, 0, 23, 3.0),
                                      hintText: 'Wedding Anniversary',
                                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: (){
                                      DatePicker.showDatePicker(context,
                                        theme: DatePickerTheme(
                                          containerHeight: 250.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime(1950, 1, 1),
                                        maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
                                          print('confirm $date');
                                          var ann_date1 = date.toString();
                                          var date2=ann_date1.split(" ");
                                          print(date2);

                                          _date = '${date.year} - ${date.month} - ${date.day}';
                                          setState(() {
                                            anniversary_date=date2[0].toString();
                                            _anniversaryController.text = date2[0].toString();
                                          });
                                        },
                                      );
                                    },
                                    keyboardType: null,
                                    onChanged: (input) {
                                      setState(() {
                                        anniversary_date=input;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),

                                Container(
                                  padding: EdgeInsets.only(top: 30, left: 10.0, right: 5.0),
                                  child: SizedBox(
                                    width: 250,
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(22.0),
                                          side: BorderSide(color: Colors.white)),
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () {
                                        save();
                                      },
                                      child:
                                      const Text('Submit', style: TextStyle(fontSize: 18,color: Color(0xFF670e1e))),
                                    ),
                                  ),

                                ),

                                Container(

                                  padding: EdgeInsets.only( top: 10,left:40),
                                  child: Row(
                                    children: <Widget>[
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.white,
                                        ),
                                        child: Checkbox(
                                          checkColor: Colors.red,
                                          activeColor: Colors.white,
                                          value: checkBoxValue,
                                          onChanged: (bool value) {
                                            setState(() {
                                              checkBoxValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Text('I agree to Terms & Conditions',style: TextStyle(color:Colors.white,fontSize: 13),)
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],

                ),
              ]),
        )
    );
  }
}
class Contactbutton extends StatelessWidget {
  final String label;
  final String type;
  const Contactbutton({Key key, this.label, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: 220,
        child: RaisedButton(
          elevation: 8,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: Colors.white,
          onPressed: () {
            print("m calling");
            if (type == "call") {
              launch("tel://18001039500");
            } else {
              print("do message");
              FlutterOpenWhatsapp.sendSingleMessage("918824760069", "Hello");
            }

            Navigator.pop(context);
          },
          child: Text(
            label,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ));
  }
}