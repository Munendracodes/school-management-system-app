import 'package:flutter/material.dart';

class AppFormCard extends StatelessWidget {

  final String title;

  final List<Widget> children;

  const AppFormCard({

    super.key,

    required this.title,

    required this.children,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE7ECF5),
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.04),

            blurRadius: 14,

            offset: const Offset(0,6),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(

            title,

            style: const TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.bold,

              color: Color(0xFF081B5C),
            ),
          ),

          const SizedBox(height: 24),

          ...children,
        ],
      ),
    );
  }
}