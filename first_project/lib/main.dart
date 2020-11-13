import 'package:ferstproject/Ceck_out2.dart';
import 'package:ferstproject/combonent.dart';
import 'package:ferstproject/setting.dart';
import 'package:ferstproject/test.dart';
import 'package:ferstproject/tr.dart';
import './sing_in.dart';
import './Sing_up.dart';
import 'package:ferstproject/firstpage.dart';
import 'package:ferstproject/Sing_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> ishas() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    return p.getString("name") != null;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body:FutureBuilder(
        future: ishas(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if (snapshot.data)
              return Home();
            else
              return login();
          }else return CircularProgressIndicator();
        },
      )),
        );
  }
}
/*Container decorattxt({String hintText,TextEditingController controle}){
  return Container(
    height: 50,
    child: TextField(
      controller: controle,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
          ),hintText: "password"
      ),

    ),margin: EdgeInsets.only(top: 30,left: 30,right: 30),);
}*/
