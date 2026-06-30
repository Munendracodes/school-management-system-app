import 'package:flutter/material.dart';

class DiaryEmptyView extends StatelessWidget {

  const DiaryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(

        vertical: 70,
      ),

      child: Column(

        children: [

          Icon(

            Icons.menu_book_outlined,

            size: 90,

            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 20),

          const Text(

            "Nothing added today",

            style: TextStyle(

              fontSize: 24,

              fontWeight: FontWeight.bold,

              color: Color(0xff15317E),
            ),
          ),

          const SizedBox(height: 10),

          const Text(

            "Homework, notes and circulars\nwill appear here.",

            textAlign: TextAlign.center,

            style: TextStyle(

              fontSize: 17,

              color: Colors.grey,

              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}