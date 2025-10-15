import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../utils/app_styles.dart';
import '../../../home_screen/widget/custom_text_form_field.dart';
import '../../../provider/event_list_provider.dart';
import '../../../provider/user_provider.dart';
import '../home/widget/event_item.dart';

class FavoriteTap extends StatefulWidget {
   FavoriteTap({super.key});
   late UserProvider userProvider;

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  TextEditingController searchCrl=TextEditingController(text: "");

  late EventListProvider eventListProvider;
  late UserProvider userProvider;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllFavoriteEventsFromFirebase(userProvider.currentUser!.id);
    },);
  }
   @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
     eventListProvider=Provider.of<EventListProvider>(context);
    userProvider=Provider.of<UserProvider>(context);

    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.02),
        child: Column(
          children: [
            CustomTextFormField(
              controller: searchCrl,
                borderSideColor: AppColors.primaryLight,
                hintText:AppLocalizations.of(context)!.searchForEvent,hintStyle: AppStyles.bold14primary,
              prefixIconName: Image.asset(AppAssets.searchIcon)),
            SizedBox(height: height*0.02,),
            Expanded(child:eventListProvider.eventsFavoriteList.isEmpty?
                Center(child: Text("no Favorite Founded ",style: Theme.of(context).textTheme.headlineMedium,))
                :
            ListView.separated(itemBuilder: (context, index) {
          return InkWell(onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.eventDetailsScreenRoueNamed,
                arguments: eventListProvider.eventsFavoriteList[index]

            );
          },
              child: EventItem(event: eventListProvider.eventsFavoriteList[index]));
        }, separatorBuilder: (context, index) => SizedBox(height: height*0.01),
                itemCount: eventListProvider.eventsFavoriteList.length))

        ],
        ),
      ),
    );

  }
}
