import 'package:flutter/material.dart.';

import '../Utils/dialog_uitlis.dart';

abstract class BaseNavigator {
  void showLoadingDialog({String message = "Loading..."});

  void hideLoadingDialog();

  void showMessageDialog(String message,
      {String? posActionTitle,
      String? negActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isDismissible = true});
}

class BaseViewModel<Nev extends BaseNavigator> extends ChangeNotifier {
  Nev? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void hideLoadingDialog() {
    hideLoading(context);
  }

  @override
  void showLoadingDialog({String message = "Loading..."}) {
    showLoading(context, message);
  }

  @override
  void showMessageDialog(String message,
      {String? posActionTitle,
      String? negActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isDismissible = true}) {
    showMessage(context, message,
        posActionTitle: posActionTitle,
        posAction: posAction,
        negAction: negAction,
        negActionTitle: negActionTitle,
        isDismissible: isDismissible);
  }
}
