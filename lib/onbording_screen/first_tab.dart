import 'package:country_flags/country_flags.dart';
import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/provider/app_theme_provider.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../home_screen/widget/custom_elevated_buttom.dart';
import '../home_screen/widget/toggle_switch_language.dart';
import '../provider/app_language_provider.dart';
import '../utils/app_assets.dart';
import '../utils/app_styles.dart';

class FirstTab extends StatelessWidget {

   FirstTab({super.key});
  static const firstTabRouteNamed="first_tab_screen";

  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var ThemeProvider=Provider.of<AppThemeProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 10,),
            Center(child: Image.asset(AppAssets.titleWidget)),
            Center(child: Image.asset(AppAssets.intro1)),
            Text(
              AppLocalizations.of(context)!.firstTapText1,textAlign: TextAlign.start,
              style: AppStyles.bold20primary,
            ),
            Text(
              AppLocalizations.of(context)!.firstTapText2,
              style: TextTheme.of(context)!.headlineLarge,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                
                Text(AppLocalizations.of(context)!.language,style: AppStyles.medium20primary,),
                ToggleSwitchLanguage(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(AppLocalizations.of(context)!.theme,style: AppStyles.medium20primary,),
                ToggleSwitch(
                  animate: true,
                  radiusStyle: true,

                  minWidth: 50.0,
                  minHeight: 30.0,
                  cornerRadius: 100,
                  inactiveBgColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  activeBgColors: [
                    [AppColors.primaryLight],
                    [Colors.transparent],
                  ],
                  borderColor: [AppColors.primaryLight],
                  activeBorders: [
                    Border.all(color: AppColors.primaryLight, width: 2),

                  ],
                  curve: Curves.easeInOutQuint,

                  initialLabelIndex: ThemeProvider.appTheme == ThemeMode.light ? 0 : 1,

                  totalSwitches: 2,
                  customWidgets: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/Sun.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        "assets/images/Moon.png",
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],

                  onToggle: (index) {
                    if (index == 0) {
                      ThemeProvider.changeTheme(ThemeMode.light);
                    } else if (index == 1) {
                      ThemeProvider.changeTheme(ThemeMode.dark);
                    }
                  },
                )

              ]
            ),
            CustomElevatedButtom(text: AppLocalizations.of(context)!.letsStart, onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.onBoardingScreenRoueNamed);
            },
              mainAxisAlignment: MainAxisAlignment.center,
            )          ],
        ),
      ),
    );

  }

}

