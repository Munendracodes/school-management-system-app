import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_colors.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() =>
      _ExamScreenState();
}

class _ExamScreenState
    extends State<ExamScreen> {

  final List<Map<String, dynamic>> exams = [

    {
      "name": "Unit Test 1",
      "className": "Class 1 - Class 10",
      "startDate": "2026-05-01",
      "endDate": "2026-05-20",
      "createdAt": "2026-05-26",
    },

    {
      "name": "Quarterly",
      "className": "Class 1 - Class 10",
      "startDate": "2026-05-01",
      "endDate": "2026-05-20",
      "createdAt": "2026-05-26",
    },

    {
      "name": "Half Yearly",
      "className": "Class 1 - Class 10",
      "startDate": "2026-05-01",
      "endDate": "2026-05-20",
      "createdAt": "2026-05-26",
    },
    {
      "name": "Annually",
      "className": "Class 1 - Class 10",
      "startDate": "2026-05-01",
      "endDate": "2026-05-20",
      "createdAt": "2026-05-26",
    },
  ];

  String formatDate(String date) {
    return DateFormat(
      "dd MMM yyyy",
    ).format(
      DateTime.parse(date),
    );
  }

  @override
  Widget build(BuildContext context) {

    const String academicYear = "2026-2027";

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F9FC),

      floatingActionButton:
      FloatingActionButton.extended(

        backgroundColor:
        AppColors.primaryBlue,

        onPressed: () {

          /// TODO:
          /// Navigate Add Section Screen
        },

        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        label: const Text(
          "Add Exam",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(

        child: Column(

          children: [

            /// HEADER
            Padding(

              padding:
              const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                10,
              ),

              child: Row(

                children: [

                  InkWell(

                    borderRadius:
                    BorderRadius.circular(18),

                    onTap: () {

                      Navigator.pop(context);
                    },

                    child: Container(

                      padding:
                      const EdgeInsets.all(10),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(18),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primaryBlue,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: const [

                        Text(
                          "Examination",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            AppColors.darkText,
                          ),
                        ),
                        Text(
                          "Manage Examinations",

                          style: TextStyle(
                            color:
                            AppColors.lightText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 45,
                    width: 45,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE4E7EC),
                      ),
                    ),

                    child: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(

              child: ListView(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                children: [

                  /// OVERVIEW CARD
                  Container(

                    padding:
                    const EdgeInsets.all(20),

                    decoration: BoxDecoration(

                      gradient:
                      const LinearGradient(

                        colors: [
                          Color(0xFF4F8CFF),
                          Color(0xFF2457FF),
                        ],
                      ),

                      borderRadius:
                      BorderRadius.circular(28),
                    ),

                    child: Column(

                      children: [

                        Row(

                          children: [

                            Container(

                              padding:
                              const EdgeInsets.all(10),

                              decoration:
                              BoxDecoration(
                                color: Colors.white,

                                borderRadius:
                                BorderRadius.circular(
                                  20,
                                ),
                              ),

                              child: const Icon(
                                Icons.menu_book_rounded,
                                color:
                                AppColors.primaryBlue,
                                size: 25,
                              ),
                            ),

                            const SizedBox(width: 15),

                            const Expanded(

                              child: Text(
                                "Exams Overview",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(

                          children: [

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  const Text(
                                    "Total Exams",

                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(
                                    exams.length
                                        .toString(),

                                    style:
                                    const TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: 1,
                              height: 60,
                              color:
                              Colors.white24,
                            ),

                            const SizedBox(width: 20),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  const Text(
                                    "Classes Covered",

                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(
                                    exams.length.toString(),

                                    style:
                                    const TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  /// TITLE
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "All Exams",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            AppColors.darkText,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.swap_vert_rounded,
                        ),
                        label:
                        const Text("Latest First"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  /// LIST
                  ...exams.map(

                        (year) =>
                        _buildExamCard(
                          year,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(
      Map<String, dynamic> section,
      ) {

    final bool isActive =false;

    return Container(

      margin:
      const EdgeInsets.only(bottom: 10),

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(28),

        border: Border.all(
            color: const Color(0xFFE5E7EB)
        ),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(

        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [

          Container(

            height: 50,
            width: 50,

            decoration: BoxDecoration(

              color: AppColors.blueCard,

              borderRadius:
              BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.menu_book_rounded,
              size: 28,
              color: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Row(

                  children: [

                    Expanded(

                      child: Text(
                        section["name"],

                        style:
                        const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          AppColors.darkText,
                        ),
                      ),
                    ),


                    const Icon(
                      Icons.more_vert_rounded,
                      size: 20,
                      color:
                      Colors.grey,
                    ),

                  ],
                ),
                SizedBox(height: 10.0),
              /*  Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greenCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    section["className"],
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),*/
                SizedBox(height: 10.0),
                _infoRow(
                  Icons.access_time_rounded,
                  "Start Date",
                  formatDate(
                    section["startDate"],
                  ),
                ),
                SizedBox(height: 10.0),
                _infoRow(
                  Icons.access_time_rounded,
                  "End Date",
                  formatDate(
                    section["endDate"],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
      IconData icon,
      String label,
      String value,
      ) {

    return Row(

      children: [

        Icon(
          icon,
          size: 18,
          color:
          AppColors.primaryBlue,
        ),

        const SizedBox(width: 10),

        SizedBox(
          width: 85,
          child: Text(
            "$label :",
            style: const TextStyle(
              color:
              AppColors.lightText,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight:
              FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}