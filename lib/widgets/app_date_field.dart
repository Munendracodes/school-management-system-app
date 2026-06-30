import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateField extends StatelessWidget {

  final String label;
  final String hint;
  final TextEditingController controller;

  const AppDateField({

    super.key,

    required this.label,

    required this.hint,

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

          readOnly: true,

          decoration: InputDecoration(

            hintText: hint,

            prefixIcon: const Icon(

              Icons.event,

              color: Color(0xFF2457FF),
            ),

            suffixIcon: const Icon(

              Icons.keyboard_arrow_down_rounded,
            ),

            filled: true,

            fillColor: const Color(0xFFF8FAFF),

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
              ),
            ),
          ),

          onTap: () async {

            final picked = await showDatePicker(

              context: context,

              initialDate: DateTime.now(),

              firstDate: DateTime(2000),

              lastDate: DateTime(2100),
            );

            if (picked != null) {

              controller.text =
                  DateFormat("dd MMM yyyy").format(picked);
            }
          },
        ),
      ],
    );
  }
}