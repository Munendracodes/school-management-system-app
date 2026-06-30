import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:school_management_app/models/academic_year_response.dart';
import 'package:school_management_app/screens/academicyear/add_academicyear_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../models/active_academic_year_response.dart';
import '../../services/academic_year_service.dart';

class AcademicYearScreen extends StatefulWidget {
  final String accessToken;
  const AcademicYearScreen({
    super.key,
    required this.accessToken
  });

  @override
  State<AcademicYearScreen> createState() =>
      _AcademicYearScreenState();
}

class _AcademicYearScreenState
    extends State<AcademicYearScreen> {
  bool isLoading = true;

  List<AcademicYearData> academicYears = [];


  final List<Map<String, dynamic>> _academicYears = [

    {
      "name": "2026-2027",
      "startDate": "2026-06-01",
      "endDate": "2027-03-31",
      "createdAt": "2026-05-26",
      "isActive": true,
      "color": const Color(0xFF3B82F6),
    },

    {
      "name": "2025-2026",
      "startDate": "2025-06-01",
      "endDate": "2026-03-31",
      "createdAt": "2025-04-20",
      "isActive": false,
      "color": const Color(0xFF8B5CF6),
    },

    {
      "name": "2024-2025",
      "startDate": "2024-06-01",
      "endDate": "2025-03-31",
      "createdAt": "2024-04-15",
      "isActive": false,
      "color": const Color(0xFFF97316),
    },
  ];

  String formatDate(String date) {
    return DateFormat(
      "dd MMM yyyy",
    ).format(
      DateTime.parse(date),
    );
  }

  Future<void> loadAcademicYear() async {



    try {

      final response =
      await AcademicYearService
          .getAcademicYears(
        accessToken:
        widget.accessToken,
      );

      setState(() {

        academicYears = response.academicYears;

      });
      print("academic years are");
      print(academicYears);


      setState(() {

        isLoading = false;
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  void initState(){
    super.initState();
    loadAcademicYear();

  }

  @override
  Widget build(BuildContext context) {

   final activeYear =
       academicYears.isNotEmpty ? academicYears.firstWhere(
           (e) => e.isActive == true,
         orElse: ()=> academicYears.first
       ) : null;
    if(isLoading){
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F9FC),

      floatingActionButton:
      FloatingActionButton.extended(

        backgroundColor:
        AppColors.primaryBlue,

        onPressed: ()  async {
          HapticFeedback.lightImpact();
          final result = await
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_)=> AddAcademicyearScreen(
                  accessToken: widget.accessToken
                )
            )
          );
          if(result == true)
            await loadAcademicYear();
        },

        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        label: const Text(
          "Add Academic Year",
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
                          "Academic Years",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            AppColors.darkText,
                          ),
                        ),
                        Text(
                          "Manage academic years",

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
                                Icons.calendar_month_rounded,
                                color:
                                AppColors.primaryBlue,
                                size: 25,
                              ),
                            ),

                            const SizedBox(width: 15),

                            const Expanded(

                              child: Text(
                                "Academic Years Overview",
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
                                    "Total Academic Years",

                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(
                                    academicYears.length
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
                                    "Active Academic Year",

                                    style: TextStyle(
                                      color:
                                      Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Text(
                                    "${activeYear?.name
                                        .toString()}",

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
                          "All Academic Years",
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
                  ...academicYears.map(

                        (year) =>
                        _buildAcademicYearCard(
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

  Widget _buildAcademicYearCard(
      AcademicYearData year,
      ) {

    final bool isActive =
    year.isActive;

    return Container(

      margin:
      const EdgeInsets.only(bottom: 18),

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(28),

        border: Border.all(
          color: isActive
              ? const Color(0xFF4F8CFF)
              : const Color(0xFFE5E7EB),
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

              color:
              AppColors.primaryBlue.withOpacity(0.10),

              borderRadius:
              BorderRadius.circular(22),
            ),

            child: Icon(
              Icons.calendar_month_rounded,
              size: 30,
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
                        year.name,

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

                    Text(

                      isActive
                          ? "ACTIVE"
                          : "INACTIVE",

                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w700,

                        color: isActive
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Icon(
                      Icons.more_vert_rounded,
                      size: 20,
                      color:
                      Colors.grey,
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                _infoRow(
                  Icons.calendar_today_rounded,
                  "Start Date",
                  formatDate(
                    year.startdate,
                  ),
                ),

                const SizedBox(height: 10),

                _infoRow(
                  Icons.calendar_today_rounded,
                  "End Date",
                  formatDate(
                    year.enddate,
                  ),
                ),

              /*  const Divider(height: 30),

                _infoRow(
                  Icons.access_time_rounded,
                  "Created At",
                  formatDate(
                    year["createdAt"],
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