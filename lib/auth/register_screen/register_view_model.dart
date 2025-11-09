import 'package:event_planningapp/auth/register_screen/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier{

//todo hold data and handel logic
  TextEditingController emailCtrl = TextEditingController(text: "samer@gmail.com");

  TextEditingController passwordCtrl = TextEditingController(text: "123456");
 late RegisterNavigator navigator ;

 GlobalKey<FormState> formkey = GlobalKey<FormState>();

 Future<void> register() async {
   if (formkey.currentState?.validate()==true) {
     navigator.showLoading(message: "loading...");
     try {
       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: emailCtrl.text,
           password: passwordCtrl.text
       );

       // MyUser myUser=MyUser(id: credential.user?.uid ?? "",
       //     name: nameCtrl.text,
       //     email: emailCtrl.text);
       // await  FireBaseUtils.addUserToFirestore(myUser);
       // final userProvider = Provider.of<UserProvider>(context, listen: false);
       // final eventProvider = Provider.of<EventListProvider>(context, listen: false);
       // userProvider.updateUser(myUser);
       // eventProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
       // eventProvider.getAllFavoriteEvents(userProvider.currentUser!.id);
       navigator.hideLoading();
       navigator.showMessage(message: "Register Successfully");

     }
     on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         navigator.hideLoading();
         navigator.showMessage(message: "Weak Password , Title");
       } else if (e.code == 'email-already-in-use') {
         navigator.hideLoading();
         navigator.showMessage(message: "email_already_in_use,title");
       }
     } catch (e) {
       navigator.hideLoading();
       navigator.showMessage(message:e.toString());
     }
 }

}
}