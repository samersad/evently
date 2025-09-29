import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_prefarance_helper.dart';


class AppLanguageProvider extends ChangeNotifier{
  //date //function change data

  AppLanguageProvider() {
    _loadLanguage();
  }
  Future<void> _loadLanguage() async {
    final savedLang = await readAppLanguage();
    if (savedLang != null) {
      appLanguage = savedLang;
      notifyListeners();
    }
  }
  String appLanguage="en";
  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;

    appLanguage = newLanguage;
    notifyListeners();
    await writeAppLanguage(newLanguage);


  }
}