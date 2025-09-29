import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme{
  static final ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: AppColors.whiteColor,
      focusColor: AppColors.whiteColor,
      canvasColor: AppColors.whiteColor,
      primaryColor: AppColors.primaryLight,
      cardColor: AppColors.primaryLight,
      dividerColor: AppColors.grayColor,
      highlightColor: AppColors.grayColor,
      disabledColor:AppColors.whiteColor ,


      textTheme: TextTheme(
      headlineLarge: AppStyles.bold20black,
      headlineMedium: AppStyles.medium16primary,
      headlineSmall: AppStyles.bold14Black,
      bodyMedium: AppStyles.medium16Gray,
      bodySmall: AppStyles.bold16White,
      labelMedium: AppStyles.medium16black,
          displaySmall: AppStyles.bold14primary


      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryLight,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.bold12White,
        unselectedLabelStyle: AppStyles.bold12White,
        //backgroundColor: Colors.red
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
          shape: StadiumBorder(
              side: BorderSide(color: AppColors.whiteColor,width: 4)
          )
      )

  );
  static final ThemeData darkTheme=ThemeData(
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      focusColor: AppColors.primaryLight,
      canvasColor: AppColors.transparentColor,
      cardColor: AppColors.whiteColor,
      dividerColor: AppColors.primaryLight,
      highlightColor: AppColors.whiteColor,
      disabledColor:AppColors.blackColor ,

      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20Offwhite,
          headlineMedium: AppStyles.medium16white,
          headlineSmall: AppStyles.bold14white,
          bodyMedium: AppStyles.medium16white,
          bodySmall: AppStyles.bold16black,
          labelMedium: AppStyles.medium16white,
          displaySmall: AppStyles.bold14primaryDark


      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
        selectedLabelStyle: AppStyles.bold12White,
        unselectedLabelStyle: AppStyles.bold12White,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor,width: 4)
      )
    )
  );
}