import 'dart:convert'as Convert;
import 'dart:io';
import 'package:ferstproject/Check_out_gift.dart';
import 'package:ferstproject/Sing_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import './mylist.dart';
import './mylist.dart' as c;
import 'home.dart'as home;
class check_out2 extends StatelessWidget {
  getdata()async
  {
    var url = "http://mzn.tradinos.com/api/get_form_data";
    var res =await get(url);
    var resb = Convert.jsonDecode(res.body);
    return resb;
  }
  @override
  Widget build(BuildContext context) {
    return citys.length == 0? FutureBuilder(future: getdata(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          for(int i = 0; i<snapshot.data["data"]['city'].length;i++){
            var x = snapshot.data['data']['city'][i];
            citys.add(city(id: x['id'].toString(),name: x['name'],pricedel: x['delivery_fee']*1.0));
            items.add(DropdownMenuItem(child: Text(x["name"]),value: x['id'],));
          }
          for(int i = 0; i<snapshot.data["data"]['cards'].length;i++){
            var x = snapshot.data['data']['cards'][i];
            cards.add(c.Card(price: x['fee'] * 1.0,Text: x['name'],id: x['id']));
            itemscard.add(DropdownMenuItem(value:  x['id'],child: Text(x['name'])));
          }
          //for(int i = 0;i<snapshot.data['data'])
          return Check_out2();
        }else return Center(child:CircularProgressIndicator());
      },
    ):Check_out2();
  }
}
List <city> citys = [];
List <c.Card>cards= <c.Card>[];
int city_select;
List<DropdownMenuItem> items = [];
List<DropdownMenuItem> itemscard = [];
class Check_out2 extends StatefulWidget {
  @override
  _check_out2State createState() => _check_out2State();
}

class _check_out2State extends State<Check_out2> {
  setorder()async{
    var url = 'http://mzn.tradinos.com/api/set_order';
  Map<String,String> map = {
    'arrangments':  arragmenttojson(arrags,nots),
    'trays':"[]",
    "delivery_date":"$barthday",
    'time_id':Time_id.toString(),
    'user_id': "${user.user_id.toString()}",
    "payment_method":'1',
    "city":"${user.city_id}",
    "area":Aria.text,
    "house_number":housenumber.text,
    'street':Street.text,
    "add_card":"0",
    'send_to_friend': "0",
    "long":'36.88',
    "lat":"33.9",

   };
    var res =await post(url,body: map,headers: {HttpHeaders.authorizationHeader:"Bearer "+user.token});
    var resb = Convert.jsonDecode(res.body);
    print(res.body);
    if(resb['status']){
      arrags = <arrag>[];
      trays=<tray>[];
      nots = [];
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Toast.show(resb["message"], context);
    }
  }
  List<DropdownMenuItem> Time = [];
  getTime()async{
    var url = 'http://mzn.tradinos.com/api/get_time_blocks?area_id=${user.city_id}';
    var rs =await get(url);
    var resb = Convert.jsonDecode(rs.body);
    return resb;
  }
  TextEditingController Aria = new TextEditingController();
  TextEditingController Street = new TextEditingController();
  TextEditingController Nots = new TextEditingController();
  TextEditingController housenumber = new TextEditingController();
  String barthday = "delivery date";
  getdata()async
  {
    var url = "http://mzn.tradinos.com/api/get_form_data";
    var res =await get(url);
    var resb = Convert.jsonDecode(res.body);
    return resb;
  }
  int val = 1;
  bool send_frind = false;
  bool Add_card = false;
  double delenry = 0.0;
  double card_price= 0.0;
  var  Time_id;
  /*    */
  @override
  Widget build(BuildContext context) {
    var width  = MediaQuery.of(context).size.width-70;

    return MaterialApp(debugShowCheckedModeBanner: false,home: Scaffold(resizeToAvoidBottomPadding: false,

    body:  NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
      return [SliverAppBar(
        leading: InkWell(child:Image.asset("images/Component 1 – 3.png"),onTap: (){Navigator.of(context).pop();},),
         backgroundColor: Colors.orange,
        expandedHeight: 120.0,
          title: Text('My Card'),
        centerTitle: true,
        floating: true,
        pinned: true,

        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,

          background: Image.asset("images/Path 6.png",fit: BoxFit.fitWidth,),
        ),

      )];
    },
        body: ListView( children: [

          Row(children: [
            Checkbox(activeColor: Colors.orange,value: send_frind,onChanged: (value) {setState(() {send_frind =value;});},),
            Text('send frand',style: TextStyle(fontSize: 20),),
          ],),
          Container(margin: EdgeInsets.only(top: 3),padding: EdgeInsets.only(top: 10,left: 30,bottom: 10),color: Colors.grey.withOpacity(0.2),child:
          Text("Addres",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900),),)
          ,Container(child:Text('Shard your location',style: TextStyle(fontSize: 20),),margin: EdgeInsets.only(top: 15,left: 20),)
          ,Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Container(child: DropdownButtonFormField(items:items , onChanged:(val){setState((){city_select = val;delenry = citys.firstWhere((element) => element.id == city_select.toString()).pricedel;print(delenry);});},hint: Text('city'),)
              ,width: width/2,),
            Container(child: myTxt(hint: 'Area',i: 1,c: Aria),width: width/2,margin: EdgeInsets.only(left: 20),)

          ],)
          ,myTxt(hint: 'Street',c: Street),
          myTxt(hint: 'House number',c: housenumber),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Container(child:Time.length == 0? FutureBuilder(future: getTime(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  for (int i = 0; i < snapshot.data['data']['time_blocks'].length; i++) {
                    var x = snapshot.data['data']['time_blocks'][i];
                    String start = x['start'];
                    String end = x['end'];

                    Time.add(DropdownMenuItem(
                      child: Text(start.toString() + ' ' + end.toString()),
                      value: x['id'],));
                  }
                  return
                    Container(child: DropdownButtonFormField(items:Time , onChanged:(val){setState((){Time_id = val;print(Time_id);});},hint: Text('Time'),)
                      ,width: width/2,margin: EdgeInsets.only(left: 20),);
                } else return CircularProgressIndicator();
              },
            ):Container(child: DropdownButtonFormField(items:Time , onChanged:(val){setState((){Time_id = val;print(Time_id);});},hint: Text('Time'),)
              ,width: width/2,)
              ,width: width/2,),
            Container(width: width / 2,decoration:BoxDecoration(color: Colors.grey.withOpacity(0.16)),padding: EdgeInsets.all(8),margin: EdgeInsets.only(top: 20,right: 30,left: 30),child:InkWell(child:Text(barthday,style: TextStyle(fontSize: 18),),onTap: (){setState(() {
              showDatePicker(
                context: context, initialDate: DateTime(2000), firstDate: DateTime(1950), lastDate: DateTime.now(), ).then((value) {
                setState(() {
                  barthday =value.year.toString()+"/"+value.month.toString()+"/"+value.day.toString();});} );
            });},) ,),

          ],),
          Container(margin:EdgeInsets.only(top: 20),color: Colors.grey.withOpacity(0.3),child: Row(children: [
            Checkbox(value: Add_card,activeColor: Colors.orange, onChanged:(value) {setState(() {Add_card = value;});},),
            InkWell(child:Text('Add a card',style: TextStyle(fontSize: 20),),onTap: (){setState(() {Add_card=!Add_card;});},)
          ],),),
          Container(margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 10),child: DropdownButtonFormField(items:itemscard , onChanged:(val){setState((){card_price = cards.firstWhere((element) => element.id == val).price;print(delenry);});},hint: Text('Card'),)),
          myTxt(hint: 'Card masseg'),
          Container(height: 20,color: Colors.grey[300],margin: EdgeInsets.only(top: 20,bottom: 20))
          ,Container(margin: EdgeInsets.only(left: 20),child:Row(children:[Icon(Icons.add_circle_outline,color: Colors.orange[500],)
            ,Text('Add a voucher', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),)
          ]
          ))
          , Container(margin: EdgeInsets.only(top: 3),padding: EdgeInsets.only(top: 10,left: 30,bottom: 10),color: Colors.grey.withOpacity(0.2),child:
          Text("Payment method",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900),),)
          ,Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children:[Radio(activeColor: Colors.orange,value: 1, groupValue: val,onChanged: (value){setState(() {val = value;});},),Text('Credit card',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w300),)
            ,Radio(activeColor: Colors.orange ,value: 2, groupValue: val,onChanged: (value){setState(() {val = value;});},),Text("Cash on delivery",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w300))]))
          ,myTxt(hint: 'Nots',c: Nots)
          ,Container(decoration: BoxDecoration(color: Color.lerp(Colors.blue, Colors.black, 0.85),borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20)),),child: Column(children: [
            dd('Subtotal', price.toString()),
            dd('card', card_price.toString()),
            dd('pickup',0.0.toString()),
            dd('Delivery', delenry.toString()),
            dd('Total', '${price + card_price+delenry}',c: Colors.orange,fontsize: 25),
            Container(width: 300, child: FlatButton(
              child: Text("Check Out",style: TextStyle(color: Colors.white,fontSize: 20,),),
              onPressed: (){

                setorder();
              },
            ),decoration: BoxDecoration(color: Colors.orange,borderRadius:BorderRadius.all(Radius.circular(50))),margin: EdgeInsets.only(bottom: 40,top: 40),)],),margin: EdgeInsets.only(top: 20),)

        ])
    ),));
  }
 Container dd(String title, String Price,{double fontsize,Color c, int i}){
   if(fontsize == null)fontsize = 17;
   if(c == null) c= Colors.white;
   return   Container(margin: EdgeInsets.only(left: 20,right: 20,top: 10),
       child:Row(children: [
         Text(title,style: TextStyle(fontSize: fontsize,color: Colors.white,fontWeight: FontWeight.w800),),Expanded(child:Container(child:Text(Price + 'AED',style: TextStyle(color:c,fontSize: fontsize),),alignment: Alignment.centerRight,))
       ],));
 }
}
