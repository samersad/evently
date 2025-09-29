import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:event_planningapp/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_language_provider.dart';
import '../provider/app_theme_provider.dart';
import '../ui/tabs/favorite/favorite_tap.dart';
import '../ui/tabs/home/home_tap.dart';
import '../ui/tabs/map/map_tap.dart';
import '../ui/tabs/profile/profile_tab.dart';
import '../utils/app_assets.dart';
class HomeScreen extends StatefulWidget {
  static const homeScreenRouteNamed="home_screen";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  List<Widget> tabs=[
    HomeTap(),
    MapTap(),
    FavoriteTap(),
    ProfileTab(),
  ];

  List<String> unSelectedIcon=[
    AppAssets.homeIcon,
    AppAssets.mapIcon,
    AppAssets.loveIcon,
    AppAssets.profileIcon,
  ];
  List<String> selectedIcon=[
    AppAssets.selectedHomeIcon,
    AppAssets.selectedMapIcon,
    AppAssets.selectedLoveIcon,
    AppAssets.selectedProfileIcon,
  ];
  @override
  Widget build(BuildContext context) {
    List<String> label=[
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.map,
      AppLocalizations.of(context)!.love,
      AppLocalizations.of(context)!.profile,

    ];
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return Scaffold(
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          backgroundColor: Theme.of(context).primaryColor,
            itemCount: selectedIcon.length,
            tabBuilder: (int index, bool isActive) {
              return
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    selectedIndex==index?
                  Image.asset(selectedIcon[index],width: 24,
                 height: 24,) :
                    Image.asset(unSelectedIcon[index],width: 24,
                      height: 24,)
                    ,
                    InkWell(

                        child: Text(label[index],style: AppStyles.bold12White,))
                  ],
                );
            },
              activeIndex: selectedIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.sharpEdge,

              onTap: (index) => setState(() => selectedIndex=index = index),
              //other params
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(AppRoutes.createEventScreenRoueNamed);
        },
        child: Icon(Icons.add,color: AppColors.whiteColor,size: 30,),),
        floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
        body: Container(
     child:tabs[selectedIndex],

      )
      );
  }

  Widget builtBottomNavItem({required int index,required String iconName}){
    return selectedIndex==index ?
    Container(
        padding:  EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        child: ImageIcon(AssetImage( iconName))):
    ImageIcon(AssetImage( iconName)
    );

  }
}
/*      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
           currentIndex: selectedIndex,
           onTap:(index) {
             selectedIndex =index;
             setState(() {

             });
           }
         ,
         items: [
         BottomNavigationBarItem(
             icon: builtBottomNavItem(index: 0, iconName: AppAssets.homeIcon),
             label: "Home",
         ),
         BottomNavigationBarItem(
             icon: builtBottomNavItem(index: 1, iconName: AppAssets.mapIcon),
             label: "Map",

         ),
         BottomNavigationBarItem(
             icon: builtBottomNavItem(index: 2, iconName: AppAssets.loveIcon),
             label: "Love"
         ),
         BottomNavigationBarItem(
             icon: builtBottomNavItem(index: 3, iconName: AppAssets.profileIcon),
             label: "Profile"
         ),
       ],

      ),
 */
