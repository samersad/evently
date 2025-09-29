import 'package:flutter/material.dart';

import '../utils/shared_prefarance_helper.dart';

class AppThemeProvider extends ChangeNotifier{
  //date //function change data

  AppThemeProvider(){
    _loadTheme();

  }

  Future<void> _loadTheme() async {
    final savedTheme=await readAppTheme();
    if (savedTheme!=null) {
      appTheme=savedTheme;
      notifyListeners();
    }
  }

  ThemeMode appTheme=ThemeMode.light;


  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return ;
    }
    appTheme = newTheme;
    notifyListeners();
    await writeAppTheme(newTheme);


  }

}