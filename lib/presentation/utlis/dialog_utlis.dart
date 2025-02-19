import 'package:flutter/material.dart';
class DialogUtlis{
static  void showMessageDialog(BuildContext context,
      {required String message,
        String? posButtonTitle,
        VoidCallback? posButtonAction,
        VoidCallback? negButtonAction,
        String? negButtonTitle}) {
    List<Widget> actions = [];
    if (posButtonTitle != null) {
      actions.add(
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              posButtonAction?.call();
            },
            child: Text(posButtonTitle)),
      );
    }
    if (negButtonTitle != null) {
      actions.add(
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              negButtonAction?.call();
            },
            child: Text(negButtonTitle)),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: actions,
        );
      },
    );
  }

 static void showLoadingDialog(BuildContext context, {required String message}) async{

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 12),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

 static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }


}

