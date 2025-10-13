import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AlertDialogUtils{
  static void  showLoading({required BuildContext context,required String msg}){
showDialog(barrierDismissible: false,context: context, builder: (context) => AlertDialog(
  content: Row(
    children: [
      CircularProgressIndicator(color: AppColors.primaryLight,),
      SizedBox(width:20,),
      Text(msg ,style: AppStyles.medium16black,)
    ],
  ),
)
);
  }
static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }

 static void showMessage({required BuildContext context,
   required String msg,
    String? title,
    String? pos,
   Function? posAction,
    String? nav,
   Function? navAction,


 }){
   List<Widget> actions =[];
   if (pos!=null) {
     actions.add(TextButton(onPressed: (){
       //Navigator.pop(context);
       posAction?.call();
     }, child: Text(pos,style: AppStyles.medium20primary,)));
   }
   if (nav!=null) {
     actions.add(TextButton(onPressed: (){
       //Navigator.pop(context);
       navAction?.call();
     }, child: Text(nav,style: AppStyles.medium20primary,)));
   }
   showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text(msg,style: AppStyles.medium16black,),
        title:Text(title ?? "" ,style: AppStyles.medium16black,) ,
        actions: actions
        );
    },);
 }
}