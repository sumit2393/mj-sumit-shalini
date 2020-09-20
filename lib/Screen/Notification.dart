import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String mainUrl = "http://portal.mbj.in/api/";
const String notificationurl= mainUrl + "notifications/";
const String notificationread= mainUrl + "notificationread/";

class Notificationlist extends StatefulWidget {
  _Notificationlist createState() => _Notificationlist();
}
class _Notificationlist extends  State<Notificationlist> {


  bool loading = false;
  int userid,statuscode;


  Future<List<Notification>> fetchnotification(userid) async {
    final response = await http.get( notificationurl + userid.toString());
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((notification) => new Notification.fromJson(notification)).toList();;
    } else {
      throw Exception('Failed to load notification');
    }
  }

  getuserid() async {
    print("userid function called");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getInt("id");
    print("userid" + userid.toString());
    fetchnotification(userid).then((value) async => {
      print("Notifications list"),
      setState((){
       // notificationlist= value.notify;
       //  notificationlist.map((e) => print("notification" + e));
      })
  });
    }


 
  @override
  void initState() {
    super.initState();
    getuserid();
    setState(() {
      loading = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        FutureBuilder(
          future: fetchnotification(userid),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }else{

              List<Notification> notificationsList = snapshot.data;

              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  itemCount: notificationsList.length,
                  itemBuilder: (context, int index) {
                    return
                      GestureDetector(

                        onTap: (){
                          // todo:// call notification read api
                          http.post(notificationread + notificationsList[index].id.toString());
                        },

                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.only(top: 16),
                            child: ListTile(
                              trailing: Icon(
                                Icons.more_horiz,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                              ),
                              contentPadding: EdgeInsets.all(20),
                              leading: Container(
                                height: 58,
                                width: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(29),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            notificationsList[index].imagePath))),
                              ),
                              title: Text(
                                notificationsList[index].header,
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  notificationsList[index].message,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            )),
                      );
                  });
            }
          },
        ));
  }

}
class Notification {
  int id;
  int userId;
  String header;
  String message;
  String imagePath;
  int status;
  String createdAt;
  String updatedAt;
  int read;

  Notification(
      {this.id,
        this.userId,
        this.header,
        this.message,
        this.imagePath,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.read});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    header = json['header'];
    message = json['message'];
    imagePath = json['image_path'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['header'] = this.header;
    data['message'] = this.message;
    data['image_path'] = this.imagePath;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['read'] = this.read;
    return data;
  }
}

