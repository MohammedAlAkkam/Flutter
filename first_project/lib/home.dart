import 'dart:convert' as Convert;
import 'dart:ui';
import 'package:ferstproject/All_order.dart';
import 'package:ferstproject/My_Cat.dart';
import 'package:ferstproject/Myorder.dart';
import 'package:ferstproject/firstpage.dart';
import 'package:ferstproject/item.dart';
import 'package:ferstproject/setting.dart';
import 'package:ferstproject/tr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart';
import 'package:ferstproject/mylist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'combonent.dart' as comb;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toast/toast.dart' as T;

//var email, password, name, lastname, dvicename, varsion, user_id;

class Home extends StatelessWidget {
  List f = <flower>[];
  http(BuildContext context) async {
    user = new User();
    // var url = "http://mzn.tradinos.com/api/get_arrangments";
    /*var map ={"email":email,'pasword': password,"device_name" : "android"
      ,"version" : "1.0"};*/
    SharedPreferences sp = await SharedPreferences.getInstance();

    user.Email = sp.getString("email");
    user.name = sp.getString('name');
    user.password = sp.getString('password');
    user.token = sp.getString('token');
    print('+++++++++++++++++++++++++++++++');
    user.user_id = int.parse(sp.getString('userid'));
    user.city_id = int.parse(sp.getString('city_id'));
    print("${user.user_id} ;;${ user.city_id}");
    print(user.name);
    var Respomse = await get(
        "http://mzn.tradinos.com/api/get_arrangments?email=${user.Email}&password=${user.password}&device_name=android&version=1.0");
    var Responsbody = Convert.jsonDecode(Respomse.body);
    print(Respomse);
    return Responsbody;
  }

  double width_ = 200;
  @override
  Widget build(BuildContext context) {
    List url = <Image>[];
    List<flower> f = [];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: http(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //url.add(Image.network("http://mzn.tradinos.com/arrangment_image/tray_to_arrangment145.jpg"));
              for (int i = 0; i <4 /* snapshot.data['data'].length*/; i++) {
                var x = snapshot.data['data'][i];
                url.add(Image.network(
                  x['image_url'],
                ));
                int tt =0;
                   try{
                      tt=int.parse(x['price']);
                   }catch(e){
                     tt = 670;
                   }
                f.add(flower(
                    description: x['description'],
                    name: x['name'],
                    price: tt.toString(),
                    url: x['image_url'],
                    id: x['id'],
                    size_id: x['sizes'][0]['id']));
              }
              return home(f, url);
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class home extends StatefulWidget {
  home(List<flower> b, List<Image> images) {
    f = b;
    Url = images;
  }
  @override
  _HomeState createState() => _HomeState();
}

List f = <flower>[];
List Url = <Image>[];

class _HomeState extends State<home> {
  var ht;
  double button = 10;
  double widthe;
  Container c = Container(
    height: 0,
  );
  bool close = true;
  var icon = Icons.arrow_drop_down;
  bool btn = true;
  @override
  Widget build(BuildContext context) {
    var txt = AppLocalization.localizationString;
    widthe = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Container(height: 120,color: Colors.orange,),
              Image.asset("images/Mask Group 13.png",color: Colors.orange,),
              Stack(
                children: [
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(20, -140),
                      child: Text(
                        "${user.name}",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
              InkWell(
                child: Container(
                  child: Text(
                    "My order",
                    style: TextStyle(fontSize: 20),
                  ),
                  margin: EdgeInsets.all(30),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return all_order();
                    },
                  ));
                },
              ),
              InkWell(
                child: Container(
                  child: Text(
                    "log out",
                    style: TextStyle(fontSize: 20),
                  ),
                  margin: EdgeInsets.all(30),
                ),
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("do you wont log out"),
                        actions: [
                          FlatButton(
                            color: Colors.orange,
                            child: Text(
                              'yes',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              sp.remove("name");
                              sp.remove("lastname");
                              sp.remove("email");
                              sp.remove("password");
                              sp.remove("phon");
                              sp.remove("Birthday");
                              sp.remove("city_id");
                              sp.remove("userid");
                              sp.remove('token');
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return MaterialApp(
                                      home: Scaffold(body: login()));
                                },
                              ));
                            },
                          ),
                          FlatButton(
                            child: Text('no'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  /**/
                },
              )
            ],
          ),
        ),
        body: NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
    return [SliverAppBar(
    leading: InkWell(child:Icon(Icons.menu,size: 40,),onTap: (){Scaffold.of(context).openDrawer();},),
    actions: [Container(child:InkWell(child: Icon(Icons.shopping_cart_sharp,size: 35,),onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return My_Cat();
    },));},),margin: EdgeInsets.only(right: 30),)],
    backgroundColor: Colors.orange,
    expandedHeight: 90.0,
    title: Text(' '),
    centerTitle: true,
    floating: true,
    pinned: true,

    flexibleSpace: FlexibleSpaceBar(
    centerTitle: true,

    background: Image.asset("images/Mask Group -1.png",fit: BoxFit.fitWidth,),
    ),

    )];
    },body: Container(
          
            child: ListView(
          children: [

            SizedBox(
                width: MediaQuery.of(context).size.width,
                  child: Carousel(
                      borderRadius: true,
                      radius: Radius.circular(10),
                      boxFit: BoxFit.fitWidth,
                      dotSize: 3.0,
                      dotIncreasedColor: Color(0xFFFF335C),
                      dotBgColor: Colors.transparent,
                      dotVerticalPadding: 10.0,
                      indicatorBgPadding: 0,
                      animationDuration: Duration(milliseconds: 500),
                      autoplay: true,
                      images: Url),
                
                height: 150),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20, top: 2, bottom: 3),
              child: Text(
                "Category",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              color: Colors.grey.withOpacity(0.3),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 30),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Container(
                    // margin: margen,
                    width: 800,
                    height: 100,
                    decoration: mydecoration(
                        B_tl: 10, B_tr: 10, B_bl: button, B_br: button),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Text("Ready arrangement",
                                    textDirection: comb.dec[comb.DI],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      child: Icon(
                                        icon,
                                        color: Colors.orange,
                                        size: 35,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (close) {
                                            button = 0;
                                            icon = Icons.arrow_drop_up;
                                            c = new Container(
                                              height: 265,
                                              margin: EdgeInsets.only(top: 20),
                                              child: Scrollbar(
                                                  child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: f.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    child: mycard(f[index]),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) {
                                                          return item(f[index]);
                                                        },
                                                      ));
                                                    },
                                                  );
                                                },
                                              )),
                                              decoration: mydecoration(
                                                  B_bl: 10, B_br: 20),
                                            );
                                          } else {
                                            button = 10;
                                            c = new Container(
                                              height: 0,
                                            );
                                            icon = Icons.arrow_drop_down;
                                          }
                                          close = !close;
                                        });
                                      },
                                    )))
                          ],
                        ),
                        Container(
                          child:
                              Text("Pick an arrangement to be delivered for you"),
                        )
                      ],
                    ),
                  ),
                  c,
                ],
              ),
            ),
       ])),
      ),
    ));
  }

  Widget wae(
      {@required VoidCallback click,
      String title,
      String text,
      EdgeInsetsGeometry margen}) {
    return Container(
      margin: margen,
      width: 800,
      height: 100,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  child: Text(title,
                      textDirection: comb.dec[comb.DI],
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
              Expanded(
                  child: Container(
                child: InkWell(
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.orange,
                    size: 35,
                  ),
                  onTap: click,
                ),
                alignment: Alignment.centerRight,
              ))
            ],
          ),
          Container(
            child: Text(
              text,
              textDirection: comb.dec[comb.DI],
            ),
          )
        ],
      ),
    );
  }

  _IconPresd() {
    setState(() {
      print(
          "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      c = new Container(
        width: widthe,
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              children: [mm("images/Group 23.png", 200.toString(), "CCCCC")],
            )
          ],
        ),
      );
      print(
          "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    });
  }

  Widget mm(String path, String price, String Discribtion) {
    return Column(
      children: [
        Image.asset(path),
        Row(
          children: [
            Container(
                child: Text(
              "price",
              style: TextStyle(
                color: Colors.red,
              ),
              textDirection: comb.dec[comb.DI],
            ))
          ],
        )
      ],
    );
  }
}

class flower {
  int size_id;
  String price;
  String url;
  String name;
  String description;
  int id;
  flower(
      {this.price,
      this.url,
      this.name,
      this.description,
      this.id,
      this.size_id});
}

mycard(flower f) {
  var s = '';
  if (f.description.length > 30)
    for (int i = 0; i < 30; i++) s += f.description[i];
  else
    s = f.description;
  s += '...';
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10),
    child: Column(
      children: [
        Container(
            height: 130,
            width: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(f.url), fit: BoxFit.cover))),
        Stack(children: [
          Positioned(
            child: Transform.translate(
              offset: Offset(2.5, -9),
              child: Container(
                width: 140,
                height: 80,
                decoration:
                    mydecoration(B_tr: 18, B_tl: 18, B_br: 18, B_bl: 18),
                child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          f.name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, bottom: 3),
                          child: Text("price ",
                              style: TextStyle(color: Colors.orange)),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "${f.price}",
                            )),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 21),
                        child: Text(
                          s,
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 10),
                        ))
                  ],
                ),
              ),
            ),
          )
        ])
      ],
    ),
    margin: EdgeInsets.only(right: 10),
  );
}

mydecoration(
    {double B_bl = 0, double B_br = 0, double B_tr = 0, double B_tl = 0}) {
  return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(B_bl),
          bottomRight: Radius.circular(B_br),
          topRight: Radius.circular(B_tr),
          topLeft: Radius.circular(B_tl)));
}
