import 'dart:convert';
import 'dart:io';
import 'package:ferstproject/Myorder.dart';
import 'package:ferstproject/mylist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class all_order extends StatefulWidget {
  @override
  _all_orderState createState() => _all_orderState();
}

class _all_orderState extends State<all_order> {
  http() async {
    var url = "http://mzn.tradinos.com/api/get_all_orders?user_id=${user.user_id}";
    var res = await get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${user.token}"});
    var reb = jsonDecode(res.body);
    return reb;
  }

  @override
  Widget build(BuildContext context) {
    http();
    try{
      return Scaffold(
          body: NestedScrollView(

              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(

                    leading: InkWell(
                      child: Image.asset("images/Component 1 – 3.png"),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    backgroundColor: Colors.orange,
                    expandedHeight: 120.0,
                    title: Text('My Orders'),
                    centerTitle: true,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.asset(
                        "images/Path 6.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ];
              },
              body: FutureBuilder(
                future: http(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount:snapshot.data['data'].length ,
                      itemBuilder: (context, index) {
                        var x = snapshot.data["data"][index];
                        var ee = (snapshot.data['data'][index]['id']);
                        return InkWell(
                          child: mybox(
                              date: x['created_date'],
                              number_order: index + 1,
                              title_order: "Confirmed",
                              Total: x["total"].toString()),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return My_order(ee,index+1);
                              },
                            ));
                          },
                        );
                      },
                    );
                  } else
                    return Center(child:CircularProgressIndicator());
                },
              )));
    }
    catch (e){
      return  Scaffold(
          body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            leading: InkWell(
              child: Image.asset("images/Component 1 – 3.png"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.orange,
            expandedHeight: 120.0,
            title: Text('My Card'),
            centerTitle: true,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.asset(
                "images/Path 6.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        ];
      },
    body:ListView(children: [
          Text("you dont hame orders")
    ],)));
    }

  }

  mybox({int number_order, String title_order, String Total, String date}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: Column(
        children: [
          Row(children: [
            Container(
                margin: EdgeInsets.only(top: 15, bottom: 5, left: 10),
                child: Text(
                  'Order  Number:$number_order',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 5, right: 10),
              child: Text(
                title_order,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.orange),
              ),
              alignment: Alignment.centerRight,
            ))
          ]),
          Container(height: 3, color: Colors.grey[200]),
          Row(children: [
            Container(
                margin: EdgeInsets.only(top: 15, bottom: 5, left: 10),
                child: Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 5, right: 10),
              child: Text(Total,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              alignment: Alignment.centerRight,
            ))
          ]),
          Row(children: [
            Container(
                margin: EdgeInsets.only(top: 15, bottom: 13, left: 10),
                child: Text(
                  'Date',
                  style: TextStyle(fontSize: 20),
                )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 13, right: 10),
              child: Text(date,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              alignment: Alignment.centerRight,
            ))
          ])
        ],
      ),
    );
  }
}
