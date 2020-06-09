import 'package:flutter/material.dart';

double changePaddingKeyBoard(BuildContext context) {
  double topPadding = 0;

  bool keyboardPress = MediaQuery.of(context).viewInsets.vertical > 0;
  bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;

  topPadding = keyboardPress ? 65 : 180;

  if (landscape) {
    topPadding = keyboardPress ? 0 : 50;
  }
  return topPadding;
}
