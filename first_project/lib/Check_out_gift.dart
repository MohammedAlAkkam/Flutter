import 'package:ferstproject/item.dart';
import 'package:flutter/material.dart';
import 'Sing_up.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Check_out_gift extends StatefulWidget {
  @override
  _Check_out_giftState createState() => _Check_out_giftState();
}

File f;

class _Check_out_giftState extends State<Check_out_gift> {
  Future<void> pickercamera(ImageSource c) async {
    final myfile = await ImagePicker().getImage(source: c);
    setState(() {
      f = File(myfile.path);
    });
  }

  bool Same_address = false;
  bool Add_card = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 70;
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          children: [
            Image.asset('images/Mask Group 13.png'),
            Stack(
              children: [
                Transform.translate(
                  offset: Offset(30, -100),
                  child: Image.asset("images/Component 1 – 3.png"),
                ),
                Transform.translate(
                  offset: Offset(90, -100),
                  child: Text('Chekd out',
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
                Transform.translate(
                    offset: Offset(300, -100),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 40,
                    )),
              ],
            ),
            Container(
              child: Text(
                'Pickup',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
              ),
              margin: EdgeInsets.only(top: 10, left: 20),
            ),
            Container(
              height: 7,
              color: Colors.orange,
              margin: EdgeInsets.only(top: 10),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              child: Text(
                'Share yore location',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: DropdownButtonFormField(
                    items: [],
                    onChanged: null,
                    hint: Text('city'),
                  ),
                  width: width / 2,
                ),
                Container(
                  child: myTxt(hint: 'Area', i: 1),
                  width: width / 2,
                  margin: EdgeInsets.only(left: 20),
                )
              ],
            ),
            myTxt(hint: 'Street'),
            myTxt(hint: 'Hous Number'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width / 2,
                  child: myTxt(hint: 'Date', i: 1),
                  margin: EdgeInsets.only(right: 20),
                ),
                Container(
                  width: width / 2,
                  child: myTxt(hint: 'Time', i: 1),
                  margin: EdgeInsets.only(left: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              padding: EdgeInsets.only(top: 10, left: 30, bottom: 10),
              color: Colors.grey.withOpacity(0.2),
              child: Row(
                children: [
                  Text(
                    "Delivery",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                      child: Container(
                    child: Checkbox(
                      value: Same_address,
                      onChanged: (value) {
                        setState(() {
                          Same_address = value;
                        });
                      },
                      activeColor: Colors.orange,
                    ),
                    height: 4,
                    alignment: Alignment.centerRight,
                  )),
                  Container(
                    child: InkWell(
                      child: Text(
                        'Same address',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        setState(() {
                          Same_address = !Same_address;
                        });
                      },
                    ),
                    margin: EdgeInsets.only(right: 10),
                  )
                ],
              ),
            ),
            myTxt(hint: 'Date'),
            myTxt(hint: 'time'),
            Container(
              margin: EdgeInsets.only(top: 3),
              padding: EdgeInsets.only(top: 10, left: 30, bottom: 10),
              color: Colors.grey.withOpacity(0.2),
              child: Text(
                "Gift info",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width / 3,
                  child: myTxt(size: 10, hint: 'width(cm)', i: 1),
                  margin: EdgeInsets.only(left: 10),
                ),
                Container(
                    width: width / 3,
                    child: myTxt(size: 10, hint: 'Height(cm)  ', i: 1),
                    margin: EdgeInsets.only(left: 10)),
                Container(
                    width: width / 3,
                    child: myTxt(size: 10, hint: 'length(cm)', i: 1),
                    margin: EdgeInsets.only(left: 10)),
              ],
            ),
            myTxt(hint: 'Nots'),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(right: 30, left: 30, top: 15, bottom: 20),
              child: Row(children: [
                Text(
                  'Take a photo of the gift',
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Container(
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.orange,
                    ),
                    onTap: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Image source'),
                            actions: [
                              FloatingActionButton(
                                onPressed: () {
                                  pickercamera(ImageSource.camera);
                                },
                                child: Text('camer'),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  pickercamera(ImageSource.gallery);
                                },
                                child: Text('galory'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  alignment: Alignment.centerRight,
                ))
              ]),
            )),
            Container(
              height: 30,
              color: Colors.grey.withOpacity(0.3),
            ),
            Container(
              child: Row(
                children: [
                  Checkbox(
                    value: Add_card,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      Add_card = value;
                    },
                  ),
                  InkWell(
                    child: Text(
                      'Add acard',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      setState(() {
                        Add_card = !Add_card;
                      });
                    },
                  )
                ],
              ),
            ),
            Transform.translate(
                offset: Offset(0, 60),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding: EdgeInsets.only(top: 10, bottom: 70, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Start from",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Container(
                        child: Text(
                          '590 ',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.lerp(Colors.blue, Colors.black, 0.85),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(children: [
                dd('Pickup', '250 AED'),
                dd('Delivery', '25.0 AED'),
                dd('VAT', '25 AED'),
                dd('Total', '25 AED'),
                Container(
                  width: 300,
                  child: FlatButton(
                    child: Text(
                      "Chek Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Check_out_gift();
                        },
                      ));
                    },
                  ),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  margin: EdgeInsets.only(bottom: 40, top: 40),
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }
}

Container myTxt(
    {Color bcolor,
    String hint,
    int i,
    double size = 18,
    TextEditingController c}) {
  var mm;
  if (bcolor == null) bcolor = Colors.grey.withOpacity(0.3);
  if (i == null)
    mm = EdgeInsets.only(left: 30, right: 30, top: 15);
  else
    mm = EdgeInsets.only(top: 15, bottom: 10);
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(color: bcolor, style: BorderStyle.solid, width: 2))),
    height: 35,
    child: TextFormField(
      controller: c,
      //autofocus: false,
      style: TextStyle(
        fontSize: size,
        color: Colors.grey,
      ),
      decoration: decoration(hint: hint, bordercolor: Colors.white),
    ),
    margin: mm,
  );
}

Container dd(String title, String Price, {double fontsize, int i}) {
  if (fontsize == null) fontsize = 17;
  return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: fontsize,
                color: Colors.white,
                fontWeight: FontWeight.w800),
          ),
          Expanded(
              child: Container(
            child: Text(
              Price,
              style: TextStyle(color: Colors.white, fontSize: fontsize),
            ),
            alignment: Alignment.centerRight,
          ))
        ],
      ));
}
//http://mzn.tradinos.com/api/get_arrangments?email=mohammed123@gmail.com&password=moh1234&device_name=android&version=1.0
