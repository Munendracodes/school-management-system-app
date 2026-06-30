import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/constants/app_colors.dart';

class HomeworkDateSelector extends StatelessWidget {

  final Color selectedColor;

  final DateTime selectedDate;

  final VoidCallback onPrevious;

  final VoidCallback onNext;

  final VoidCallback onPickDate;

  const HomeworkDateSelector({

    super.key,

    required this.selectedDate,

    required this.onPrevious,

    required this.onNext,

    required this.onPickDate,

    required this.selectedColor
  });

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        InkWell(

          onTap: onPickDate,

          child: Row(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [
              IconButton(onPressed: onPrevious,
                  icon: Icon(Icons.chevron_left,
                    color: selectedColor)
              ),
              SizedBox(width: 10),

              Text(

                DateFormat(
                  "EEEE, dd MMM yyyy",
                ).format(selectedDate),

                style: TextStyle(

                  fontSize: 16,

                  fontWeight: FontWeight.bold,

                  color: selectedColor,
                ),
              ),

              SizedBox(width: 10),

              IconButton(onPressed: onNext,
                  icon: Icon(Icons.chevron_right,
                  color: selectedColor,
                  )
              ),

            ],
          ),
        ),
      ],
    );
  }
}