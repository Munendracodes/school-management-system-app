import 'package:flutter/material.dart';

class DiaryCard extends StatelessWidget {

  final Widget child;

  final EdgeInsetsGeometry? padding;

  final VoidCallback? onTap;

  const DiaryCard({

    super.key,

    required this.child,

    this.padding,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Material(

      color: Colors.transparent,

      child: InkWell(

        onTap: onTap,

        borderRadius: BorderRadius.circular(28),

        child: Container(

          width: double.infinity,

          padding: padding ??
              const EdgeInsets.all(22),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
            BorderRadius.circular(28),

            border: Border.all(

              color: const Color(0xFFE9EDF5),

              width: 1,
            ),

            boxShadow: [

              BoxShadow(

                color: Colors.black.withOpacity(.05),

                blurRadius: 18,

                offset: const Offset(0,8),
              ),
            ],
          ),

          child: child,
        ),
      ),
    );
  }
}