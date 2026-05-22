import 'package:flutter/material.dart';

class IconUtils {

  static IconData getIcon(
      String iconName,
      ) {

    switch (iconName) {

      case "school_rounded":
        return Icons.school_rounded;

      case "menu_book_rounded":
        return Icons.menu_book_rounded;

      case "lightbulb_rounded":
        return Icons.lightbulb_rounded;

      case "groups_rounded":
        return Icons.groups_rounded;

      default:
        return Icons.star_rounded;
    }
  }
}