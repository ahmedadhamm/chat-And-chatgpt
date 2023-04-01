import 'package:flutter/material.dart';

class DialogUitils {
  static void showProgressDialog(BuildContext context, String message,
      {bool isDismissible = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 12,
              ),
              Text(message)
            ],
          ),
        );
      },
      barrierDismissible: false,
    );
  }
}

void showMessage(BuildContext context, String message,
    {String? posActionTitle,
    String? negActionTitle,
    VoidCallback? posAction,
    VoidCallback? negAction,
    bool isDismissible = true}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      List<Widget> actions = [];
      if (posActionTitle != null) {
        actions.add(TextButton(
            onPressed: () {
              Navigator.pop(context);
              posAction!();
            },
            child: Text(posActionTitle)));
      }
      if (negActionTitle != null) {
        actions.add(TextButton(
            onPressed: () {
              Navigator.pop(context);
              negAction!();
            },
            child: Text(negActionTitle)));
      }
      return AlertDialog(
        content: Text(message),
        actions: actions,
      );
    },
    barrierDismissible: isDismissible,
  );
}

void hideDialog(BuildContext context) {
  Navigator.pop(context);
}

void showLoading(BuildContext context, String s) {}
void hideLoading(BuildContext context) {}
