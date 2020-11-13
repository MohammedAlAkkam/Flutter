import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:ferstproject/mylist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class order{
  String name;
  int price;
  int quin;

  order({this.name, this.price, this.quin});

}
double x1 =0;
String addres,Time,Date;
class My_order extends StatelessWidget {
  int id;
  view ()async{
    print("====================----------------------------=");
    print(user.user_id);
    print(user.token);
    print(id);
    var url = "http://mzn.tradinos.com/api/get_order_detail?user_id=${user.user_id}&order_id=$id";
    var res = await get(url,headers: {HttpHeaders.authorizationHeader:"Bearer ${user.token}"});
    var rsb  = jsonDecode(res.body);
    print(res);
    return rsb;
  }
  @override
  Widget build(BuildContext context) {
    x1=0;
    or = <order>[];
    // TODO: implement build
   return MaterialApp(debugShowCheckedModeBanner: false,home:Scaffold(body: FutureBuilder(future:view() ,builder: (context, snapshot) {
     if(snapshot.hasData){
       print(snapshot.data);
       Date =snapshot.data['data']['created_date'].toString().split(":")[0];
       Time = snapshot.data['data']['start'] + " to " + snapshot.data['data']['end'];

       for(int i = 0;i<snapshot.data['data']['arrangments'].length;i++){
         var x = snapshot.data['data']['arrangments'][i];
         print(x['pivot']['quantity']);
         or.add(order(name: x["name"],price: x['pivot']["arrangment_price"],quin: x['pivot']['quantity']));
         x1+=x['pivot']["arrangment_price"]*x['pivot']['quantity'];
       }
       return my_order(id,number);
     }else return Center(child:CircularProgressIndicator());
   },)));
  }
  int number;
  My_order(this.id,this.number);
}
List <order> or = <order>[];
class my_order extends StatefulWidget {
  int id;
  int number;
  my_order(this.id,this.number);
  @override
  _My_orderState createState() => _My_orderState(id,number);
}

class _My_orderState extends State<my_order> {
  int id;
  int number;
  _My_orderState(this.id,this.number);
  TextStyle t = TextStyle(color: Colors.black87,fontSize: 20);

  @override
  Widget build(BuildContext context) {
    double pr = 0.0;
    int i = 0;
    return MaterialApp(debugShowCheckedModeBanner: false,home: Scaffold(appBar:AppBar(backgroundColor: Colors.orange,title: Text("Order Details",style: TextStyle(color: Colors.white,fontSize: 20),),),body: ListView(children: [
           dd('Order Number :$number',"Confirmed",TitleColor: Colors.black,dataColor:  Colors.orange,fontsize: 20),
      Container(height: 5,color: Colors.orange,margin: EdgeInsets.only(top: 10),),
      dd("Date" ,Date),
      dd("Time" ,Time),
    //  dd("Address" ,"addres"),
      Container(
        padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
        child: Text("Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),), color: Colors.grey.withOpacity(0.3),),
      Container(  margin: EdgeInsets.only(top: 15),
          child:Row(children: [
       Expanded(child:Container(alignment:Alignment.center,child: Text('items',style: t,),),flex: 4,),
       Expanded(child:Container(alignment:Alignment.center,child: Text('Qua',style: t)),flex: 2,),
       Expanded(child:Container(alignment:Alignment.center,child: Text('price',style: t,)),flex: 3,),
      ],)),
      Container(width: MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height/2.4,child:
      ListView.builder(physics:NeverScrollableScrollPhysics(),itemCount: or.length,itemBuilder:(context, index) {
        var x = or[index];
        pr +=x.price * x.quin *1.0;
       return mytable(x.name,x.quin,x.price);
     })),
      Container(decoration: BoxDecoration(color: Color.lerp(Colors.blue, Colors.black, 0.85),borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20)),)
          ,child:Column(children: [
            ddd('Subtotal',x1.toString() + " "),
            ddd('Delivery fee',0.toString() + ' '),
            ddd('price',x1.toString() ,fontsize: 30,c: Colors.orange),
            SizedBox(width: MediaQuery.of(context).size.width,height: 20,)
          ],)
      )

    ],),),);
  }
}
Container ddd(String title, String Price,{double fontsize = 17,Color c = Colors.white}){
  return   Container(margin: EdgeInsets.only(left: 30,right: 30,top: 30),
      child:Row(children: [
        Container(child:Text(title,style: TextStyle(fontSize: fontsize,color: c,fontWeight: FontWeight.w800),)),Expanded(child:Container(child:Text(Price + 'AED',style: TextStyle(color:c,fontSize: fontsize),),alignment: Alignment.centerRight,))
      ],));
}
  mytable(String item,int Que,int price,){
    TextStyle t = TextStyle(color: Colors.black87,fontSize: 20);
    return Container(  margin: EdgeInsets.only(top: 15),
      child:Row(children: [
        Expanded(child:Container(alignment:Alignment.center,child: Text(item,style: t,),),flex: 4,),
        Expanded(child:Container(alignment:Alignment.center,child: Text(Que.toString(),style: t)),flex: 2,),
        Expanded(child:Container(alignment:Alignment.center,child: Text(price.toString()+ ' ADE',style: t,)),flex: 3,),
      ],));
  }
Container dd(String title, String data,{double fontsize = 17,Color TitleColor = Colors.grey,dataColor, int i}){
  data = format(data);
  return   Container(margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      child:Row(children: [
        Text(title,style: TextStyle(fontSize: fontsize,color: TitleColor,fontWeight: FontWeight.w800),),Expanded(child:Container(child:Text(data ,style: TextStyle(color:dataColor,fontSize: fontsize),),alignment: Alignment.centerRight,))

      ],));
}
String format(String x) {
  var s = "";
  for (int i = 1; i <= x.length; i++) {
    s += x[i - 1];

    if (i % 14 == 0) {
      s += '\n';
    }
  }

  return s;
}
/*return MaterialApp( home: DefaultTabController(
length: 2,
child: Scaffold(
appBar: AppBar(backgroundColor: Colors.white,bottom: TabBar(labelColor: Colors.black,indicatorColor: Colors.orange,tabs: [
Tab(child: Text('Arragement',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),),
Tab(child: Text('Gift',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18))),
]),),
body: TabBarView(children: [
Center(child: Icon(Icons.description),),
Center(child: Icon(Icons.title),),
] ,),),
),);*/