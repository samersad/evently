import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/app_language_provider.dart';

class LanguageButtomSheet extends StatefulWidget {
  const LanguageButtomSheet({super.key});

  @override
  State<LanguageButtomSheet> createState() => _LanguageButtomSheetState();
}

class _LanguageButtomSheetState extends State<LanguageButtomSheet> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
      child: Column(
        spacing: height*0.01,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              //todo to english
            languageProvider.changeLanguage("en");
            },
            child: languageProvider.appLanguage=="en"?
                getSelectedItem(language: AppLocalizations.of(context)!.english):
                getUnSelectedItem(language: AppLocalizations.of(context)!.english)
          ),
          InkWell(
              onTap:() {
                //todo to arabic
                languageProvider.changeLanguage("ar");

              }
              ,child: languageProvider.appLanguage=="ar" ?
          getSelectedItem(language: AppLocalizations.of(context)!.arabic):
          getUnSelectedItem(language: AppLocalizations.of(context)!.arabic)

          ),
        ],
      ),
    );
  }
  Widget getSelectedItem({required String language}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language,style: AppStyles.bold20primary,),
        Icon(Icons.check,color: AppColors.primaryLight,size: 20,)
      ],
    );
  }
  
  Widget getUnSelectedItem({required String language}){
    return Text(language,style: AppStyles.bold20black,);
        
    
    
  }
}
