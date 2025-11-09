import 'package:event_planningapp/auth/login_screen/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase_utils.dart';

class LoginViewModel extends ChangeNotifier{
  TextEditingController emailCtrl = TextEditingController(text: "samer@gmail.com");

  TextEditingController passwordCtrl = TextEditingController(text: "123456");
  late LoginNavigator navigator;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> login() async {
    if (formkey.currentState?.validate() == true) {
      navigator.showLoading(message: "loading..");
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailCtrl.text,
            password: passwordCtrl.text
        );
        var user = await FireBaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        // if (user == null) {
        //   return ;
        // }
        // final userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.updateUser(user);
        // final eventProvider = Provider.of<EventListProvider>(context, listen: false);
        // eventProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        // eventProvider.getAllFavoriteEvents(userProvider.currentUser!.id);

        navigator.hideLoading();
        navigator.showMessage(message: "login_successfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          navigator.hideLoading();
          navigator.showMessage(
              message: "no_user_found_for_that_email_or_wrong_password");
        }
      }
      catch (e) {
        navigator.hideLoading();
        navigator.showMessage(message: e.toString());
      }
    }
  }
}