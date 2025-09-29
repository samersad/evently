import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//todo write data => save String appLanguage and  ThemeMode appTheme

class SharedPreferencesKeys{
  static const String appLastLanguage="app_Last_Language";
  static const String appLastTheme="app_Last_Theme";

}
Future<void> writeAppLanguage(String saveLastLanguage) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(SharedPreferencesKeys.appLastLanguage, saveLastLanguage);

}
Future<String?> readAppLanguage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? newAppLanguage=  prefs.getString(SharedPreferencesKeys.appLastLanguage);
  return newAppLanguage;
}
///////////////////////////////////
Future<void> writeAppTheme(ThemeMode saveLastTheme) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(SharedPreferencesKeys.appLastTheme, saveLastTheme.toString());

}
Future<ThemeMode?> readAppTheme() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? newAppTheme=  prefs.getString(SharedPreferencesKeys.appLastTheme);
  if (newAppTheme == null) return null;

  switch (newAppTheme) {
    case 'ThemeMode.light':
      return ThemeMode.light;
    case 'ThemeMode.dark':
      return ThemeMode.dark;
    case 'ThemeMode.system':
      return ThemeMode.system;
    default:
      return ThemeMode.light;
  }}