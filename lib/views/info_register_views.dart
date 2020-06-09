import 'package:flutter/material.dart';
import 'dart:async';
import 'package:e2517/utils/background_image_utils.dart' as background;

class InfoPage extends StatelessWidget {
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, 'login'));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          background.backgroundImage(context),
          Center(
            child: Container(
              child: Text(
                'User created in Firebase -> redirecting to Login',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
