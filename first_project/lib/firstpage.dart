import 'package:ferstproject/home.dart';
import 'package:ferstproject/sing_in.dart';
import 'package:flutter/material.dart';
import 'package:ferstproject/Sing_up.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart' as T;
import 'dart:convert'as Convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ferstproject/combonent.dart';
class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}
List<city> citys = <city>[];
class _loginState extends State<login> {
  /*http()async{
    //var url = "https://jsonplaceholder.typicode.com/todos";
    var url = "http://mzn.tradinos.com/api/get_cities";
    var rs =await get(url);
    var rsb = Convert.jsonDecode(rs.body);

    print("---------------------");
    return rsb;
  }*/
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [Image.asset("images/Mask Group 15.png",width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
            Positioned(
              child: Transform.translate(offset: Offset(25,200)
                  ,child: Column(children: [
                    Text("Welcome to",style: TextStyle(fontSize: 33,fontWeight:FontWeight.w600 ),),
                    Text("MEZEN",style: TextStyle(fontSize: 33,fontWeight:FontWeight.w600 ,color: Colors.orange[200])),
                  ],)
              ),
            )
          ],
        ),
         /*FutureBuilder(
              future: http(),
              builder: (context, snapshot){
              if(snapshot.hasData) {
              for (int i = 0; i < snapshot.data["data"]['city'].length; i++) {
              print(citys);
              var s = snapshot.data["data"][i];
              citys.add(city(name: s["name"],id: s["id"].toString()));
              }
              return Container(width: 0, height: 0,);
              } else return Center(child: CircularProgressIndicator());
              },
         ),*/
        Container( child: FlatButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return Sing_in();}));},
          child: Text("Sing in",style: TextStyle(color: Colors.white,fontSize: 20,),),
        ) ,
          width: 100,
          decoration: combonent.decoratbtn(Colors.orange, Colors.orange),
          margin: EdgeInsets.only(top: 40,right: 30,left: 30),
          height: 40,
        ),
        Container( child: FlatButton(
          onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Sing_up(citys);}));},
          child: Text("Sing up",style: TextStyle(color: Colors.orange,fontSize: 20,),),
        ) ,
          decoration: combonent.decoratbtn(Colors.orange, Colors.white,),
          margin: EdgeInsets.only(top: 40,right: 30,left: 30),
          height: 40,
        ),

      ],
    );
  }
}