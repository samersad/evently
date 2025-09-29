import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';


import '../../../../utils/app_styles.dart';
import '../../../home_screen/widget/custom_text_form_field.dart';
import '../home/widget/event_item.dart';

class FavoriteTap extends StatelessWidget {
   FavoriteTap({super.key});
  TextEditingController searchCrl=TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
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
            Expanded(child:  ListView.separated(itemBuilder: (context, index) {
          return EventItem();
        }, separatorBuilder: (context, index) => SizedBox(height: height*0.01), itemCount: 10))
      
        ],
        ),
      ),
    );

  }
}
