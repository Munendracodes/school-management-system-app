import 'package:flutter/material.dart';

class ColorUtils {

  static Color fromHex(String hex) {

    final buffer = StringBuffer();

    if (hex.length == 7) {
      buffer.write('ff');
    }

    buffer.write(
      hex.replaceFirst('#', ''),
    );

    return Color(
      int.parse(
        buffer.toString(),
        radix: 16,
      ),
    );
  }
}