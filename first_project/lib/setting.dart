import 'package:ferstproject/main.dart';
import 'package:ferstproject/mylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(children:[ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 2, bottom: 3),
            child: Text(
              "select your language",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            color: Colors.grey.withOpacity(0.3),
          ),
          Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children:[Radio(activeColor: Colors.orange,value: 'ar', groupValue: val1,onChanged: (value){setState(() {val1 = value;});refrach(context);},),Text('Credit card',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w300),)
            ,Radio(activeColor: Colors.orange ,value: 'en', groupValue: val1,onChanged: (value){setState(() {val1 = value;});refrach(context);},),Text("Cash on delivery",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w300))]))
        ],
      ),/*Positioned(child: Container(height: 170,width: MediaQuery.of(context).size.width,decoration:BoxDecoration(color: Colors.white,image: DecorationImage(image: AssetImage("images/Path -1.png"),fit: BoxFit.fitWidth)),child:Row(children:[Container(child:Image.asset("images/Component 1 – 3.png"),margin: EdgeInsets.only(left: 15),),Expanded(child:Container(child:Text('Setting'),alignment: Alignment.center,))],)))*/])),
    );
  }
  refrach(BuildContext context)
  {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
   // Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MyApp();
    },));
  }
}
