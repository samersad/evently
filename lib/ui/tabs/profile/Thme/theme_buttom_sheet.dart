import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/provider/app_theme_provider.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/app_language_provider.dart';

class ThemButtonSheet extends StatefulWidget {
  const ThemButtonSheet({super.key});

  @override
  State<ThemButtonSheet> createState() => _ThemButtonSheetState();
}

class _ThemButtonSheetState extends State<ThemButtonSheet> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
      child: Column(
        spacing: height*0.01,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap:
            () {
              //todo change theme to light
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: themeProvider.appTheme==ThemeMode.light?
            getSelectedItem(theme: AppLocalizations.of(context)!.light)
                :
            getUnSelectedItem(theme: AppLocalizations.of(context)!.light)
          ),
          InkWell(
            onTap: () {
              //todo change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
              child:  themeProvider.appTheme==ThemeMode.dark?
                  getSelectedItem(theme: AppLocalizations.of(context)!.dark)
                  :
                  getUnSelectedItem(theme: AppLocalizations.of(context)!.dark)
          )
        ],
      ),
    );
  }
  Widget getSelectedItem({required String theme}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme,style: AppStyles.bold20primary,),
        Icon(Icons.check,color: AppColors.primaryLight,)
      ],
    );
  }
  
  Widget getUnSelectedItem({required String theme}){
    return Text(theme,style: AppStyles.bold20black,);
        
    
    
  }
}
