import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planningapp/auth/register_screen/register_screen.dart';
import 'package:event_planningapp/provider/app_language_provider.dart';
import 'package:event_planningapp/provider/app_theme_provider.dart';
import 'package:event_planningapp/home_screen/home_screen.dart';
import 'package:event_planningapp/provider/event_list_provider.dart';
import 'package:event_planningapp/ui/tabs/create_event/create_event.dart';
import 'package:event_planningapp/ui/tabs/home/edit_event/edit_event.dart';
import 'package:event_planningapp/ui/tabs/home/event_details/event_details.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/login_screen/login_screen.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'onbording_screen/first_tab.dart';
import 'onbording_screen/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();  //todo offline
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) =>AppLanguageProvider() ,)  ,    
      ChangeNotifierProvider(create: (context) =>AppThemeProvider() ,),
      ChangeNotifierProvider(create: (context) =>EventListProvider() ,)
    ],

      child: const MyApp()));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:  AppRoutes.firstTabRouteNamed,
      routes: {
        AppRoutes.firstTabRouteNamed:(context) {
        return FirstTab();
      },

       AppRoutes.loginScreenRouteNamed:(context) {
         return LoginScreen();
       },
        AppRoutes.homeScreenRouteNamed:(context) {
         return HomeScreen();
       },
        AppRoutes.onBoardingScreenRoueNamed:(context){
        return OnBoardingScreen();
       },
        AppRoutes.registerScreenRouteNamed:(context){
        return RegisterScreen();
       },
        AppRoutes.createEventScreenRoueNamed:(context){
        return CreateEvent();
       },
        AppRoutes.eventDetailsScreenRoueNamed:(context){
        return EventDetails();
       },
        AppRoutes.editEventScreenRoueNamed:(context){
        return EditEvent();
       },
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );

  }

}
