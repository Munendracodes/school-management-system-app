import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:school_management_app/models/homework_model.dart';
import 'package:school_management_app/screens/homework/add_homework_screen.dart';
import 'package:school_management_app/screens/section/add_section_screen.dart';
import 'package:school_management_app/screens/section/section_info_screen.dart';
import 'package:school_management_app/services/homework_service.dart';

import '../../core/constants/app_colors.dart';
import '../../models/active_academic_year_response.dart';
import '../../models/section_with_class.dart';
import '../../services/academic_year_service.dart';
import '../../widgets/homework_date_selector.dart';

class HomeWorkScreen extends StatefulWidget {

  final String accessToken;
  final Color backgroundColor;
  final String className;
  final String sectionName;



  const HomeWorkScreen({
    super.key,
    required this.accessToken,
    required this.backgroundColor,
    required this.className,
    required this.sectionName
  });

  @override
  State<HomeWorkScreen> createState() =>
      _HomeWorkScreenState();
}

class _HomeWorkScreenState
    extends State<HomeWorkScreen> {


  bool isLoading = true;

  ActiveAcademicYearResponse? activeAcademicYear;

  DateTime selectedDate = DateTime.now();

  List<HomeworkModel> homeworkList=[];

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
    loadActiveAcademicYear();

  }

  Future<void> getHomeWorks() async {

    try {

      final response =
      await HomeworkService().getHomeworks(

        academicYearId:
        activeAcademicYear!.id,

        date: selectedDate, classId: widget.className, sectionId: widget.sectionName,
      );

      if (!mounted) return;

      setState(() {

        homeworkList = response;

        isLoading = false;
      });

    } catch (e) {

      if (!mounted) return;

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

  Future<void> loadActiveAcademicYear() async {

    try {

      final response =
      await AcademicYearService.getActiveAcademicYear(

        accessToken: widget.accessToken,
      );

      activeAcademicYear = response;

      await getHomeWorks();

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
                  builder: (_) => AddHomeworkScreen(accessToken: widget.accessToken,
                  className: widget.className,
                    sectionName: widget.sectionName,
                  )
              )
          );

          if (result == true) {
            getHomeWorks();
          }


        },

        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),



        label: const Text(
          "Add Home work",
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
                          "Home Work",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            AppColors.darkText,
                          ),
                        ),
                        Text(
                          "Assign and Review Homework",

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

                            Expanded(

                              child: Text(
                                "${widget.className} - ${widget.sectionName}",
                                style: const TextStyle(
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
                                    "Assigned",

                                    style: TextStyle(
                                      fontSize: 15,
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(
                                    homeworkList.length
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
                                    "Submitted",

                                    style: TextStyle(
                                      fontSize: 15,
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(

                                    homeworkList.fold(

                                      0,

                                          (sum, homework) =>

                                      sum + homework.submittedStudents,

                                    ).toString(),

                                    style: const TextStyle(

                                      color: Colors.white,

                                      fontSize: 15,

                                      fontWeight: FontWeight.bold,
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

                  HomeworkDateSelector(

                    selectedColor: AppColors.darkText,

                    selectedDate: selectedDate,

                    onPrevious: () {

                      setState(() {

                        selectedDate = selectedDate.subtract(

                          const Duration(days: 1),
                        );
                      });

                      getHomeWorks();
                    },

                    onNext: () {

                      setState(() {

                        selectedDate = selectedDate.add(

                          const Duration(days: 1),
                        );
                      });

                      getHomeWorks();
                    },

                    onPickDate: () async {

                      final picked = await showDatePicker(

                        context: context,

                        initialDate: selectedDate,

                        firstDate: DateTime(2025),

                        lastDate: DateTime(2035),
                      );

                      if (picked == null) return;

                      setState(() {

                        selectedDate = picked;

                      });

                      getHomeWorks();
                    },
                  ),

                  /// TITLE
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "All Home works",
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
                  if (homeworkList.isEmpty)

                    Container(

                      margin: const EdgeInsets.only(

                        top: 0,
                      ),

                      padding: const EdgeInsets.all(30),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(28),

                        border: Border.all(

                          color: const Color(0xFFE4E7EC),
                        ),
                      ),

                      child: Column(

                        children: [

                          Icon(

                            Icons.menu_book_outlined,

                            size: 70,

                            color: Colors.grey.shade400,
                          ),

                          const SizedBox(height: 20),

                          const Text(

                            "No Homework Added",

                            style: TextStyle(

                              fontSize: 20,

                              fontWeight: FontWeight.bold,

                              color: AppColors.darkText,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(

                            "Tap the Add Homework button below\n"
                                "to assign homework to students.",

                            textAlign: TextAlign.center,

                            style: TextStyle(

                              color: AppColors.lightText,

                              height: 1.5,
                            ),
                          ),


                        ],
                      ),
                    )

                  else

                    ...homeworkList.map(

                          (homework) =>

                          _buildHomeworkCard(homework),

                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkCard(
      HomeworkModel homework) {

    final bool isActive =false;

    return InkWell(
      onTap: (){
        HapticFeedback.lightImpact();
      },
      child: Container(

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
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Row(

                    children: [

                      Text(
                        homework.subjectName,

                        style:
                        const TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          AppColors.darkText,
                        ),
                      ),

                      Spacer(),
                      const Icon(
                        Icons.more_vert_rounded,
                        size: 20,
                        color:
                        Colors.grey,
                      ),

                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    homework.title,

                    style:
                    const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.normal,
                      color:
                      AppColors.darkText,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    homework.description,

                    style:
                    const TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.normal,
                      color:
                      AppColors.darkText,
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