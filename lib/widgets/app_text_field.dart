import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
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

        TextField(

          controller: controller,

          decoration: InputDecoration(

            hintText: hint,

            prefixIcon: Icon(
              icon,
              color: const Color(0xFF2457FF),
            ),

            filled: true,

            fillColor: const Color(0xFFF8FAFF),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),

            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFFE4EAF4),
              ),
            ),

            focusedBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFF2457FF),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}