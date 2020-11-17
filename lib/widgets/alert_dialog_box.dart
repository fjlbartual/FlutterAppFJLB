import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_p2/locale/localization.i18n.dart';

void showAlertDialog(BuildContext context, String message, int back) {
  Widget okButton = FlatButton(
    child: Text("OK".i18n),
    onPressed: () {
      for (int i = 0; i < back; i++) Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Error".i18n),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
