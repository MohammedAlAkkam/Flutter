import 'package:ferstproject/Check_out_gift.dart';
import 'package:ferstproject/home.dart';
import 'package:ferstproject/item.dart';
import 'package:ferstproject/mylist.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class alert extends StatefulWidget {
  alert(flower e, Tray b) {
    f = e;
    t = b;
    f.name = format(f.name);
    t.name = format(t.name);
  }
  @override
  _alertState createState() => _alertState();
}

flower f;
Tray t;

class _alertState extends State<alert> {
  TextEditingController Nots = new TextEditingController();
  var counterarrg = 0;
  var countertrays = 0;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(30)),),
      child: MaterialApp(debugShowCheckedModeBanner: false,
          home: Scaffold(
              body:ListView(
        children: [

          Container(
            padding: EdgeInsets.only(left: 20, top: 2, bottom: 3),
            child: Text(
              'Arrangement',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            color: Colors.grey[350],
          ),
          Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
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
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            '  ${f.name}',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w700),
                          ),
                          margin: EdgeInsets.only(top: 10),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Price ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                Text(
                                 "${ f.price}",
                                  style: TextStyle(color: Colors.orange),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Image.asset("images/min.png"),
                            onTap: minus1,
                          ),
                          Container(
                            child: Text(
                              counterarrg.toString(),
                              textAlign: TextAlign.center,
                            ),
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.orange, width: 2))),
                            padding: EdgeInsets.all(10),
                          ),
                          InkWell(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              onTap: plus1),
                        ]),
                    margin: EdgeInsets.all(5),
                  ))
                ],
              )),
          Container(
            padding: EdgeInsets.only(left: 20, top: 2, bottom: 3),
            child: Text(
              'Tray',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            color: Colors.grey[350],
          ),
          Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
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
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            '  ${t.name}',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w700),
                          ),
                          margin: EdgeInsets.only(top: 10),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Price ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                Text(
                                  t.price.toString(),
                                  style: TextStyle(color: Colors.orange),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child:Image.asset("images/min.png"),
                            onTap: minus2,
                          ),
                          Container(
                            child: Text(
                              countertrays.toString(),
                              textAlign: TextAlign.center,
                            ),
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.orange, width: 2))),
                            padding: EdgeInsets.all(10),
                          ),
                          InkWell(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              onTap: plus2),
                        ]),
                    margin: EdgeInsets.all(5),
                  ))
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            color: Colors.grey[300],
            height: 20,
          ),
          myTxt(hint: 'Nots', c: Nots),
          FlatButton(
            child: Text(
              'Add To Card',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              arrags.add(arrag(arg_count: counterarrg, arg_id: f.id,url: f.url,price: f.price,title: f.name,arg_size: f.size_id));
              trays.add(tray(try_id: t.id, try_count: countertrays,url:t.url,title: t.name,price: t.price));
              nots.add(Nots.text);
              Navigator.of(context).pop();
            },
          ),],
      ))),
      margin: EdgeInsets.only(top: 120, bottom: 60, left: 20, right: 20),
      width: 10,
      height: 10,
    );
  }

  minus1() {
    setState(() {
      if (counterarrg != 0) counterarrg--;
    });
  }

  plus1() {
    setState(() {
      counterarrg++;
    });
  }

  plus2() {
    setState(() {
      countertrays++;
    });
  }

  minus2() {
    setState(() {
      if (countertrays != 0) countertrays--;
    });
  }
}

String format(String x) {
  var s = "";
  for (int i = 1; i <= x.length; i++) {
    s += x[i - 1];

    if (i % 16 == 0) {
      s += '\n';
    }
  }

  return s;
}
