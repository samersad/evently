import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtom extends StatelessWidget {
   CustomElevatedButtom({super.key, required this.onPressed,
      this.text,
     this.backgroundColorElevated=AppColors.primaryLight,this.iconName,
     this.textStyle,
   this.borderColor=AppColors.transparentColor,this.hasIcon=false,this.mainAxisAlignment,this.childIconWidget,
   this.customPadding=20});
  //final VoidCallback onPressed;
   final  String? text;

   final Color backgroundColorElevated;
   final void Function() onPressed ;
   final Widget? iconName;
   final Widget? childIconWidget;
  final TextStyle? textStyle;

  final Color? borderColor;

  final bool hasIcon;

   MainAxisAlignment? mainAxisAlignment;

   final double customPadding;

   @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: customPadding),
            backgroundColor: backgroundColorElevated,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor!,width: 2),
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
        ),
        child: hasIcon?
        childIconWidget
            :
        Text(text??"",style: textStyle ??AppStyles.medium20white)

    );
  }
}
