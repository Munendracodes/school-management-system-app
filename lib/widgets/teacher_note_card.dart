import 'package:flutter/material.dart';

class TeacherNoteCard extends StatelessWidget {

  final String note;

  final VoidCallback? onTap;

  const TeacherNoteCard({

    super.key,

    required this.note,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(26),

      child: Container(

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(

          color: const Color(0xffFFF8EA),

          borderRadius: BorderRadius.circular(26),

          boxShadow: [

            BoxShadow(

              color: Colors.orange.withOpacity(.08),

              blurRadius: 15,

              offset: const Offset(0,6),
            ),
          ],
        ),

        child: Row(

          children: [

            const Icon(

              Icons.push_pin_rounded,

              color: Colors.deepOrange,

              size: 25,
            ),

            const SizedBox(width: 18),

            Expanded(

              child: Text(

                note,

                style: const TextStyle(

                  fontSize: 15,

                  color: Color(0xff3A3A3A),

                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(width: 16),

            Container(

              height: 35,

              width: 35,

              decoration: BoxDecoration(

                color: const Color(0xffFFF2CC),

                borderRadius: BorderRadius.circular(14),

                boxShadow: [

                  BoxShadow(

                    color: Colors.orange.withOpacity(.15),

                    blurRadius: 8,
                  ),
                ],
              ),

              child: const Icon(

                Icons.favorite_border,

                color: Colors.red,

                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}