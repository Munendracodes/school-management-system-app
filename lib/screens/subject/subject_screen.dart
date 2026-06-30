import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:school_management_app/screens/subject/add_subject_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../models/subject_model.dart';
import '../../services/subject_service.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() =>
      _SubjectScreenState();
}

class _SubjectScreenState
    extends State<SubjectScreen> {

  List<SubjectModel> subjects = [];

  bool isLoading = true;

  String formatDate(String date) {
    return DateFormat(
      "dd MMM yyyy",
    ).format(
      DateTime.parse(date),
    );
  }

  @override
  void initState() {

    super.initState();

    loadSubjects();
  }
  Future<void> loadSubjects() async {

    try {

      final response =
      await SubjectService.getSubjects();

      setState(() {

        subjects = response;

        isLoading = false;

      });

    } catch (e) {

      setState(() {

        isLoading = false;

      });

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    const String academicYear = "2026-2027";

    if (isLoading) {

      return const Scaffold(

        body: Center(

          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F9FC),

      floatingActionButton:
      FloatingActionButton.extended(

        backgroundColor:
        AppColors.primaryBlue,

        onPressed: () async {
          HapticFeedback.lightImpact();
          final result = await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) => AddSubjectScreen(

                accessToken: "",

                academicYear: academicYear,
              ),
            ),
          );

          if (result == true) {

            loadSubjects();

            if (!mounted) return;

          }
        },

        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        label: const Text(
          "Add Subject",
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
                          "Subject",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            AppColors.darkText,
                          ),
                        ),
                        Text(
                          "Manage Subjects",

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
                                "Subject Overview",
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
                                    "Total Subjects",

                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(

                                    subjects

                                        .where((e) => e.isActive)

                                        .length

                                        .toString(),

                                    style: const TextStyle(

                                      color: Colors.white,

                                      fontSize: 15,

                                      fontWeight: FontWeight.bold,
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
                                    "Active Subjects",

                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(
                                    subjects.length.toString(),

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
                          "All Subjects",
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
                  ...subjects.map(

                        (subject) =>
                        __buildSubjectCard(
                          subject,
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

  Widget __buildSubjectCard(
      SubjectModel subject,
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
                        subject.name,

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
                if (subject.teachers.isEmpty)

                  Container(

                    padding: const EdgeInsets.symmetric(

                      horizontal: 12,

                      vertical: 6,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.orange.shade50,

                      borderRadius:
                      BorderRadius.circular(20),
                    ),

                    child: const Text(

                      "No Teachers Assigned",

                      style: TextStyle(

                        color: Colors.orange,

                        fontWeight: FontWeight.w700,

                        fontSize: 12,
                      ),
                    ),
                  ),
                /*     SizedBox(height: 5.0),
                _infoRow(
                  Icons.access_time_rounded,
                  "Created At",
                  formatDate(
                    section["createdAt"],
                  ),
                ),*/

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