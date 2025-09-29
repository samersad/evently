import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
  //date //function change data

  ThemeMode appTheme=ThemeMode.light;


  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return ;
    }
    appTheme = newTheme;
    notifyListeners();

  }

}