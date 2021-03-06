import 'package:flutter/material.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: Color.fromRGBO(87, 35, 100, 0.5),
          content: Text(message, textAlign: TextAlign.center),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'), onPressed: () => Navigator.of(context).pop())
          ],
        );
      });
}
