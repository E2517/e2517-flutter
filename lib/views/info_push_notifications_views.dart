import 'package:flutter/material.dart';
import 'dart:async';
import 'package:e2517/utils/background_image_utils.dart' as background;

class InfoPushNotificationsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final dataPushNotifications = ModalRoute.of(context).settings.arguments;

    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, 'user'));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          background.backgroundImage(context),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(70.0),
              child: Container(
                child: Text(
                  'Must create a new Superheroe $dataPushNotifications',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
