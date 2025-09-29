import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/provider/app_language_provider.dart';
import 'package:event_planningapp/ui/tabs/home/widget/event_item.dart';
import 'package:event_planningapp/ui/tabs/home/widget/event_tab_item.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_theme_provider.dart';


class HomeTap extends StatefulWidget {
   HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  List<IconData> listOfIcons=[
    Icons.explore,
    Icons.directions_bike_sharp,
    Icons.cake ,
    Icons.people,
    Icons.sports_esports ,
    Icons.handyman,
    Icons.auto_stories,
    Icons.museum,
     Icons.flight,
    Icons.fastfood,
  ];

  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    List<String> eventNameList=[
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.work_shop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var ThemeProvider=Provider.of<AppThemeProvider>(context);    return Scaffold(
      appBar:AppBar(
        //  automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title:Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Text(AppLocalizations.of(context)!.welcomeBack,style: AppStyles.regular14White,),
                   Text(AppLocalizations.of(context)!.johnSafwat,style: AppStyles.bold24white,),
              ],
            ),
            Spacer(),
            Image.asset(AppAssets.sunn ,color:ThemeProvider.appTheme==ThemeMode.light ?
            AppColors.whiteColor
                :
            AppColors.offWhiteColor ,),
            Container(
            //  height: height*0.02,
              padding: EdgeInsets.symmetric(vertical: height*0.008,horizontal: width*0.02),
              margin: EdgeInsetsDirectional.only(start: 16),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ThemeProvider.appTheme==ThemeMode.light ?
                    AppColors.whiteColor
                    :
                    AppColors.offWhiteColor
              ),
              child: Text(languageProvider.appLanguage=="en" ?
                  "En"
                  :
                "Ar"
                ,

                style: Theme.of(context).textTheme.displaySmall),
            )
          ],
        ),
        ),
      body:
      Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
            height: height*0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24),),
              color: Theme.of(context).primaryColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppAssets.mapIcon),
                    SizedBox(width:width * 0.01,),
                    Text("${AppLocalizations.of(context)!.cairo} ,",style: AppStyles.regular14White,),
                    Text(AppLocalizations.of(context)!.egypt,style: AppStyles.regular14White,),
                  ],
                ),
                DefaultTabController(length: eventNameList.length,
                    child:TabBar(
                      indicatorColor: AppColors.transparentColor,
                      dividerColor: AppColors.transparentColor,
                      labelPadding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                        onTap: (index) {
                          selectedIndex=index;
                          setState(() {
                          });
                        },
                        tabs:
                      eventNameList.map((eventName)=>EventTabItem(eventName: eventName,
                          isSelected: selectedIndex==eventNameList.indexOf(eventName))).toList()
                    )
                ),
              ],
            ),
          ),
          Expanded(child:InkWell(
            onTap:() {
              Navigator.of(context).pushNamed(AppRoutes.eventDetailsScreenRoueNamed,);
            },
            child: ListView.separated(itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.005),
                child: EventItem(),
              );
            }, separatorBuilder: (context, index) => SizedBox(height: height*0.01), itemCount: 10),
          )
          )

        ],
      ),
    );
  }
}
