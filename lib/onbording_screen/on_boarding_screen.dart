import 'package:event_planningapp/provider/app_language_provider.dart';
import 'package:event_planningapp/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../provider/app_theme_provider.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    var ThemeProvider=Provider.of<AppThemeProvider>(context);
    var languageProvider=Provider.of<AppLanguageProvider>(context);


    return IntroductionScreen(
        pages: [
        builtPageView(
            text: AppLocalizations.of(context)!.onBoarding1Text1,
            image: AppAssets.intro2,
            text2:
            AppLocalizations.of(context)!.onBoarding1Text2),
        builtPageView(
            text: AppLocalizations.of(context)!.onBoarding2Text1,
            image: AppAssets.intro3,
            text2:
            AppLocalizations.of(context)!.onBoarding2Text2),
        builtPageView(
            text: AppLocalizations.of(context)!.onBoarding3Text1,
            image: AppAssets.intro4,
            text2:
            AppLocalizations.of(context)!.onBoarding3Text2),
      ],
      onDone: () {
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.loginScreenRouteNamed);
      },
      showBackButton: true,


      next: builtButtonOfScreen(
          image:AppAssets.arrowNext,

      ),
      back:  builtButtonOfScreen(image :AppAssets.arrowBack),

      done: builtButtonOfScreen (image:AppAssets.arrowNext),
      rtl: languageProvider.appLanguage=="ar" ?true:false,

      dotsDecorator:DotsDecorator(
        size: const Size(7, 7),
        color: ThemeProvider.appTheme==ThemeMode.light ?Colors.black : Colors.white,
          activeSize: const Size(20, 10),
        activeColor: AppColors.primaryLight,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

    );
  }

  PageViewModel builtPageView(
      {required String text, required String image, String text2 = ""}) {
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Image.asset(AppAssets.titleWidget),
      ),
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(image)),
          const SizedBox(height: 44),
          
          Text(text, style:AppStyles.bold20primary
          ),
          const SizedBox(height: 40),
          Text(text2,
              style:TextTheme.of(context)!.headlineLarge),
        ],
      ),
    );
  }
Widget builtButtonOfScreen({required String image}){
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.primaryLight,width: 2)
      ),
      child: Image.asset(image),);
}
}
