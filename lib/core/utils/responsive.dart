import 'package:flutter/material.dart';

class Responsive {

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1100;
  }

  static double contentWidth(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    if (isDesktop(context)) {
      return 500;
    }

    if (isTablet(context)) {
      return 460;
    }

    return width;
  }
}