import 'package:flutter/material.dart';

class AppTimeline extends StatelessWidget {

  const AppTimeline({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 14),

      child: Row(

        children: [

          Expanded(

            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),

          Container(

            margin: const EdgeInsets.symmetric(horizontal: 12),

            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(

              color: const Color(0xFFF1F5FF),

              shape: BoxShape.circle,
            ),

            child: const Icon(

              Icons.arrow_downward,

              size: 18,

              color: Color(0xFF2457FF),
            ),
          ),

          Expanded(

            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}