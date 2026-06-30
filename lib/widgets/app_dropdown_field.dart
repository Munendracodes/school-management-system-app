import 'package:flutter/material.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final IconData icon;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.icon,
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

          padding: const EdgeInsets.symmetric(horizontal: 16),

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

              const SizedBox(width: 12),

              Expanded(

                child: DropdownButtonHideUnderline(

                  child: DropdownButton<T>(

                    value: value,

                    hint: Text(hint),

                    isExpanded: true,

                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),

                    items: items,

                    onChanged: onChanged,
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