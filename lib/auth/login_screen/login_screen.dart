import 'package:event_planningapp/home_screen/widget/custom_text_form_field.dart';
import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home_screen/widget/custom_elevated_buttom.dart';
import '../../home_screen/widget/toggle_switch_language.dart';
import '../../utils/alert_dialog.dart';
class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController(text: "samer@gmail.com");

  TextEditingController passwordCtrl = TextEditingController(text: "123456");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return Scaffold(
      body: SafeArea(child:
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.05),
        child: SingleChildScrollView(
          child: Column(
            spacing: height*0.02,
            children: [
              Image.asset(AppAssets.logo1),
              Form(
                  key: formkey,
                  child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height*0.02,
                children: [
                  CustomTextFormField(
                    hintText: "${AppLocalizations.of(context)!.email}",
                    prefixIconName:Image.asset(AppAssets.emailIcon,color: Theme.of(context).highlightColor,),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailCtrl,
                    validator:(email) {
                      if (email==null || email.trim().isEmpty) {
                        return "${AppLocalizations.of(context)!.pleaseEnterEmail}";
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      if (!emailValid) {
                        return "${AppLocalizations.of(context)!.pleaseEnterValidEmail}";
                      }
                      return null;
                    }, ),
                  CustomTextFormField(hintText: "${AppLocalizations.of(context)!.password}",
                      keyboardType: TextInputType.number,
                       obscureText: true,
                      obscuringCharacter: "*",
                      controller: passwordCtrl,
                      validator:(text) {
                        if (text==null || text.trim().isEmpty) {
                          return "${AppLocalizations.of(context)!.pleaseEnterPassword}";
                        }
                        if (text.length<6) {
                          return "${AppLocalizations.of(context)!.pleaseEnterAtLeast6Char}";
                        }
                        return null;
                      },
                    prefixIconName:Image.asset(AppAssets.passwordIcon,color: Theme.of(context).highlightColor,),
                      suffixIconName:InkWell(
                        onTap: () {
                          //obscureText==true;
                        },
                          child: Image.asset(AppAssets.showPassIcon,color: Theme.of(context).highlightColor,))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        //todo navigate to forget password screen
                      }, child: Text("${AppLocalizations.of(context)!.forget_password}?",
                          style: AppStyles.bold16Primary.copyWith(decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight)
                      ),),
                    ],
                  ),
                  CustomElevatedButtom(text: "${AppLocalizations.of(context)!.login}",onPressed: login,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${AppLocalizations.of(context)!.dont_have_account}?",style: Theme.of(context).textTheme.bodyMedium,),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(AppRoutes.registerScreenRouteNamed);
                      }, child: Text("${AppLocalizations.of(context)!.create_account}",
                          style: AppStyles.bold16Primary.copyWith(decoration:TextDecoration.underline,decorationColor: AppColors.primaryLight )
                      ),),                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,

                          color: AppColors.primaryLight,
                          indent: width*0.04,
                          endIndent: width*0.04,
                        ),
                      ),
                      Text("${AppLocalizations.of(context)!.or}",style: AppStyles.medium16primary,),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: AppColors.primaryLight,
                          indent: width*0.04,
                          endIndent: width*0.04,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButtom(text: "${AppLocalizations.of(context)!.login_with_google}",
                    onPressed: loginWithGoogle,backgroundColorElevated: AppColors.transparentColor,
                    borderColor: AppColors.primaryLight,
                    hasIcon: true,childIconWidget:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppAssets.iconGoogle),
                            SizedBox(width: width*0.02,),
                            Text(AppLocalizations.of(context)!.login_with_google,style: AppStyles.medium20primary)
                          ],

                        ),
                  ),
                ],
              )
              ),
              ToggleSwitchLanguage()

            ],
          ),
        ),
      )),
    );
  }

  Future<void> login() async {
    if (formkey.currentState?.validate() == true) {
      AlertDialogUtils.showLoading(context: context, msg: "loading .....");
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailCtrl.text,
            password: passwordCtrl.text
        );
        AlertDialogUtils.hideLoading(context: context);
        AlertDialogUtils.showMessage(context: context, msg: "Login Successfully",title: "Success",
            pos: "ok",posAction: (){
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homeScreenRouteNamed,
                      (route)=>false);
            },
            nav: "dismiss",navAction: (){
              Navigator.pop(context);
            }
            );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          AlertDialogUtils.hideLoading(context: context);
          AlertDialogUtils.showMessage(context: context,
            msg: "'No user found for that email or wrong password'",title: "error",);
        }
      }
      catch(e){
        print(e.toString());
      }
    }
   // Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreenRouteNamed);


  }

  void loginWithGoogle() {
  }
}
