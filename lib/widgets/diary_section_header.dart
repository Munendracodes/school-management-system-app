import 'package:flutter/material.dart';

class DiarySectionHeader extends StatelessWidget {

  final IconData icon;

  final String title;

  final String badge;

  final Color color;

  const DiarySectionHeader({

    super.key,

    required this.icon,

    required this.title,

    required this.badge,

    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        Container(

          height: 35,

          width: 35,

          decoration: BoxDecoration(

            color: color.withOpacity(.12),

            shape: BoxShape.circle,
          ),

          child: Icon(

            icon,

            color: color,

            size: 23,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(

          child: Text(

            title,

            style: TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.w700,

              color: color,
            ),
          ),
        ),

        Container(

          padding: const EdgeInsets.symmetric(

            horizontal: 14,

            vertical: 6,
          ),

          decoration: BoxDecoration(

            color: color.withOpacity(.10),

            borderRadius:
            BorderRadius.circular(25),
          ),

          child: Text(

            badge,

            style: TextStyle(

              color: color,

              fontWeight: FontWeight.bold,

              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}