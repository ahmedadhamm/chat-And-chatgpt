import 'package:chat_oline_1/base/base.dart';
import 'package:chat_oline_1/date_base/my_data_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared_data.dart';

abstract class LoginNavigator extends BaseNavigator {
  void gotoHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var retrievedUser =
          await MyDataBase.getUserById(credential.user?.uid ?? "");
      if (retrievedUser != null) {
        navigator
            ?.showMessageDialog('something went Wrong, UserName or Password');
      } else {
        // user insert successfully
        SharedData.user = retrievedUser;
        // go to home
        navigator?.gotoHome();
      }
    } on FirebaseAuthException catch (e) {
      //get user from DB
      //show message with uer id
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('Wrong UserName or Password');
      if (e.code == 'user-not-found') {
        // show message with email or password...
      }
    }
  }

  void checkLoggedInUser() async {
    if (auth.currentUser != null) {
      var retrievedUser =
          await MyDataBase.getUserById(auth.currentUser?.uid ?? "");
      // user insert successfully
      SharedData.user = retrievedUser;
      // go to home
      navigator?.gotoHome();
    }
  }
}
