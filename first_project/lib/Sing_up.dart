import 'package:ferstproject/combonent.dart';
import 'package:ferstproject/home.dart';
import 'package:ferstproject/item.dart';
import 'package:ferstproject/mylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './main.dart';
import 'dart:convert'as Convert;
import './combonent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class Sing_up extends StatefulWidget {
  Sing_up(List<city> c){
    citys = c;
  }
  @override
  _Sing_upState createState() => _Sing_upState();
}
http()async{
  //var url = "https://jsonplaceholder.typicode.com/todos";
  var url = "http://mzn.tradinos.com/api/get_cities";
  var rs =await get(url);
  var rsb = Convert.jsonDecode(rs.body);

  print("---------------------");
  return rsb;
}
List<city> citys = <city>[];
List<String> thint= ["name","lastname","Email","password", "phon","Birthday"];
var userid;
var token;
class _Sing_upState extends State<Sing_up> {
 var b_date =  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 2));
 var b_city = Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 2));
  save() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.setString("name", name.text);
    p.setString("lastname", lastname.text);
    p.setString("email", Email.text);
    p.setString("password", password.text);
    p.setString("phon", phon_number.text);
    p.setString("Birthday", barthday);
    p.setString("city_id", select);
    p.setString("userid", userid.toString());
    p.setString("token", token);
  }

  Future<dynamic> view() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    for (int i = 0; i < thint.length; i++) {
      print(p.get(thint[i]));
    }
    return p.get("name");
  }


  var select = "citys";
  Color __name = Colors.white;
  Color __lastname = Colors.white;
  Color __password = Colors.white;
  Color __Email = Colors.white;
  Color __phon_number = Colors.white;
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController phon_number = TextEditingController();
  String barthday = "BarthDay";
  @override
  Widget build(BuildContext context) {
    TextFormField _name = TextFormField(style: TextStyle(fontSize: 17) ,controller: name,
      decoration: decoration(hint: 'name', bordercolor: __name),);
    TextFormField _lastname = TextFormField(style: TextStyle(fontSize: 17),controller: lastname,
        decoration: decoration(hint: 'Lsat Name', bordercolor: __lastname));
    TextFormField _password = TextFormField(style: TextStyle(fontSize: 17),controller: password,
        decoration: decoration(hint: 'password', bordercolor: __password));
    /////////////
    TextFormField _Email = TextFormField(style: TextStyle(fontSize: 17),controller: Email,
        decoration: decoration(hint: 'Email', bordercolor: __Email));
    ////////////////////////////
    TextFormField _phon_number = TextFormField(style: TextStyle(fontSize: 17),controller: phon_number,
        decoration: decoration(hint: 'phon number', bordercolor: __phon_number));

    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
            children: [
              Image.asset("images/Mask Group 11.png",width: MediaQuery.of(context).size.width,fit: BoxFit.fill),
              Container(decoration:BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 2))),height: 34,margin: EdgeInsets.only(top: 20,left: 30,right: 30),child:_name,),
              Container(decoration:BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 2))),height: 34,margin: EdgeInsets.only(top: 20,left: 30,right: 30),child:_lastname,),
              Container(decoration:BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 2))),height: 34,margin: EdgeInsets.only(top: 20,left: 30,right: 30),child:_Email,),
              Container(decoration:BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 2))),height: 34,margin: EdgeInsets.only(top: 20,left: 30,right: 30),child:_password,),
              Container(decoration:BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 2))),height: 34,margin: EdgeInsets.only(top: 20,left: 30,right: 30),child:_phon_number),
              Container(decoration:BoxDecoration(color: Colors.grey.withOpacity(0.16),border: b_date),padding: EdgeInsets.all(8),margin: EdgeInsets.only(top: 20,right: 30,left: 30),child:InkWell(child:Text(barthday,style: TextStyle(fontSize: 18),),onTap: (){setState(() {
                showDatePicker(
                  context: context, initialDate: DateTime(2000), firstDate: DateTime(1950), lastDate: DateTime.now(), ).then((value) {
                    setState(() {
                barthday =value.year.toString()+"/"+value.month.toString()+"/"+value.day.toString();});} );
              });},) ,),
            Container(decoration:BoxDecoration(color: Colors.grey.withOpacity(0.16),border: b_city,),
            child:citys.length == 0? FutureBuilder(future: http(),builder: (context, snapshot) {
    if(snapshot.hasData) {
    for (int i = 0; i < 6; i++) {
    print(citys);
    var s = snapshot.data["data"][i];
    citys.add(city(name: s["name"],id: s["id"].toString()));
    } return DropdownButtonFormField(hint: Text("citys"),
        style: TextStyle(fontSize: 15, color: Colors.black),
        items: citys.map((e) {
          print(e.id);
          return DropdownMenuItem(child: Text(e.name), value: e.id);
        }).toList(),
        onChanged: (value) {
          select = value;
        });

            }else return Center(child: CircularProgressIndicator());},):DropdownButtonFormField(hint: Text("citys"),
                style: TextStyle(fontSize: 15, color: Colors.black),
                items: citys.map((e) {
                  print(e.id);
                  return DropdownMenuItem(child: Text(e.name), value: e.id);
                }).toList(),
                onChanged: (value) {
                  select = value;
                }),
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),padding: EdgeInsets.only(left: 5),
              ),

        Container(child: FlatButton(
                child: Text(
                  "Sing up", style: TextStyle(color: Colors.white, fontSize: 20,),),
                onPressed: () {
                  setState(() {

                    if (name.text == "") {
                      __name = Colors.red;
                      return;
                    }else{
                      __name = Colors.white;
                    }
                    if (lastname.text == "") {
                      __lastname = Colors.red;
                      return;

                    }else{
                      __lastname = Colors.white;
                    }
                    if (Email.text == "") {
                      __password = Colors.red;
                      return;
                    }else{
                      __password = Colors.white;
                    }
                    if (phon_number.text == "") {
                      __phon_number = Colors.red;
                      return;
                    }else{
                      __phon_number = Colors.white;
                    }
                    if (password.text == "") {
                      __Email = Colors.red;
                      return;
                    }else{
                      __Email = Colors.white;
                    }
                    if(select == "citys"){
                      b_city =  Border.all(color: Colors.red,style: BorderStyle.solid,width: 1);
                      return;
                    }
                    else b_date = Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 1));
                    if(barthday == "BarthDay"){
                      b_date = Border.all(color: Colors.red,style: BorderStyle.solid,width: 1);
                    return;
                    }
                    else b_date = Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15),style: BorderStyle.solid,width: 1));

                  Sing_up_Requist();
                  print("++++++++++++++++++++++++++++++++++");
                  save();
                });}
            ), decoration: combonent.decoratbtn(Colors.orange, Colors.orange),
              margin: EdgeInsets.only(left: 30, right: 30, top: 30),)
            ]
        ),)
      ,
    );
  }

  bool cc = false;

  Sing_up_Requist() async {
    print(select);
    Map<String, String> map = {

      "name": name.text,
      "lastname": lastname.text,
      "email": Email.text,
      "password": password.text,
      "phone": phon_number.text,
      "birthday": barthday,
      "device_name": "android",
      "version": "1.0",
      "city_id": select
    };

    var url = "http://mzn.tradinos.com/api/signup";
    var respons = await post(url, body: map);
    var resb = Convert.jsonDecode(respons.body);
    print("++++++++++++++++++++++++++++++++++++++++++");
    Toast.show(resb["message"].toString(), context, gravity:4,
      duration: 3,);
    if (resb["status"]) {
      userid = resb['data']['user']['id'];
      token = resb['data']['token'];
      save();
      print("=================++++++++++++++++++=-----------------");
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Home();
      },));
    }
    return resb;
  }
}
  InputDecoration decoration({String hint, Color bordercolor}) {
    return InputDecoration(labelText: hint,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(4),topLeft: Radius.circular(4)),
            borderSide: BorderSide(color: bordercolor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            color: Colors.white, style: BorderStyle.none, width: 5)),
        labelStyle: TextStyle(color: Colors.black),
        //filled: false,
        //fillColor: Colors.grey.withOpacity(0.16),
        contentPadding: EdgeInsets.all(10));
  }

  Widget decorattxt(
      {String hint, TextEditingController control, EdgeInsetsGeometry margen, Color bordercolor = Colors
          .white}) {
    return
      Container(height: 35,
        child: TextFormField(
          controller: control, decoration: InputDecoration(labelText: hint,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: bordercolor)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: bordercolor)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                color: Colors.white, style: BorderStyle.none, width: 5)),
            labelStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.16),
            contentPadding: EdgeInsets.all(10)),),
        margin: margen,);
  }
/*
   Container(margin: EdgeInsets.only(left: 20,right: 20,bottom: 60,top: 40),height: 40,child: DropdownButton<String>(
         iconEnabledColor: Colors.orange,
           hint:Text("city") ,
          items: Citys.map((e) {
            return DropdownMenuItem<String>(
              child: Text(e),
              value: e,);
          }).toList(),
          onChanged: (item){
            setState(() {
              citysclect = item;
            });
          },),decoration: BoxDecoration(
           borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
           //border: Border(bottom: BorderSide(color: Colors.orange,style: BorderStyle.solid,width: 2)),
           color: Colors.grey.withOpacity(0.3),
           ),)*/

  class city {
  String name;
  String id;
 double pricedel;
  city({this.name, this.id,this.pricedel});

  factory city.fromjson(Map<String, dynamic> map){
  return city(id: map["id"], name: map["name"]);
  }

  ToMap(city) {
  Map<String, String> map = {"name": city.name, "id": city.id};
  return map;
  }
  }
