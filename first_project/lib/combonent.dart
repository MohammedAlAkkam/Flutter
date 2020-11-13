import 'package:flutter/material.dart';
List<List<String>> s=[['تسجيل دخول','sing in'],['انشاء حساب','sing up'],['اقسام','Category']];
int DI = 0;
   var alin = [Alignment.centerLeft,Alignment.centerRight];
var dec = [TextDirection.rtl,TextDirection.ltr];
class combonent {
  static BoxDecoration decoratbtn(Color cb, Color cg, {double redies = 120}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(redies)),
        color: cg,
        border: Border.all(color: cb, style: BorderStyle.solid, width: 1.3)
    );
  }

}