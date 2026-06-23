import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {

  final String title;
  final String subtitle;

  const AppLoadingWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF8FAFC),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [



              /// SPINNER

              const SizedBox(

                width: 34,
                height: 34,

                child:
                CircularProgressIndicator(

                  strokeWidth: 3,

                  color: Color(
                    0xFF2457FF,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(

                title,

                textAlign: TextAlign.center,

                style: const TextStyle(

                  fontSize: 22,

                  fontWeight:
                  FontWeight.w700,

                  color:
                  Color(0xFF081B5C),
                ),
              ),

              const SizedBox(height: 8),

              Text(

                subtitle,

                textAlign: TextAlign.center,

                style: const TextStyle(

                  fontSize: 14,

                  height: 1.5,

                  color:
                  Color(0xFF667085),
                ),
              ),

              const SizedBox(height: 30),


            ],
          ),
        ),
      ),
    );
  }

  static Widget _dot({
    Color color =
    const Color(0xFFD0D5DD),
  }) {

    return Container(

      height: 8,
      width: 8,

      decoration: BoxDecoration(

        color: color,

        shape: BoxShape.circle,
      ),
    );
  }
}