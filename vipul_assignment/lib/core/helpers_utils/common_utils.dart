import 'package:flutter/material.dart';

class CommonUtils{
  static int calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 2;
    } else if (screenWidth < 1200) {
      return 3;
    } else if (screenWidth < 1800) {
      return 4;
    } else {  // Larger desktops
      return 5;
    }
  }
}