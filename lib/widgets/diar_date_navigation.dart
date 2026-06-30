import 'package:flutter/material.dart';

class DiaryDateNavigation extends StatelessWidget {

  final VoidCallback onPrevious;

  final VoidCallback onNext;

  final VoidCallback onToday;

  const DiaryDateNavigation({

    super.key,

    required this.onPrevious,

    required this.onNext,

    required this.onToday,
  });

  Widget _circleButton({

    required IconData icon,

    required VoidCallback onTap,

  }) {

    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(100),

      child: Container(

        height: 40,

        width: 40,

        decoration: BoxDecoration(

          color: Colors.white,

          shape: BoxShape.circle,

          boxShadow: [

            BoxShadow(

              color: Colors.black.withOpacity(.08),

              blurRadius: 15,

              offset: const Offset(0,5),
            ),
          ],
        ),

        child: Icon(

          icon,

          color: const Color(0xff15317E),

          size: 26,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        _circleButton(

          icon: Icons.chevron_left,

          onTap: onPrevious,
        ),

        const SizedBox(width: 18),

        Expanded(

          child: InkWell(

            onTap: onToday,

            borderRadius: BorderRadius.circular(30),

            child: Container(

              height: 40,

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(30),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black.withOpacity(.08),

                    blurRadius: 15,

                    offset: const Offset(0,5),
                  ),
                ],
              ),

              child: const Row(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(

                    Icons.calendar_month_rounded,

                    color: Color(0xff2457FF),
                  ),

                  SizedBox(width: 10),

                  Text(

                    "Today",

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.w700,

                      color: Color(0xff2457FF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 18),

        _circleButton(

          icon: Icons.chevron_right,

          onTap: onNext,
        ),
      ],
    );
  }
}