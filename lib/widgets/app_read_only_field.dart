import 'package:flutter/material.dart';

class AppReadOnlyField extends StatelessWidget {

  final String label;

  final String value;

  final IconData icon;

  final String? badge;

  const AppReadOnlyField({

    super.key,

    required this.label,

    required this.value,

    required this.icon,

    this.badge,
  });

  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(

          label,

          style: const TextStyle(

            fontSize: 14,

            fontWeight: FontWeight.w600,

            color: Color(0xFF5B6475),
          ),
        ),

        const SizedBox(height: 10),

        Container(

          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),

          decoration: BoxDecoration(

            color: const Color(0xFFF8FAFF),

            borderRadius: BorderRadius.circular(18),

            border: Border.all(
              color: const Color(0xFFE4EAF4),
            ),
          ),

          child: Row(

            children: [

              Icon(
                icon,
                color: const Color(0xFF2457FF),
              ),

              const SizedBox(width: 14),

              Expanded(

                child: Text(

                  value,

                  style: const TextStyle(

                    fontWeight: FontWeight.w700,

                    fontSize: 16,

                    color: Color(0xFF081B5C),
                  ),
                ),
              ),

              if (badge != null)

                Container(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),

                  decoration: BoxDecoration(

                    color: Colors.green.shade100,

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(

                    badge!,

                    style: const TextStyle(

                      color: Colors.green,

                      fontWeight: FontWeight.bold,

                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}