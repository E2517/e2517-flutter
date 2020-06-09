import 'package:flutter/material.dart';
import 'dart:async';

class Page404 extends StatelessWidget {
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, 'login'));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          Center(
            child: Container(
              child: Text(
                'Paged not founded -> redirecting to Login',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
