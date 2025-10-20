import 'package:event_planningapp/provider/app_theme_provider.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../home_screen/widget/custom_elevated_buttom.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/app_language_provider.dart';
import '../../../provider/user_provider.dart';
import 'Thme/theme_buttom_sheet.dart';
import 'language/language_buttom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
       //automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(64))
        ),
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height*0.18,
        title: Row(
          spacing: width*0.04,
          children: [
            Image.asset(AppAssets.routeAppBar),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userProvider.currentUser!.name,style: AppStyles.bold24white,),

                  Text(userProvider.currentUser!.email,style: AppStyles.medium16white,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: height*0.02,
          children: [
            Text(AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.headlineLarge,),
            InkWell(
              onTap: () {
                showLanguageButtonSheet();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(languageProvider.appLanguage=="en"?
                      AppLocalizations.of(context)!.english:
                    AppLocalizations.of(context)!.arabic
                      ,style: AppStyles.bold20primary,),
                    Icon(Icons.arrow_drop_down,color: AppColors.primaryLight,size: 40,)
                  ],
                ),
              ),
            ),
            Text(AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.headlineLarge,),
              InkWell(
                onTap:
                () {
                  showButtonSheetTheme();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primaryLight,width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text( themeProvider.appTheme==ThemeMode.light?
                          AppLocalizations.of(context)!.light:
                          AppLocalizations.of(context)!.dark
                          ,
                        style: AppStyles.bold20primary,
                      ),
                      Icon(Icons.arrow_drop_down,color: AppColors.primaryLight,size: 40,)
                    ],
                  ),
                ),
              ),
            Spacer(),
            CustomElevatedButtom( onPressed: () {

              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginScreenRouteNamed, (route) => false,);
            },
            backgroundColorElevated: AppColors.redColor,hasIcon: true,
              childIconWidget: Row(
                children: [
                   Padding(
                     padding:EdgeInsetsDirectional.only(start: width*0.04),
                     child: Icon(Icons.logout,color: AppColors.whiteColor,size: 30,),
                   ),
                  SizedBox(width: width*0.02,),
                  Text(AppLocalizations.of(context)!.logout,style: AppStyles.regular20White,)
                  
                ],
              ),

            ),
            SizedBox(height: height*0.01,)
            //(height: height*0.01,)
          ],
        ),
      ),
    );
  }

  void showLanguageButtonSheet() {
    showModalBottomSheet(context: context, builder: (context) {
      return LanguageButtomSheet();
    },
    );
  }

  void showButtonSheetTheme() {
    showModalBottomSheet(context: context, builder:
    (context) {
      return ThemButtonSheet();
    },
    );
  }
}
