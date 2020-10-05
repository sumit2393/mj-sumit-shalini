import 'package:flutter/material.dart';
import 'package:flutter_app_mbj/Models/categories.dart';
import './productdetail.dart';
import '../provider/httpservices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProduclList extends StatefulWidget {
  final mdata;
  final fromp;
  ProduclList({this.mdata, this.fromp});
  _ProduclListstate createState() => _ProduclListstate();
}

class _ProduclListstate extends State<ProduclList> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _controller;
  List categoriesname = [];
  List productlist = [];
  int userid;
  bool isWishlist = false;
  int selectedIndex = 0;
  String bartitle = 'All';
  bool loading = false;
  bool bottomLoading = false;
  int selectedId = -1;
  int initialPage = 1;
  String nexturl;
  String orderby;
  String orderway;
  String price;
  int carat;
  String categoryName;
  int categoryId;

  List<dynamic> sortarray = [
    {
      "title": "Price High to Low",
      "icon": Icon(Icons.arrow_downward, color: Color(0xFF670e1e))
    },
    {
      "title": "Price Low to High",
      "icon": Icon(Icons.arrow_upward, color: Color(0xFF670e1e))
    },
  ];
//  List<String> stones = ["Light", "heavy"];
  List<String> type = ["14", "18", "22", "24"];
  List<String> pricelist = [
    "10001-20000",
    "20001-50000",
    "50001-100000",
    "100001-500000",
    "500001-1000000",
    "1000001-10000000"
  ];
  var _character = "";
//  String dropdownstoneValue;
  String dropdownpriceValue;
  String dropdowntypeValue;
  Subcategories allCate;

  @override
  void initState() {
    super.initState();

    if (widget.fromp == "initial") {
      categoryName = widget.mdata["name"];
      categoryId = widget.mdata["id"];
    } else {
      categoryName = widget.mdata.name;
      categoryId = widget.mdata.id;
    }

    getUserid();
  }

  getUserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getInt("id");

    getCategories(categoryId, "yes");
  }

  getCategories(id, change) {
    setState(() {
      loading = true;
    });
    getFromApiCategories(id, change, initialPage);
  }

  getProductList(id, index, name) {
    setState(() {
      loading = true;
      selectedIndex = index;
      bartitle = name;
    });
    if (name == "All") {
      getCategories(categoryId, "no");
    } else {
      getfromproductapi(id, 0);
    }
  }

  getfromproductapi(id, pagecount) {
    fetchProductlist(id, userid, pagecount, orderby, orderway, price, carat)
        .then((value) => {
              nexturl = value.next_page_url,
              setState(() {
                productlist.addAll(value.data);
                loading = false;
                bottomLoading = false;
              })
            });
  }

  getFromApiCategories(id, change, initialPage) {
    fetchCategories(id, userid, initialPage, orderby, orderway, price, carat)
        .then((value) => {
              allCate = new Subcategories.fromJson({
                "id": -1,
                "mainCategoryId": 1,
                "imagePath": "",
                "name": "All",
                "createdAt": "",
                "updatedAt": ""
              }),
              value.subcategories.insert(0, allCate),
              nexturl = value.next_page_url,
              if (change == "yes")
                {
                  setState(() {
                    bottomLoading = false;
                    loading = false;
                    productlist.addAll(value.allproducts);
                    categoriesname = value.subcategories;
                  }),
                }
              else
                {
                  setState(() {
                    bottomLoading = false;
                    loading = false;
                    productlist.addAll(value.allproducts);
                  }),
                }
            })
        .catchError((e) => {print(e)});
  }

  addToWishlist(productid, isindex, isadded) {
    if (!isadded) {
      addWish(userid, productid).then((value) => {
            if (value["status"] == "success")
              {
                registerToast(value["data"]["message"]),
                setState(() {
                  productlist[isindex].addedToWishList = true;
                })
              }
            else
              {registerToast("Something went wrong Please try again")}
          });
    } else {
      removeWish(userid.toString(), productid.toString()).then((value) => {
            if (value["status"] == "success")
              {
                setState(() {
                  registerToast(value["data"]["message"]);
                  setState(() {
                    productlist[isindex].addedToWishList = false;
                  });
                })
              }
            else
              {registerToast("Something went wrong")}
          });
    }
  }

  requestCall(productid) {
    requestCallback(userid, productid).then((value) => {
          if (value["status"] == "success")
            {registerToast(value["data"]["message"])}
          else
            {registerToast("Something went wrong")}
        });
  }

  demo() {
    productlist = [];
    initialPage = 1;
    if (selectedId == -1) {
      getFromApiCategories(categoryId, "no", initialPage);
    } else {
      getfromproductapi(selectedId, initialPage);
    }
  }

  loadMore() {
    setState(() {
      bottomLoading = true;
    });
    initialPage = initialPage + 1;

    if (selectedId == -1) {
      getFromApiCategories(categoryId, 'no', initialPage);
    } else {
      getfromproductapi(selectedId, initialPage);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color(0xFF670e1e),
        textColor: Colors.white);
  }

  openSort() async {
    _controller = await scaffoldState.currentState.showBottomSheet(
      (BuildContext context) {
        return Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            sheetHeading(context, "Sort"),
            Column(
                mainAxisSize: MainAxisSize.max,
                children: sortarray.map((e) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    leading: e["icon"],
                    title: Text(
                      e["title"],
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    trailing: Radio(
                      activeColor: Theme.of(context).primaryColor,
                      value: e["title"],
                      groupValue: _character,
                      onChanged: (value) {
                        _controller.setState(() {
                          _character = value;
                        });
                      },
                    ),
                  );
                }).toList()),
            Padding(
              padding: const EdgeInsets.only(
                  top: 60.0, bottom: 40, left: 16, right: 16),
              child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      _controller.close();

                      orderby = 'tag_price';
                      if (_character == "Price High to Low") {
                        orderway = 'desc';
                      } else {
                        orderway = "asc";
                      }

                      demo();
                    },
                    child: Text("APPLY"),
                  )),
            )
          ],
        );
      },
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    );
  }

  Padding sheetHeading(BuildContext context, title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 70, 40),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading:
            //Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(title,
              //textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }

  openfilter() {
    setstone(data) {
      _controller.setState(() {
        //dropdownstoneValue = data;
      });
    }

    setprice(data) {
      _controller.setState(() {
        dropdownpriceValue = data;
      });
    }

    settype(data) {
      _controller.setState(() {
        dropdowntypeValue = data;
      });
    }

    _controller = scaffoldState.currentState.showBottomSheet(
        (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 20),
        child: Wrap(alignment: WrapAlignment.center, children: <Widget>[
          sheetHeading(context, "Filters"),
          dropDown(
              context,
              {"hinttext": "Price", "list": pricelist, "changevalue": setprice},
              dropdownpriceValue),
//          dropDown(
//              context,
//              {"hinttext": "Stones", "list": stones, "changevalue": setstone},
//              dropdownstoneValue),
          dropDown(
              context,
              {"hinttext": "Carat", "list": type, "changevalue": settype},
              dropdowntypeValue),
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 20, left: 16, right: 16),
            child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (dropdownpriceValue != null) {
                      price = dropdownpriceValue;
                    }
                    if (dropdowntypeValue != null) {
                      carat = int.parse(dropdowntypeValue);
                    }
                    demo();
                  },
                  child: Text("APPLY"),
                )),
          )
        ]),
      );
    },
        backgroundColor: Colors.grey[200],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)));
  }

  Container dropDown(BuildContext context, dropdata, setv) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 5.0,
              spreadRadius: 0.5,
              offset: Offset(1.0, 1.0),
            ),
          ]),
      child: Row(children: [
        Icon(Icons.person, color: Theme.of(context).primaryColor),
        Expanded(
          child: DropdownButton<dynamic>(
            underline: SizedBox(),
            hint: Text(
              dropdata["hinttext"],
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            isExpanded: true,
            value: setv,
            icon: Icon(Icons.arrow_drop_down,
                color: Theme.of(context).primaryColor),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Theme.of(context).primaryColor),
            onChanged: (newValue) {
              dropdata["changevalue"](newValue);
            },
            items: dropdata["list"].map<DropdownMenuItem>((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        body: Stack(children: <Widget>[
          NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    nexturl != null) {
                  loadMore();
                }
              },
              child: ListView(
                padding: EdgeInsets.only(bottom: 50),
                children: <Widget>[
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(12),
                    // foregroundDecoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: NetworkImage(widget.mdata.imageUrl,
                    //             scale: 30.0))),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage(
                          "assets/images/product/background.jpg"),
                    )),
                    child: Stack(children: <Widget>[
                      Positioned.fill(
                        bottom: 50,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              categoryName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
                            )),
                      ),
                      Positioned(
                          left: 0,
                          top: 20,
                          child: Row(
                            children: <Widget>[
                              FlatButton.icon(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  bartitle,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          )),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        right: 0,
                        child: SizedBox(
                            height: 20,
                            width: double.infinity,
                            child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Text(
                                    " | ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  );
                                },
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categoriesname.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      initialPage = 1;
                                      selectedId = categoriesname[index].id;
                                      productlist = [];
                                      getProductList(categoriesname[index].id,
                                          index, categoriesname[index].name);
                                    },
                                    child: Text(
                                      categoriesname[index].name,
                                      style: TextStyle(
                                          color: (index == selectedIndex)
                                              ? Colors.yellow
                                              : Colors.white),
                                    ),
                                  );
                                })),
                      )
                    ]),
                  ),
                  Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          filter({
                            "image": "assets/images/product/Filter_Icon.png",
                            "name": "FILTER",
                            "size": 14.0,
                            "recievecallback": openfilter
                          }),
                          filter({
                            "image": "assets/images/product/Sort_Icon.png",
                            "name": "SORT",
                            "size": 14.0,
                            "recievecallback": openSort
                          }),
                        ],
                      )),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: Theme.of(context).primaryColor,
                        ))
                      : productlist.length != 0
                          ? Container(
                              color: Theme.of(context).primaryColor,
                              child: GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  itemCount: productlist.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 18,
                                    crossAxisSpacing: 16,
                                    crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height -
                                            200),
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        child: Stack(children: <Widget>[
                                          Column(children: <Widget>[
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetail(
                                                                productdata:
                                                                    productlist[
                                                                        index])));
                                              },
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: NetworkImage(
                                                              productlist[index]
                                                                  .image
                                                                  .url,
                                                              scale: 30.0)))),
                                            )),
                                            // Text(productlist[index].name),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 7),
                                                child: Text(
                                                  productlist[index].name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )),
                                            Text(
                                                "\u20B9" +
                                                    productlist[index]
                                                        .tagPrice
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                )),

                                            ButtonTheme(
                                                minWidth: 200.0,
                                                height: 28.0,
                                                buttonColor: Theme.of(context)
                                                    .primaryColor,
                                                child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Text(
                                                      "REQUEST A CALLBACK",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 8),
                                                    ),
                                                    onPressed: () {
                                                      requestCall(
                                                          productlist[index]
                                                              .id);
                                                    }))
                                          ]),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  addToWishlist(
                                                      productlist[index].id,
                                                      index,
                                                      productlist[index]
                                                          .addedToWishList);
                                                },
                                                child: Icon(Icons.favorite,
                                                    size: 16,
                                                    color: productlist[index]
                                                            .addedToWishList
                                                        ? Colors.red
                                                        : Colors.grey[500]),
                                              )),
                                        ]));
                                  }),
                            )
                          : Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "No Products available",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                  bottomLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: Theme.of(context).primaryColor,
                        ))
                      : Container()
                ],
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 8),
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      filter({
                        "name": "100% \nHalmark Jewellery",
                        "image": "assets/images/product/certified.png",
                        "size": 10.0
                      }),
                      filter({
                        "name": "Refund Policy",
                        "image": "assets/images/product/return.png",
                        "size": 10.0
                      }),
                      filter({
                        "name": "World Wide\nShipping",
                        "image": "assets/images/product/Free_Shipp.png",
                        "size": 10.0
                      }),
                    ]),
              ))
        ]));
  }
}

Widget filter(data) {
  return FlatButton.icon(
    icon: Image.asset(
      data["image"],
      height: 18,
    ),
    label: Text(
      data["name"],
      style: TextStyle(color: Colors.black, fontSize: data["size"]),
    ),
    onPressed: () {
      data["recievecallback"]();
    },
  );
}
