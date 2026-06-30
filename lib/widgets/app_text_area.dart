import 'package:flutter/material.dart';

class AppTextArea extends StatelessWidget {

  final String label;

  final String hint;

  final IconData icon;

  final TextEditingController controller;

  final int maxLines;

  final int? maxLength;

  const AppTextArea({

    super.key,

    required this.label,

    required this.hint,

    required this.icon,

    required this.controller,

    this.maxLines = 5,

    this.maxLength,
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

            fontWeight: FontWeight.w700,

            color: Color(0xFF5B6475),
          ),
        ),

        const SizedBox(height: 8),

        TextField(

          controller: controller,
          scrollPadding:
          const EdgeInsets.only(bottom: 140),

          maxLines: maxLines,

          maxLength: maxLength,

          textInputAction: TextInputAction.newline,

          decoration: InputDecoration(

            hintText: hint,

            alignLabelWithHint: true,

            prefixIcon: Padding(

              padding: const EdgeInsets.only(

                bottom: 90,
              ),

              child: Icon(

                icon,

                color: const Color(0xFF2457FF),
              ),
            ),

            filled: true,

            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(

              horizontal: 18,

              vertical: 18,
            ),

            enabledBorder: OutlineInputBorder(

              borderRadius:

              BorderRadius.circular(18),

              borderSide: const BorderSide(

                color: Color(0xFFDCE4F2),
              ),
            ),

            focusedBorder: OutlineInputBorder(

              borderRadius:

              BorderRadius.circular(18),

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