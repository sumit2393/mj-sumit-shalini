import 'package:flutter/material.dart';
import 'package:flutter_app_mbj/Screen/AboutUs.dart';
import 'package:flutter_app_mbj/Screen/FAQ.dart';
import 'package:flutter_app_mbj/Screen/Terms&Condition.dart';
import './Home.dart';

import './Wishlist.dart';
import './Notification.dart';
import './Profile_Screen.dart';
import './searchproduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import './product.dart';

import 'package:url_launcher/url_launcher.dart';

List<dynamic> tabsdata = [
  {
    "icon": "assets/images/home/Home_ICon.png",
    "page": Home(),
    "title": Image.asset(
      "assets/images/home/Home_Page_Logo_Icon.png",
      height: 40,
      width: 60,
      //fit: BoxFit.cover,
    )
  },
  {
    "icon": "assets/images/home/wish_Icon.png",
    "page": Wishlist(),
    "title": Text("Wishlist")
  },
  {
    "icon": "assets/images/home/Offer_ICon.png",
    "page": Home(),
    "title": Text("Wishlist")
  },

  {
    "icon": "assets/images/home/Bell_Icon.png",
    "page": Notificationlist(),
    // "title": Text("Wishlist")
  },
  // {"icon":"assets/images/home/Gold_icon.png"},
  // {"icon":"assets/images/home/Cart_ICon.png"}
];

const drawerdata = [
  {"title": "Profile", "moveto": ""},
  {"title": "Collection", "moveto": ""},
  {"title": "Products", "moveto": ""},
  {"title": "About", "moveto": ""},
  {"title": "Contact us", "moveto": ""},
];

class Initial extends StatefulWidget {
  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  String username;
  String phone;
  bool isexpnaded = false;

  List socialitems = [
    {
      "image": "assets/images/drawer/FB.png",
      "url": "https://www.facebook.com/thehouseofmbj/"
    },
    {
      "image": "assets/images/drawer/Insta.png",
      "url": "https://instagram.com/thehouseofmbj?igshid=gm88kie4g0m7"
    },
    {"image": "assets/images/drawer/YOUTUBE.png", "url": "https://www.youtube.com/channel/UCICmKZgd6wuGfdfINkFssBw"},
  ];
  List expansionlist = [
    {
      "title": "GOLD COLLECTION",
      "goto": ProduclList(),
      "licon": "assets/images/drawer/Gold.png",
      "id": 3,
      "name": "Gold"
    },
    {
      "title": "DIAMOND COLLECTION",
      "goto": ProduclList(),
      "licon": "assets/images/drawer/Diamond.png",
      "id": 2,
      "name": "Diamond"
    },
    {
      "title": "POLKI COLLECTION",
      "goto": ProduclList(),
      "licon": "assets/images/drawer/Polki.png",
      "id": 1,
      "name": "Polki"
    }
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    getUserdetail();
  }

  void getUserdetail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("name");

    setState(() {
      username = preferences.getString("name");
      phone = preferences.getString("phone");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          title: tabsdata.elementAt(_selectedIndex)["title"],
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
                onTap: () => _scaffoldKey.currentState.openDrawer(),
                child: Image.asset(
                  "assets/images/home/Menu-Icon.png",
                  height: 24,
                  width: 24,
                )),
          ),
          actions: <Widget>[
            /* GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Notificationlist())),
              child: Image.asset(
                "assets/images/home/Bell_Icon.png",
                height: 14,
                width: 14,
              ),
            ),*/
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchProduct())),
                  child: Image.asset(
                    "assets/images/product/Search_Icon.png",
                    height: 16,
                    width: 16,
                  ),
                ))
          ],
        ),
      ),
      drawer: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(45), bottomRight: Radius.circular(45)),
          child: Container(
            width: MediaQuery.of(context).size.width - 80,
            child: Drawer(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: <Widget>[
                    buildDrawer(context),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ExpansionTile(
                          trailing: isexpnaded
                              ? Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                            color: Theme.of(context).primaryColor,
                          )
                              : Image.asset("assets/images/drawer/dropdown.png",
                              height: 14),
                          onExpansionChanged: (bool expanded) {
                            setState(() {
                              isexpnaded = expanded;
                            });
                          },
                          title: Labelnavigation(info: {
                            "name": "",
                            "title": "OUR COLLECTION",
                            "goto": "",
                            "licon": "assets/images/drawer/Jewellery_Icon.png"
                          }),
                          children: expansionlist
                              .map((e) => buildListTile(context, e))
                              .toList()),
                    ),
                    buildListTile(context, {
                      "name": "",
                      "title": "Brand Story",
                      "goto": About(),
                      "licon": "assets/images/drawer/About_us.png"
                    }),
                    buildListTile(context, {
                      "name": "",
                      "title": "FAQs",
                      "goto": FAQ(),
                      "licon": "assets/images/drawer/FAQ.png"
                    }),
                    buildListTile(context, {
                      "name": "",
                      "title": "TERMS & CONDITIONS",
                      "goto": Terms(),
                      "licon": "assets/images/drawer/Terms_Condition.png"
                    }),
                    buildListTile(context, {
                      "name": "",
                      "title": "PROFILE",
                      "goto": Profile_Screen(),
                      "licon": "assets/images/drawer/Profile.png"
                    }),
                    socialContainer(context)
                  ],
                )),
          )),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: tabsdata
            .map((e) => BottomNavigationBarItem(
            backgroundColor: Color(0xFF670e1e),
            title: Text(""),
            icon: Image.asset(
              e["icon"],
              height: 24,
            )))
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: tabsdata.elementAt(_selectedIndex)["page"],
    );
  }

  Container buildDrawer(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(bottom: 20),
      color: Theme.of(context).primaryColor,
      child: DrawerHeader(
          padding: EdgeInsets.zero,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
             /* FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: Text("Edit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)))*/
            ]),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.person_outline,
                color: Color(0xFF670e1e),
                size: 30,
              ),
            ),
            SizedBox(height: 8),
            Text(
              username,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("+91-" + phone,
                style: TextStyle(color: Colors.white, fontSize: 12))
          ])),
    );
  }

  ListTile buildListTile(BuildContext context, info) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 40),
      title: Labelnavigation(info: info),
      onTap: () {
        Navigator.pop(context);
        if (info["name"] == "") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => info["goto"]));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProduclList(mdata: info, fromp: "initial")));
        }
      },
    );
  }

  socialContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: socialitems
              .map((e) => GestureDetector(
            onTap: () async {
              if (await canLaunch(e["url"])) {
                await launch(e["url"]);
              } else {
                throw 'Could not launch ${e["url"]}';
              }
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Image.asset(e["image"], height: 18),
            ),
          ))
              .toList()),
    );
  }
}

class Labelnavigation extends StatelessWidget {
  final info;
  const Labelnavigation({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Image.asset(info["licon"], height: 18.0),
            )),
        TextSpan(
            text: info["title"],
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black))
      ]),
    );
  }
}
