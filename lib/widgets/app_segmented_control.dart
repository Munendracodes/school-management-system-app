import 'package:flutter/material.dart';

class AppSegmentedControl extends StatelessWidget {

  final bool value;

  final String leftText;

  final String rightText;

  final Color selectedColor;

  final ValueChanged<bool> onChanged;

  const AppSegmentedControl({

    super.key,

    required this.value,

    required this.leftText,

    required this.rightText,

    required this.onChanged,

    this.selectedColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(

      duration: const Duration(

        milliseconds: 250,
      ),

      padding: const EdgeInsets.all(4),

      decoration: BoxDecoration(

        color: Colors.grey.shade100,

        borderRadius:
        BorderRadius.circular(35),
      ),

      child: Row(

        children: [

          Expanded(

            child: GestureDetector(

              onTap: () {

                onChanged(false);

              },

              child: AnimatedContainer(

                duration: const Duration(

                  milliseconds: 250,
                ),

                padding:
                const EdgeInsets.symmetric(

                  vertical: 11,
                ),

                decoration: BoxDecoration(

                  color: !value

                      ? Colors.orange

                      : Colors.transparent,

                  borderRadius:
                  BorderRadius.circular(30),
                ),

                child: AnimatedDefaultTextStyle(

                  duration: const Duration(

                    milliseconds: 250,
                  ),

                  style: TextStyle(

                    color: !value

                        ? Colors.white

                        : Colors.black54,

                    fontWeight:
                    FontWeight.bold,

                    fontSize: 14,
                  ),

                  child: Text(

                    leftText,

                    textAlign:
                    TextAlign.center,
                  ),
                ),
              ),
            ),
          ),

          Expanded(

            child: GestureDetector(

              onTap: () {

                onChanged(true);

              },

              child: AnimatedContainer(

                duration: const Duration(

                  milliseconds: 250,
                ),

                padding:
                const EdgeInsets.symmetric(

                  vertical: 11,
                ),

                decoration: BoxDecoration(

                  color: value

                      ? selectedColor

                      : Colors.transparent,

                  borderRadius:
                  BorderRadius.circular(30),
                ),

                child: AnimatedDefaultTextStyle(

                  duration: const Duration(

                    milliseconds: 250,
                  ),

                  style: TextStyle(

                    color: value

                        ? Colors.white

                        : Colors.black54,

                    fontWeight:
                    FontWeight.bold,

                    fontSize: 14,
                  ),

                  child: Text(

                    rightText,

                    textAlign:
                    TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}