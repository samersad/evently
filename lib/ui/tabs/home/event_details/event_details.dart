import 'package:event_planningapp/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../home_screen/widget/custom_elevated_buttom.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/app_theme_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> eventImageListLight=[
      AppAssets.sportBgLight,
      AppAssets.birthdayBgLight,
      AppAssets.meetingBgLight,
      AppAssets.gamingBgLight,
      AppAssets.workShopBgLight,
      AppAssets.bookClubBgLight,
      AppAssets.exhibitionBgLight,
      AppAssets.holidayBgLight,
      AppAssets.eatingBgLight,
    ];
    List<String> eventImageListDark=[
      AppAssets.sportBgDark,
      AppAssets.birthdayBgDark,
      AppAssets.meetingBgDark,
      AppAssets.gamingBgDark,
      AppAssets.workShopBgDark,
      AppAssets.bookClubBgDark,
      AppAssets.exhibitionBgDark,
      AppAssets.holidayBgDark,
      AppAssets.eatingBgDark,
    ];
    var providerTheme=Provider.of<AppThemeProvider>(context);

    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.primaryLight,
        title: Text(AppLocalizations.of(context)!.createEvent,style: AppStyles.bold20primary,),
        centerTitle: true,
        actions: [
          InkWell(
            onTap:() {
              Navigator.of(context).pushNamed(AppRoutes.editEventScreenRoueNamed);
            },
              child: Image.asset(AppAssets.editIcon)),
          SizedBox(width: width*0.02,),
          Image.asset(AppAssets.deleteIcon),
          SizedBox(width: width*0.02,),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: height*0.01,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(providerTheme.appTheme==ThemeMode.light?
                AppAssets.sportBgLight:
                AppAssets.sportBgDark
                ),
              ),
              Text("We Are Going To Play Football",style: AppStyles.medium24Primary,),
              CustomElevatedButtom(onPressed: (){},
                borderColor: AppColors.primaryLight,
                backgroundColorElevated: AppColors.transparentColor,
                hasIcon: true,
                childIconWidget: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
                      margin: EdgeInsetsDirectional.only(start: width*0.04),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight
                      ),
                      child: Image.asset(AppAssets.CalendarIcon,color: Theme.of(context).disabledColor),),
                    SizedBox(width: width*0.02,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("21 November 2024 ",style: AppStyles.medium16primary,),
                        Text("12:12PM",style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  ],
                ),
              ),
              CustomElevatedButtom(onPressed: (){},
                borderColor: AppColors.primaryLight,
                backgroundColorElevated: AppColors.transparentColor,
                hasIcon: true,
                childIconWidget: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
                      margin: EdgeInsetsDirectional.only(start: width*0.04),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight
                      ),
                      child: Image.asset(AppAssets.locationIcon,color: Theme.of(context).disabledColor),),
                    SizedBox(width: width*0.02,),
                    Text("Cairo , Egypt",style: AppStyles.medium16primary,),
                    Spacer(),
                    Padding(
                      padding:  EdgeInsetsDirectional.only(end: width*0.03),
                      child: Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryLight,),
                    )
                  ],
                ),
              ),
              Container(
                height: height*0.35,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight,width: 2)
                ),
                child: Text(""),
              ),
              Text(AppLocalizations.of(context)!.description,style: Theme.of(context).textTheme.labelMedium),
              Text("Lorem ipsum dolor sit amet c"
                  "onsectetur. Vulputate eleifend suscipit eget neque senectu"
                  "s a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auc"
                  "tor et. At cras massa diam port"
                  "a facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada"
                  " nisi quis  feugiat.",style: Theme.of(context).textTheme.labelMedium)

            ],
          ),
        ),
      ),

    );
  }
}
