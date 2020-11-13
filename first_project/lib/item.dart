import 'dart:ui';
import 'package:ferstproject/My_Cat.dart';
import 'package:ferstproject/combonent.dart';
import 'package:ferstproject/home.dart';
import 'package:ferstproject/item_and_tay.dart';
import 'package:ferstproject/mylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toast/toast.dart';
class item extends StatefulWidget {
  item(flower p) {
    f = p;
  }
  @override
  _itemState createState() => _itemState();
}

flower f;
Tray t;
flower f1;
Tray t1;

class _itemState extends State<item> {
  int length = trays.length;
  List<Color> colors =<Color>[];
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Stack(
          children: [

            ListView(children: [
              Container(
                child: Image.network(f.url,),
              ),
              Container(
                child: Text(
                  f.name,
                  style: TextStyle(fontSize: 40),
                ),
                margin: EdgeInsets.only(left: 20, top: 10),
              ),
              Container(
                child: Text(
                  f.description,
                  style: TextStyle(
                      fontSize: 20, color: Colors.grey.withOpacity(0.5)),
                ),
                margin: EdgeInsets.only(left: 25, top: 10, right: 25),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, top: 2, bottom: 3),
                child: Text(
                  "Tray  You may like",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                color: Colors.grey.withOpacity(0.3),
              ),
              Container(
                  height: 150,
                  child: ListView.builder(itemCount:2,scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                        Tray t1 = mt[index];
                        colors.add(Colors.white);
                        return Container(margin: EdgeInsets.all(10),child:InkWell(child:Image.asset(t1.url),onTap: (){setState((){t = t1;recolor(index);});}),decoration: BoxDecoration(color: colors[index],border: Border.all(color: colors[index],width: 3)),);
                      },)),

              Container(
                padding: EdgeInsets.only(left: 30),
                  color: Colors.grey[800],
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "Price",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      Container(
                        child: Text("${f.price}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300)),
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              for(int i = 0;i<colors.length;i++){
                                colors[i] = Colors.white;
                              }
                            });
                            setState(() {

                              //setState(() {
                              if (t == null) {
                                Toast.show('select Trays', context);
                                return 0;
                              }
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    f1 = f;
                                    t1 = t;
                                    t = null;
                                    return alert(f1, t1);
                                  });
                            });
                          },
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        width: 150,
                        decoration:
                        combonent.decoratbtn(Colors.orange, Colors.orange),
                        margin: EdgeInsets.only(top: 25, left: 10, bottom: 25),
                        height: 40,
                      ),
                    ],
                  )),
            ],
            ),
            Positioned(top:30,right:-10,child:  Row(
              children: [
                FlatButton(child: Image.asset("images/shopping-cart.png"),onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return My_Cat();
                },));},),

                length == 0
                    ? Container(
                  width: 0,
                  height: 0,
                )
                    : count(),
              ],
            ),)],)
      ),
    );
  }
  /**/
  recolor(int x){
    for(int i =0 ;i<colors.length;i++) {
      colors[i] = Colors.white;
    }
    colors[x] = Colors.deepOrangeAccent;
    }
  }

/*         */
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

Widget count() {
  return Transform.translate(offset: Offset(-40,-15),
    child: Container(width:15,height: 15,child:Center(
      child: Text(
        trays.length.toString(),
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    ),
    decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(7.5)))),
  );
}

class Tray {
  int id;
  String name;
  String url;
  String price;
  Tray({this.id, this.name, this.url, this.price});
}
