import 'package:flutter/material.dart';

class HomeworkItem extends StatelessWidget {

  final Color iconColor;

  final IconData icon;

  final String subjectName;

  final String homework;

  final VoidCallback? onTap;

  const HomeworkItem({

    super.key,

    required this.iconColor,

    required this.icon,

    required this.subjectName,

    required this.homework,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(20),

      onTap: onTap,

      child: Padding(

        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        child: Row(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// Subject Icon
            Container(

              height: 40,

              width: 40,

              decoration: BoxDecoration(

                color: iconColor,

                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(

                icon,

                color: Colors.white,

                size: 25,
              ),
            ),

            const SizedBox(width: 10),

            /// Homework Details
            Expanded(

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    subjectName,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                      color: Color(0xff15317E),
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(

                    homework,

                    style: const TextStyle(

                      fontSize: 13,

                      color: Color(0xff3D4558),

                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            /// Arrow
            const Icon(

              Icons.chevron_right_rounded,

              color: Color(0xff2457FF),

              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}