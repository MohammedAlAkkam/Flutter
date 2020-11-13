import 'dart:ui';
import 'package:ferstproject/Ceck_out2.dart';
import 'package:ferstproject/Check_out_gift.dart';
import 'package:ferstproject/combonent.dart';
import 'package:ferstproject/home.dart';
import 'package:ferstproject/mylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';
class My_Cat extends StatefulWidget {
  @override
  _My_CatState createState() => _My_CatState();
}
int counter = 0;
int counter1 = 0;
class _My_CatState extends State<My_Cat> {
  double allprice = 0;
 void getprice(){
   double sum =0;
    for(int i = 0;i<arrags.length;i++){
        sum +=int.parse(arrags[i].price) *arrags[i].arg_count;
       sum +=int.parse(trays[i].price) *trays[i].try_count;
    }
    allprice = sum;
    price = sum;
  }
  @override
  Widget build(BuildContext context) {getprice();

    var width  = MediaQuery.of(context).size.width;
    return MaterialApp( debugShowCheckedModeBanner: false,
      home: Scaffold( body:
  NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
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
        body: Container(child:ListView(
          children: [
          //  SliverAppBar(leading:Text("jjjjjj"),),
            /*Stack(
              children: [
                Transform.translate(offset: Offset(50,-100),child: Positioned(
                  child:Image.asset("images/Component 1 – 3.png")
                ),),
                Transform.translate(offset: Offset(140,-102),child: Positioned(
                    child:Text("My Cat" ,style: TextStyle(color: Colors.white,fontSize: 25),)
                ),)
              ],
            ),*/
          Container(child:Row(children: [
            Container(child:Text("Arrangement",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600))),
            Expanded(child:Container(child:Icon(Icons.delete,color: Colors.red,),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20),))
          ],),color: Colors.grey.withOpacity(0.17),padding: EdgeInsets.only(top: 5,bottom: 5,left: 15),),
          Container(width: MediaQuery.of(context).size.width,height: 140.0 * (arrags.length+1),child: ListView.builder(physics: new NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
             return  my_card(url: arrags[index].url,price: arrags[index].price.toString(),Title:arrags[index].title,bp: (){setState((){arrags[index].arg_count++;getprice();});},bm: (){if(arrags[index].arg_count > 0)setState((){arrags[index].arg_count--;getprice();});},count: arrags[index].arg_count);
           },itemCount: arrags.length,)),
            Container(child:Row(children: [
              Container(child:Text("Tray",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600))),
              Expanded(child:Container(child:Icon(Icons.delete,color: Colors.red,),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20),))
            ],),color: Colors.grey.withOpacity(0.17),padding: EdgeInsets.only(top: 5,bottom: 5,left: 15),),
            ///////////////////////////////////////////////////////////////////////////////////////
            Container(width: MediaQuery.of(context).size.width,height: 140.0 * (arrags.length+1),child: ListView.builder(physics: new NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
              return  my_card1(url: trays[index].url,price: trays[index].price.toString(),Title:trays[index].title,bp: (){setState((){trays[index].try_count++;getprice();});},bm: (){if(trays[index].try_count > 0)setState((){trays[index].try_count--;getprice();});},count: trays[index].try_count);
            },itemCount: arrags.length,)),
            //////////////////////////////////////////////////////////////////////////////////////
              Stack(children: [
                Positioned(child: Transform.translate(offset: Offset(0,-10),child: Container(decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.only(),
                  child: Column(children: [
                    Row(children: [Container( margin:EdgeInsets.only(top: 20,left: 20) ,child:Text('Total Price',style: TextStyle(fontSize: 23),)),Expanded(child:Container(child:Text("${allprice}",style: TextStyle(fontSize: 23),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20,top: 20),))],)
                  , Container(width: 300, child: FlatButton(
              child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 20,),),
              onPressed:allprice != 0.0? (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {return check_out2();},));
                }:(){Toast.show("you have to select one arrangement at leas", context);},
            ),decoration: BoxDecoration(color: Colors.orange,borderRadius:BorderRadius.all(Radius.circular(50))),margin: EdgeInsets.only(bottom: 40,top: 40),)],)),),)
              ,
          ],
        ),
      ]),
    ))));
  }
  Widget my_card({String url,String Title,String price,GestureTapCallback bp,GestureTapCallback bm ,int count}){
    return Container(height: 150,color: Colors.white,child: Container(
        margin: EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
        child: Row(children: [
         Expanded(flex: 1,child: Transform.translate(offset: Offset(5,-4),child: Image.network(url,fit: BoxFit.cover,),),),
          Expanded(flex: 2,child: Column(children: [
            Text(Title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
            Container(child:Row(children: [
              Container(child:Text('Price:'),margin: EdgeInsets.only(left: 10,right: 30),),
              Container(child:Text("${price} ADE",style: TextStyle(color: Colors.orange),),margin: EdgeInsets.only(left: 10),),
            ]),margin: EdgeInsets.all(5),)
            ,Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              InkWell(child:Container(width: 20,height: 20,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(4)),border: Border.all(color: Colors.orange)),child:  Container(margin: EdgeInsets.only(bottom: 0),child:Image.asset("images/min.png"),),),onTap: bm,)
              ,Container(child: Text(count.toString(),textAlign: TextAlign.center,),width: 100,decoration: BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.orange,width: 2))),padding: EdgeInsets.all(10),)
              ,InkWell(child:Container(width: 20,height: 20,decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.all(Radius.circular(4))),child: Center(child: Text("+",style: TextStyle(color: Colors.white),),),),onTap : bp),
            ]),margin: EdgeInsets.all(5),)
          ],),),
        ],
        ),
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
            borderRadius: BorderRadius.all(Radius.circular(5)))),);
  }
  Widget my_card1({String url,String Title,String price,GestureTapCallback bp,GestureTapCallback bm ,int count}){
    return Container(height: 150,color: Colors.white,child: Container(
        margin: EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
        child: Row(children: [
          Expanded(flex: 1,child: Transform.translate(offset: Offset(5,-4),child: Image.asset( url,fit: BoxFit.cover,),),),
          Expanded(flex: 2,child: Column(children: [
            Text(Title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
            Container(child:Row(children: [
              Container(child:Text('Price:'),margin: EdgeInsets.only(left: 10,right: 30),),
              Container(child:Text("${price} ADE",style: TextStyle(color: Colors.orange),),margin: EdgeInsets.only(left: 10),),
            ]),margin: EdgeInsets.all(5),)
            ,Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              InkWell(child:Container(width: 20,height: 20,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(4)),border: Border.all(color: Colors.orange)),child:  Container(margin: EdgeInsets.only(bottom: 0),child:Image.asset("images/min.png"),),),onTap: bm,)
              ,Container(child: Text(count.toString(),textAlign: TextAlign.center,),width: 100,decoration: BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(color: Colors.orange,width: 2))),padding: EdgeInsets.all(10),)
              ,InkWell(child:Container(width: 20,height: 20,decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.all(Radius.circular(4))),child: Center(child: Text("+",style: TextStyle(color: Colors.white),),),),onTap : bp),
            ]),margin: EdgeInsets.all(5),)
          ],),),
        ],
        ),
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
            borderRadius: BorderRadius.all(Radius.circular(5)))),);
  }
Widget btn(Icon ic ,Color c1,Color c2){
 return Container(child: FlatButton(
    child: ic
      ), decoration: BoxDecoration(
     borderRadius: BorderRadius.all(Radius.circular(2)),
     color:Colors.white ,
     border: Border.all(color: Colors.orange, style: BorderStyle.solid, width: 1.3)
 )
  );
}
}
