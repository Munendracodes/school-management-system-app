import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {

  final Widget child;

  const ResponsivePage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {

        return SingleChildScrollView(

          physics:
          const BouncingScrollPhysics(),

          child: ConstrainedBox(

            constraints: BoxConstraints(
              minHeight:
              constraints.maxHeight,
            ),

            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
      },
    );
  }
}