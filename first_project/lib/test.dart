import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  dd()async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    print(sp.get("email"));
    print(sp.get('name'));
    print(sp.get('userid').runtimeType);
    print(sp.get('city_id').runtimeType);
  }
  @override
  Widget build(BuildContext context) {
    dd();
    return MaterialApp(home: Scaffold(appBar: AppBar(),body: ListView(children: [

    ],),),);
  }
}
