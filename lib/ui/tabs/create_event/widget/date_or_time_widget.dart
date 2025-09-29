import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_styles.dart';

class DateOrTimeWidget extends StatelessWidget {
   DateOrTimeWidget({super.key,required this.iconName,required this.eventDateOrTime,required this.chooseDateOrTime,required this.onPressed,
   this.error});
   final String iconName;
  final String eventDateOrTime;

  final String chooseDateOrTime;
  final Text? error;

  void Function() onPressed;


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return  Row(
      children: [
        Image.asset(iconName,color: Theme.of(context).highlightColor),
        SizedBox(width: width*0.02),

        Text(eventDateOrTime,style: Theme.of(context).textTheme.labelMedium,),
        Spacer(),
        Column(
          children: [
            TextButton(onPressed: onPressed,
              child:  Text(chooseDateOrTime,style: AppStyles.medium16primary,),
            ),
            if (error != null) error!
          ],
        )

      ],
    );
    ;
  }
}
