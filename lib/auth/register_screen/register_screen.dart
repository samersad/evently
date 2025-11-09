import 'package:event_planningapp/auth/register_screen/register_navigator.dart';
import 'package:event_planningapp/auth/register_screen/register_view_model.dart';
import 'package:event_planningapp/firebase_utils.dart';
import 'package:event_planningapp/home_screen/widget/custom_text_form_field.dart';
import 'package:event_planningapp/model/my_user.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home_screen/widget/custom_elevated_buttom.dart';
import '../../home_screen/widget/toggle_switch_language.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/event_list_provider.dart';
import '../../provider/user_provider.dart';
import '../../utils/alert_dialog.dart';
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen>implements RegisterNavigator {
  TextEditingController nameCtrl = TextEditingController(text: "samer");


  TextEditingController rePasswordCtrl = TextEditingController(text: "123456");

  RegisterViewModel viewModel=RegisterViewModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return ChangeNotifierProvider(create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.primaryLight,
          backgroundColor: AppColors.transparentColor,
          title: Text("${AppLocalizations.of(context)!.register}",style: AppStyles.bold20primary,),
          centerTitle: true,
        ),
        body: SafeArea(child:
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.05),
          child: SingleChildScrollView(
            child: Column(

              spacing: height*0.02,
              children: [
                Image.asset(AppAssets.logo1),
                Form(
                    key: viewModel.formkey,
                    child: Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: height*0.02,
                  children: [
                    CustomTextFormField(hintText: "${AppLocalizations.of(context)!.name}",
                      prefixIconName:Image.asset(AppAssets.name,color: Theme.of(context).highlightColor,),
                      keyboardType: TextInputType.emailAddress,
                      controller: nameCtrl,
                      validator:(name) {
                        if (name==null || name.trim().isEmpty) {
                          return "${AppLocalizations.of(context)!.pleaseEnterName}";
                        }
                        return null;
                      }, ),
                    CustomTextFormField(hintText: AppLocalizations.of(context)!.email,
                      prefixIconName:Image.asset(AppAssets.emailIcon,color: Theme.of(context).highlightColor,),
                      keyboardType: TextInputType.emailAddress,
                      controller: viewModel.emailCtrl,
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
                        controller: viewModel.passwordCtrl,

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
                        suffixIconName:Image.asset(AppAssets.showPassIcon,color: Theme.of(context).highlightColor,)),
                    CustomTextFormField(hintText: "${AppLocalizations.of(context)!.re_password}",
                        keyboardType: TextInputType.number,
                          obscureText: true,
                        obscuringCharacter: "*",
                        controller: rePasswordCtrl,
                        validator:(text) {
                          if (text==null || text.trim().isEmpty) {
                            return "${AppLocalizations.of(context)!.pleaseEnterPassword}";
                          }
                          if (rePasswordCtrl.text!=viewModel.passwordCtrl.text) {
                            return "${AppLocalizations.of(context)!.rePasswordMustMatch}";
                          }
                          if (text.length<6) {
                            return "${AppLocalizations.of(context)!.pleaseEnterAtLeast6Char}";
                          }
                          return null;
                        },
                      prefixIconName:Image.asset(AppAssets.passwordIcon,color: Theme.of(context).highlightColor,),
                        suffixIconName:Image.asset(AppAssets.showPassIcon,color: Theme.of(context).highlightColor,)),

                    CustomElevatedButtom(text: "${AppLocalizations.of(context)!.create_account}",onPressed: viewModel.register,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${AppLocalizations.of(context)!.already_have_account}?",style: Theme.of(context).textTheme.bodyMedium),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("${AppLocalizations.of(context)!.login}",
                            style: AppStyles.bold16Primary.copyWith(decoration:TextDecoration.underline,decorationColor: AppColors.primaryLight )
                        ),),                    ],
                    ),
                  ],
                )
                ),
                ToggleSwitchLanguage()
              ],
            ),
          ),
        )),
      ),
    );
  }



  @override
  void hideLoading() {
    Navigator.of(context);
    AlertDialogUtils.hideLoading(context: context);
  }

  @override
  void showLoading({required String message}) {
    AlertDialogUtils.showMessage(context: context, msg: message);
  }

  @override
  void showMessage({required String message}) {
    AlertDialogUtils.showMessage(context: context, msg: message,pos: "OK");
  }
}
