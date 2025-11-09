import 'dart:async';

import 'package:event_planningapp/auth/login_screen/login_navigator.dart';
import 'package:event_planningapp/auth/login_screen/login_view_model.dart';
import 'package:event_planningapp/firebase_utils.dart';
import 'package:event_planningapp/home_screen/widget/custom_text_form_field.dart';
import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/provider/event_list_provider.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../home_screen/widget/custom_elevated_buttom.dart';
import '../../home_screen/widget/toggle_switch_language.dart';
import '../../model/my_user.dart';
import '../../provider/user_provider.dart';
import '../../utils/alert_dialog.dart';
class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
implements LoginNavigator
{

  LoginViewModel viewModel =LoginViewModel();
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
                    CustomTextFormField(
                      hintText: "${AppLocalizations.of(context)!.email}",
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
                    CustomElevatedButtom(text: "${AppLocalizations.of(context)!.login}",onPressed: viewModel.login,),
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
                      onPressed: signInWithGoogle,backgroundColorElevated: AppColors.transparentColor,
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
      ),
    );
  }



  Future<UserCredential> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return Future.error("Google Sign-In cancelled");
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      var user = await FireBaseUtils.readUserFromFireStore(userCredential.user?.uid ?? '');

      if (user == null) {
        user = MyUser(
          id: userCredential.user?.uid ?? '',
          name: userCredential.user?.displayName ?? '',
          email: userCredential.user?.email ?? '',
        );
        await FireBaseUtils.addUserToFirestore(user);
      }
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(user);

      final eventProvider = Provider.of<EventListProvider>(context, listen: false);
      eventProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      eventProvider.getAllFavoriteEvents(userProvider.currentUser!.id);
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.homeScreenRouteNamed,
            (route) => false,
      );
      return userCredential;
    }
    catch (e) {
      AlertDialogUtils.showMessage(
        context: context,
        msg: e.toString(),
        title: AppLocalizations.of(context)!.google_sign_in_error,
      );
      rethrow;
    }
  }

  @override
  void hideLoading() {
    Navigator.of(context);
    AlertDialogUtils.hideLoading(context: context);  }

  @override
  void showLoading({required String message}) {
    AlertDialogUtils.showMessage(context: context, msg: message);
  }

  @override
  void showMessage({required String message}) {
    AlertDialogUtils.showMessage(context: context, msg: message,pos: "OK",
        posAction: Navigator.of(context).pop
    );
  }


}

