import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../provider/app_language_provider.dart';
import '../../provider/app_theme_provider.dart';
import '../../utils/app_colors.dart';

class ToggleSwitchLanguage extends StatelessWidget {
  const ToggleSwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var ThemeProvider=Provider.of<AppThemeProvider>(context);
    return  ToggleSwitch(
      animate: true,
      radiusStyle: true,
      minWidth: 50.0,
      minHeight: 30.0,
      cornerRadius: 100,
      inactiveBgColor: AppColors.transparentColor,
      dividerColor: AppColors.transparentColor,
      activeBgColors: [
        [AppColors.primaryLight],
        [AppColors.primaryLight],
      ],
      borderColor: [AppColors.primaryLight],
      activeBorders: [
        Border.all(color: AppColors.primaryLight, width: 1),
      ],
      initialLabelIndex: languageProvider.appLanguage == "en" ? 0 : 1,
      totalSwitches: 2,
      customWidgets: [
        ClipOval(

          child: CountryFlag.fromCountryCode(
              'US',
              theme: ImageTheme(
                height: double.infinity,
                width: double.infinity,
              )
          ),
        ),
        ClipOval(
          child: CountryFlag.fromCountryCode(
              'EG',
              theme: ImageTheme(
                  height: double.infinity,
                  width: double.infinity
              )
          ),
        ),
      ],

      onToggle: (index) {
        if (index == 0) {
          languageProvider.changeLanguage("en");
        } else if (index == 1) {
          languageProvider.changeLanguage("ar");
        }
      },                );
    ;
  }
}
