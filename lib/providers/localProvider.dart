import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier{
  String currentLocale = "en";

  void changeCurrentLocale(String newLocale)async{
    final prefs = await SharedPreferences.getInstance();
    if(newLocale == currentLocale) return;
    currentLocale =newLocale;
    prefs.setString('lang', currentLocale);
    notifyListeners();
  }
}