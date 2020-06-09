import 'package:flutter/material.dart';

Widget backgroundImage(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/background.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  );
}
