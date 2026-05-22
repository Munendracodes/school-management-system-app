import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {

  final double size;

  const AppLogo({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: size,
      width: size,

      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(size * 0.20),

        child: Image.asset(
          "assets/images/logo.png",

          fit: BoxFit.contain,
        ),
      ),
    );
  }
}