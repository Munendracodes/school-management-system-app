import 'package:flutter/material.dart';

class DiaryHeader extends StatelessWidget {

  final String className;

  final VoidCallback onBack;

  final VoidCallback onCalendar;

  const DiaryHeader({

    super.key,

    required this.className,

    required this.onBack,

    required this.onCalendar,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(

        horizontal: 20,

        vertical: 12,
      ),

      child: Column(

        children: [

          Row(

            children: [

              Container(

                height: 45,

                width: 45,

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(18),

                  boxShadow: [

                    BoxShadow(

                      color: Colors.black.withOpacity(.06),

                      blurRadius: 15,

                      offset: const Offset(0,5),
                    )
                  ],
                ),

                child: IconButton(

                  onPressed: onBack,

                  icon: const Icon(

                    Icons.arrow_back_ios_new,

                    color: Color(0xff15317E),
                  ),
                ),
              ),

              const Spacer(),

              Column(

                children: const [

                  Text(

                    "Student Diary",

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.w700,

                      color: Color(0xff15317E),

                      fontFamily: "PatrickHand",
                    ),
                  ),



                  SizedBox(

                    width: 170,

                    child: Divider(

                      color: Color(0xffF4B400),

                      thickness: 3,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Container(

                height: 40,

                width: 40,

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(18),

                  boxShadow: [

                    BoxShadow(

                      color: Colors.black.withOpacity(.06),

                      blurRadius: 15,

                      offset: const Offset(0,5),
                    )
                  ],
                ),

                child: IconButton(

                  onPressed: onCalendar,

                  icon: const Icon(

                    Icons.calendar_month,

                    color: Color(0xff2457FF),
                  ),
                ),
              ),
            ],
          ),



          Text(

            className,

            style: const TextStyle(

              fontSize: 15,

              color: Color(0xff6C7280),

              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}