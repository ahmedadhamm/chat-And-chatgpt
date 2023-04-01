import 'dart:io';

import 'package:chat_oline_1/base/base.dart';
import 'package:chat_oline_1/date_base/my_data_base.dart';
import 'package:chat_oline_1/model/my_user.dart';
import 'package:chat_oline_1/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void gotoHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var auth = FirebaseAuth.instance;

  void register(
      String email, String password, String userName, String fullName) async {
    navigator?.hideLoadingDialog();
    try {
      var credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser newUser = MyUser(
        id: credentials.user?.uid,
        fullName: fullName,
        userName: userName,
        email: email,
      );
      var insertedUser = await MyDataBase.insertUser(newUser);
      navigator?.hideLoadingDialog();
      if (insertedUser != null) {
        // user insert successfully
        SharedData.user = insertedUser;
        // go to home
        navigator?.gotoHome();
      } else {
        //error whit database show error
        navigator
            ?.showMessageDialog('something went wrong, error whit database ');
      }

      navigator?.showMessageDialog(credentials.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessageDialog('Email is already register');
      }
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator
          ?.showMessageDialog('something went wrong ,please try again later');
    }
  }
}
