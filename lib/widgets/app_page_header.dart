import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AppPageHeader extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;

  const AppPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        InkWell(

          borderRadius: BorderRadius.circular(14),

          onTap: () {

            Navigator.pop(context);
          },

          child: Container(

            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius: BorderRadius.circular(14),

              border: Border.all(
                color: const Color(0xFFE4EAF4),
              ),
            ),

            child: const Icon(

              Icons.arrow_back_ios_new,

              size: 18,

              color: AppColors.primaryBlue,
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  Expanded(

                    child: Text(

                      title,

                      style: const TextStyle(

                        fontSize: 20,

                        fontWeight: FontWeight.bold,

                        color: Color(0xFF081B5C),
                      ),
                    ),
                  ),
                ],
              ),



              Text(

                subtitle,

                style: TextStyle(

                  color: Colors.grey.shade600,

                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}