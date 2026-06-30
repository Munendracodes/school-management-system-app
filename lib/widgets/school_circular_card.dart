import 'package:flutter/material.dart';

class SchoolCircularCard extends StatelessWidget {

  final String circular;

  final VoidCallback? onTap;

  const SchoolCircularCard({

    super.key,

    required this.circular,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(26),

      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: const Color(0xffFFF3F6),

          borderRadius: BorderRadius.circular(26),

          boxShadow: [

            BoxShadow(

              color: Colors.pink.withOpacity(.08),

              blurRadius: 15,

              offset: const Offset(0,6),
            ),
          ],
        ),

        child: Row(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            SizedBox(height: 10),

            const Icon(

              Icons.campaign_rounded,

              color: Colors.pink,

              size: 25,
            ),

            const SizedBox(width: 18),

            Expanded(

              child: Text(

                circular,

                style: const TextStyle(

                  fontSize: 15,

                  color: Color(0xff3A3A3A),

                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}