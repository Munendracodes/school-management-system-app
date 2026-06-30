import 'package:flutter/material.dart';

class DiaryDateCard extends StatelessWidget {

  final DateTime selectedDate;

  const DiaryDateCard({

    super.key,

    required this.selectedDate,
  });

  String get dayName {

    const days = [

      "Monday",

      "Tuesday",

      "Wednesday",

      "Thursday",

      "Friday",

      "Saturday",

      "Sunday",
    ];

    return days[selectedDate.weekday - 1];
  }

  String get monthName {

    const months = [

      "January",

      "February",

      "March",

      "April",

      "May",

      "June",

      "July",

      "August",

      "September",

      "October",

      "November",

      "December",
    ];

    return months[selectedDate.month - 1];
  }

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(

        horizontal: 20,
      ),

      child: Stack(

        children: [


          Container(

            height: 170,
            padding: EdgeInsets.all(10),

            decoration: BoxDecoration(

              color: const Color(0xffFFF9F7),

              borderRadius:
              BorderRadius.circular(28),

              boxShadow: [

                BoxShadow(

                  color: Colors.black.withOpacity(.06),

                  blurRadius: 20,

                  offset: const Offset(0,8),
                )
              ],
            ),

            child: Row(

              children: [

                /// Spiral

                SizedBox(

                  width: 34,

                  child: Column(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,

                    children: List.generate(

                      6,

                          (index) => Container(

                        width: 18,

                        height: 18,

                        decoration: BoxDecoration(

                          border: Border.all(

                            color:
                            const Color(0xff183A8F),

                            width: 3,
                          ),

                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(

                  child: Padding(

                    padding:
                    const EdgeInsets.only(

                      right: 18,

                      left: 6,

                      top: 20,

                      bottom: 20,
                    ),

                    child: Column(

                      children: [

                        Text(

                          dayName,

                          style: const TextStyle(

                            fontSize: 18,

                            fontWeight: FontWeight.w500,

                            color: Color(0xff4E566D),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(

                          selectedDate.day.toString(),

                          style: const TextStyle(

                            fontSize: 35,

                            fontWeight: FontWeight.bold,

                            color: Color(0xff15317E),

                            height: .9,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Container(

                          padding:
                          const EdgeInsets.symmetric(

                            horizontal: 20,

                            vertical: 6,
                          ),

                          decoration: BoxDecoration(

                            color:
                            const Color(0xffFFD45E),

                            borderRadius:
                            BorderRadius.circular(
                                30),
                          ),

                          child: Text(

                            "$monthName ${selectedDate.year}",

                            style: const TextStyle(

                              fontWeight: FontWeight.bold,

                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Sun

          Positioned(

            top: 22,

            right: 32,

            child: Icon(

              Icons.wb_sunny_rounded,

              color: Colors.amber.shade700,

              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}