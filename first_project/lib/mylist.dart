import 'package:ferstproject/item.dart';

List <arrag>arrags = <arrag>[];
List <tray> trays = <tray>[];
List        <String>nots = <String>[];
User user;
String val1 = 'en';
class User{
  int city_id;
  int user_id;
  String name;
  String lastname;
  String password;
  String Email;
  String Birthday;
  String phon;
  //String id;
  String token;


}
List<Tray> mt = <Tray>[Tray(price: "1000" ,name: "Marble",id: 2,url: "images/v1.png"),Tray(price: "1200" ,name: "Marble",id: 1,url: "images/v2.png")];
double price;
class arrag {
  int arg_size;
  int arg_id;
  int arg_count;
  String url;
  String title;
  String price;
  arrag({this.arg_id, this.arg_count,this.url,this.title,this.price,this.arg_size});
}

class tray {
  int try_id;
  int try_count;
  String url;
  String title;
  String price;
  tray({this.try_id, this.try_count,this.url,this.price,this.title});
}
class Card{
  Card({this.Text,this.price,this.id});
double price = 0.0;
String Text;
int id;
}
String arragmenttojson(List<arrag> prs, List<String> note) {
  String x = '[';
  for (var item = 0; item < prs.length; item++) {
    x += '{';
    x += "\"id\":\"${prs[item].arg_size}\",";
    x += "\"quantity\":\"${prs[item].arg_count}\",";
    x += "\"note\":\"${note[item]}\"";

    x += '},';
  }
  x = removLast(x);
  x += ']';
  return x;
}
String traystojson(List<tray> prs, List<String> note) {
  String x = '[';
  for (var item = 0; item < prs.length; item++) {
    x += '{';
    x += "\"id\":\"${prs[item].try_id}\",";
    x += "\"quantity\":\"${prs[item].try_count}\",";
    x += "\"note\":\"${note[item]}\"";

    x += '},';
  }
  x = removLast(x);
  x += ']';
  return x;
}
String removLast(String x) {
  String s = '';
  for (var i = 0; i < x.length - 1; i++) {
    s += x[i];
  }
  return s;
}
