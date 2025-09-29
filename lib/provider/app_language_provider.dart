import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppLanguageProvider extends ChangeNotifier{
  //date //function change data


  String appLanguage="en";
  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;

    appLanguage = newLanguage;
    notifyListeners();


  }
}