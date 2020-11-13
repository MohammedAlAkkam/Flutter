import 'package:ferstproject/home.dart';
import 'package:flutter/material.dart';
import './main.dart';
import 'package:ferstproject/combonent.dart'as dec;
import 'dart:convert' as Convert;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as T;
class Sing_in extends StatefulWidget {
  @override
  _Sing_inState createState() => _Sing_inState();
}

class _Sing_inState extends State<Sing_in> {
  TextEditingController password = TextEditingController();
  TextEditingController Email = TextEditingController();
  Future<bool> Sing_in_request() async {
    Map<String, String> map = {
      'email': Email.text,
      'password': password.text,
      "device_name": "android",
      "version": "1.0"
    };
    var url = "http://mzn.tradinos.com/api/signin";
    var Response = await post(url, body: map);
    var Responsebody = Convert.jsonDecode(Response.body);
    T.Toast.show(Responsebody["message"],context);
       SharedPreferences sp = await SharedPreferences.getInstance();

    if (Responsebody['status']) {
      print(Responsebody["data"]);
      sp.setString('lastname', Responsebody['data']['user']["lastname"]);
      sp.setString('name', Responsebody['data']['user']["name"]);
      sp.setString('email', Responsebody['data']['user']["email"]);
      sp.setString('city_id', Responsebody['data']['user']["city_id"].toString());
      sp.setString('phone', Responsebody['data']['user']["phone"]);
      sp.setString('userid', Responsebody['data']['user']["id"].toString());
      sp.setString('password',  Responsebody['data']['user']["password"]);
      sp.setString('token',  Responsebody['data']['token']);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return Home();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: Scaffold(
      body: Directionality(textDirection:dec.dec[1] ,child: ListView(
        children: [
         //Positioned(top: 200, child: Text('Sing in',style: TextStyle(fontSize: 33,fontWeight:FontWeight.w600 ,color: Colors.white)),width: 50,),
          Container(
            child: Image.asset("images/Mask Group 16.png",width: MediaQuery.of(context).size.width,fit: BoxFit.fill),
          ),
          Transform.translate(offset: Offset(20,-200),child: Text('Sing in',style: TextStyle(fontSize: 45,fontWeight:FontWeight.w600 ,color: Colors.white)),),

          Container(
            height: 50,
            child: TextField(
              controller: Email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Email"),
            ),
            margin: EdgeInsets.only(top: 30, left: 30, right: 30),
          ),
          Container(
            height: 50,
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "password"),
            ),
            margin: EdgeInsets.only(top: 30, left: 30, right: 30),
          ),
          Container(
            child: FlatButton(
              child: Text(
                "Sing in",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Sing_in_request();
              },
            ),
            decoration: dec.combonent.decoratbtn(Colors.orange, Colors.orange),
            margin: EdgeInsets.only(top: 40, right: 30, left: 30),
            height: 40,
          )
        ],
      ),),
    ));
  }
}
