import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'mylist.dart';
class AppLocalization{
  final Locale local;
  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationsDelegate();
  AppLocalization(this.local);
  static AppLocalization of(BuildContext context){
    return Localizations.of<AppLocalization>(context,AppLocalization);
  }
  static Map<String , String> localizationString;
  Future<bool> load()async{
    String jsonString = await rootBundle.loadString('lag/$val1.json');
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    localizationString = jsonMap.map((key, value){ return MapEntry(key, value.toString());});
    return true;
  }
   String translate(String key){
    return localizationString[key];
  }
}
class _AppLocalizationsDelegate extends  LocalizationsDelegate<AppLocalization>{

  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async{
    AppLocalization localization = new AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return true;
  }

  const _AppLocalizationsDelegate();
}