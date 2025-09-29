import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {

  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return Container(
      height:height*0.25 ,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight),
        image: DecorationImage(image: AssetImage(AppAssets.eventImage),fit: BoxFit.fill)
      ) ,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.005),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).canvasColor
              ) ,
              child: Column(
                children: [
                  Text("21",style: AppStyles.bold20primary,),
                  Text("Nov",style: AppStyles.bold14primary,),
                ],
              )
              ,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.01),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).canvasColor
              ) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("This is a Birthday Party ",style: Theme.of(context).textTheme.headlineSmall,)),
                  Icon(Icons.favorite,color: AppColors.primaryLight,)
                ],
              )
              ,
            ),

          ],
        ),
      ),
    );
  }
}
