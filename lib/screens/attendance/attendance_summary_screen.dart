import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/models/student_info_response.dart';
import 'package:school_management_app/screens/attendance/mark_attendance_screen.dart';
import 'package:school_management_app/screens/attendance/view_attendance_screen.dart';
import 'package:intl/intl.dart';
import '../../models/active_academic_year_response.dart';
import '../../models/section_attendance.dart';
import '../../models/section_with_class.dart';
import '../../services/academic_year_service.dart';
import '../../services/firebase_attendance_service.dart';
import '../loading/app_loading_widget.dart';

class AttendanceSummaryScreen extends StatefulWidget {
  final String accessToken;
  const AttendanceSummaryScreen({
    super.key,
    required this.accessToken
  });

  @override
  State<AttendanceSummaryScreen> createState() => _AttendanceSummaryScreenState();
}

class _AttendanceSummaryScreenState extends State<AttendanceSummaryScreen> {

  String get attendanceDateLabel {

    final today = DateTime.now();

    final selected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final current = DateTime(
      today.year,
      today.month,
      today.day,
    );

    if (selected == current) {
      return "Today";
    }

    if (selected ==
        current.subtract(
          const Duration(days: 1),
        )) {
      return "Yesterday";
    }

    return DateFormat(
      "dd MMM yyyy",
    ).format(selectedDate);
  }

  DateTime selectedDate = DateTime.now();

  List classList =[];

  List<SectionWithClass> sectionList =[];

  int classesCovered = 0;

  List<ActiveAcademicYearResponse> academicYears = [];

  List<ClassroomData> classrooms = [];

  bool isLoading = true;

  String? selectedAcademicYear;

  List<SectionWithClass> get filteredSections {

    if (selectedClass == null ||
        selectedClass == "All Classes") {

      return sectionList;
    }

    return sectionList.where((section) {

      return section.className ==
          selectedClass;

    }).toList();
  }

  String? selectedClass = "All Classes";
  List<SectionAttendance> sections = [

    SectionAttendance(
      className: "Class 5",
      sectionName: "A",
      students: 35,
      fnCaptured: true,
      anCaptured: false,
      attendancePercentage: 94,
      presentCount: 33,
      teacherName: "Mr. Rajesh Sharma",
    ),

    SectionAttendance(
      className: "Class 5",
      sectionName: "B",
      students: 40,
      fnCaptured: true,
      anCaptured: true,
      attendancePercentage: 96,
      presentCount: 38,
      teacherName: "Mr. Priya Nair",
    ),
  ];



  Widget _buildHeader() {

    return Padding(

      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 5,
      ),

      child: Row(

        children: [

          Container(


            height: 40,
            width: 40,

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(
                  16),

              border: Border.all(
                color: const Color(
                    0xFFE4EAF7),
              ),
            ),

            child: IconButton(

              onPressed: () {

                Navigator.pop(context);
              },

              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
          const Expanded(

            child: Center(

              child: Text(

                "Attendance Summary",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  Color(0xFF081B5C),
                ),
              ),
            ),
          ),

          Container(

            height: 40,
            width: 40,

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(
                  16),

              border: Border.all(
                color: const Color(
                    0xFFE4EAF7),
              ),
            ),

            child: const Icon(
              Icons.calendar_month,
              color: Color(0xFF2457FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {

    return InkWell(

      onTap: _selectAttendanceDate,

      borderRadius:
      BorderRadius.circular(20),

      child: Container(

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(20),

          border: Border.all(
            color: const Color(0xFFE4EAF7),
          ),

          boxShadow: [

            BoxShadow(

              color: Colors.black.withOpacity(
                0.03,
              ),

              blurRadius: 10,

              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(

          children: [

            Container(

              padding:
              const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color:
                const Color(0xFFF4F6FF),

                borderRadius:
                BorderRadius.circular(
                  12,
                ),
              ),

              child: const Icon(

                Icons.calendar_month_rounded,

                color:
                Color(0xFF2457FF),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Attendance Date",

                    style: TextStyle(

                      fontSize: 12,

                      color:
                      Color(0xFF667085),
                    ),
                  ),

                  const SizedBox(height: 2),

              Text(
                attendanceDateLabel,


                    style: const TextStyle(

                      fontSize: 16,

                      fontWeight:
                      FontWeight.w700,

                      color:
                      Color(0xFF081B5C),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(

              Icons.keyboard_arrow_down_rounded,

              color:
              Color(0xFF667085),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateArrow(
      IconData icon,
      ) {

    return Container(

      height: 40,
      width: 40,

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Icon(icon),
    );
  }

  Widget _buildSummaryCards() {

    return GridView.count(

      crossAxisCount: 2,

      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      crossAxisSpacing: 12,

      mainAxisSpacing: 12,

      childAspectRatio: 1.5,

      children: [

        _buildSummaryCard(
          icon: Icons.groups_rounded,
          iconColor: const Color(0xFF2457FF),
          iconBg: const Color(0xFFF4F6FF),
          value: "420",
          title: "Total Students",
        ),

        _buildSummaryCard(
          icon: Icons.how_to_reg_rounded,
          iconColor: const Color(0xFF22C55E),
          iconBg: const Color(0xFFF0FDF4),
          value: "390",
          title: "Present",
        ),

        _buildSummaryCard(
          icon: Icons.person_remove_alt_1,
          iconColor: const Color(0xFFEF4444),
          iconBg: const Color(0xFFFEF2F2),
          value: "30",
          title: "Absent",
        ),

        _buildSummaryCard(
          icon: Icons.pie_chart_rounded,
          iconColor: const Color(0xFF9333EA),
          iconBg: const Color(0xFFF5F3FF),
          value: "92.8%",
          title: "Attendance %",
        ),
      ],
    );
  }
  Widget _buildSummaryCard({

    required IconData icon,

    required Color iconColor,

    required Color iconBg,

    required String value,

    required String title,
  }) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(
              0.03,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(

        children: [

          /// ICON
          Container(

            height: 35,
            width: 35,

            decoration: BoxDecoration(
              color: iconBg,
              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 12),

          /// TITLE + VALUE
          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                Text(

                  title,

                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF667085),
                    fontWeight:
                    FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  value,

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w700,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _buildSectionHeader() {

    return Row(

      children: [

        const Expanded(

          child: Text(

            "Class Sections",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ),

        DropdownButtonHideUnderline(

          child: DropdownButton<String>(

            value: selectedClass,

            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF2457FF),
            ),

            style: const TextStyle(
              fontSize: 16,
              fontWeight:
              FontWeight.w600,
              color:
              Color(0xFF2457FF),
            ),


            items: classList.map((className) {

    return DropdownMenuItem<String>(

    value: className,

    child: Text(className),
    );

    }).toList(),

            onChanged: (value) {

              setState(() {

                selectedClass = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
      SectionWithClass section,
      ) {

    return Container(

      padding:
      const EdgeInsets.all(18),
      margin: EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(
              0xFFE4EAF7),
        ),

        boxShadow: [

          BoxShadow(
            color:
            Colors.black.withOpacity(
              0.03,
            ),
            blurRadius: 10,
            offset:
            const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        children: [

          _buildSectionHeaderRow(
            section,
          ),

          const SizedBox(height: 10),

          _buildStatusCards(
            section,
          ),

     /*    const SizedBox(height: 18),

            _buildTeacherInfo(
            section,
          ),*/

         const SizedBox(height: 18),

          _buildAttendanceButton(
            section,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeaderRow(
      SectionWithClass section,
      ) {

    String status;

    Color statusColor;

    Color bgColor;

    if (section.fnCaptured &&
        section.anCaptured) {

      status = "Completed";

      statusColor =
      const Color(0xFF22C55E);

      bgColor =
      const Color(0xFFF0FDF4);

    } else if (section.fnCaptured ||
        section.anCaptured) {

      status = "Partial";

      statusColor =
      const Color(0xFFF59E0B);

      bgColor =
      const Color(0xFFFFFBEB);

    } else {

      status = "Pending";

      statusColor =
      const Color(0xFFEF4444);

      bgColor =
      const Color(0xFFFEF2F2);
    }

    return Row(

      children: [

        Expanded(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(

                "${section.className} - ${section.section.name}",

                style:
                const TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  Color(
                      0xFF081B5C),
                ),
              ),

     /*         const SizedBox(
                  height: 4),

              Text(

                "20 Students",

                style:
                const TextStyle(
                  color:
                  Color(
                      0xFF667085),
                ),
              ),*/
            ],
          ),
        ),

        Container(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),

          decoration: BoxDecoration(
            color: bgColor,
            borderRadius:
            BorderRadius.circular(
                20),
          ),

          child: Text(

            status,

            style: TextStyle(
              color: statusColor,
              fontWeight:
              FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCards(
      SectionWithClass section,
      ) {

    return Row(

      children: [

        Expanded(

          child: _buildSessionCard(

            title: "FN",

            isCaptured:
            section.fnCaptured,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(

          child: _buildSessionCard(

            title: "AN",

            isCaptured:
            section.anCaptured,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(

          child: _buildAttendanceCard(
            section,
          ),
        ),
      ],
    );
  }

  Widget _buildSessionCard({

    required String title,

    required bool isCaptured,
  }) {

    final bgColor = isCaptured
        ? const Color(0xFFF0FDF4)
        : const Color(0xFFFEF2F2);

    final iconColor = isCaptured
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);

    final text = isCaptured
        ? "Captured"
        : "Pending";

    return Container(

      padding:
      const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 10,
      ),

      decoration: BoxDecoration(

        color: bgColor,

        borderRadius:
        BorderRadius.circular(18),

        border: Border.all(
          color:
          bgColor.withOpacity(
              0.8),
        ),
      ),

      child: Column(

        children: [

          Row(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              Text(

                title,

                style:
                const TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  Color(
                      0xFF081B5C),
                ),
              ),

              const SizedBox(
                width: 8,
              ),

              Icon(

                isCaptured
                    ? Icons.check_circle
                    : Icons.cancel,

                color: iconColor,

                size: 22,
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          Text(

            text,

            style: TextStyle(

              color: iconColor,

              fontWeight:
              FontWeight.w700,

              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceInfo(
      SectionAttendance section,
      ) {

    return Container(

      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: const Color(0xFFF8FAFC),

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Column(

        children: [

          Row(

            children: [

              const Expanded(

                child: Text(

                  "Attendance",

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                    color:
                    Color(0xFF081B5C),
                  ),
                ),
              ),

              Text(

                "${section.attendancePercentage.toStringAsFixed(0)}%",

                style: const TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  Color(0xFF2457FF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(

            borderRadius:
            BorderRadius.circular(8),

            child:
            LinearProgressIndicator(

              value:
              section.attendancePercentage /
                  100,

              minHeight: 10,

              backgroundColor:
              const Color(
                  0xFFE5E7EB),

              valueColor:
              const AlwaysStoppedAnimation(
                Color(0xFF2457FF),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(

            children: [

              const Icon(
                Icons.how_to_reg_rounded,
                color:
                Color(0xFF22C55E),
                size: 18,
              ),

              const SizedBox(width: 6),

              Text(

                "${section.presentCount} Present",

                style:
                const TextStyle(
                  color:
                  Color(0xFF22C55E),
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const Spacer(),

              Text(

                "${section.students} Total",

                style:
                const TextStyle(
                  color:
                  Color(0xFF667085),
                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherInfo(
      SectionAttendance section,
      ) {

    return Container(

      padding:
      const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: const Color(0xFFF8FAFC),

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Row(

        children: [

          Container(

            height: 44,
            width: 44,

            decoration: BoxDecoration(

              color:
              const Color(0xFFF4F6FF),

              borderRadius:
              BorderRadius.circular(
                  12),
            ),

            child: const Icon(
              Icons.person,
              color:
              Color(0xFF2457FF),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const Text(

                  "Attendance Taken By",

                  style: TextStyle(
                    fontSize: 13,
                    color:
                    Color(0xFF667085),
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  section.teacherName,

                  style:
                  const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w700,
                    color:
                    Color(
                        0xFF081B5C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceButton(
      SectionWithClass section,
      ) {

    final bool attendanceCompleted =
        section.fnCaptured &&
            section.anCaptured;

    return SizedBox(

      width: double.infinity,

      height: 52,

      child: ElevatedButton(

        onPressed: () async {

          HapticFeedback.lightImpact();

          if (!attendanceCompleted) {

            final result =
            await Navigator.push(

              context,

              MaterialPageRoute(

                builder: (_) =>
                    MarkAttendanceScreen(

                      accessToken:
                      widget.accessToken,

                      section: section,

                      attendanceDate:
                      selectedDate,
                    ),
              ),
            );

            if (result == true) {

              setState(() {

                isLoading = true;
              });

              await loadAttendanceData();

              setState(() {

                isLoading = false;
              });
            }
            ScaffoldMessenger.of(context)
                .showSnackBar(

              SnackBar(

                content: Text(
                  "Attendance Saved Successfully for ${section.className} - ${section.section.name}",
                ),
              ),
            );
          }

          if (attendanceCompleted) {

            Navigator.push(

              context,

              MaterialPageRoute(

                builder: (_) =>
                    ViewAttendanceScreen(

                      accessToken:
                      widget.accessToken,

                      className:
                      section.className,

                      sectionName:
                      section.section.name,

                      attendanceDate:
                      selectedDate,
                      section: section,
                    ),
              ),
            );
          }
        },

        style: ElevatedButton.styleFrom(

          backgroundColor:
          attendanceCompleted
              ? const Color(
              0xFF22C55E)
              : const Color(
              0xFF2457FF),

          elevation: 0,

          shape:
          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(
                16),
          ),
        ),

        child: Row(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(

              attendanceCompleted
                  ? Icons.visibility
                  : Icons.edit_note,

              color: Colors.white,
            ),

            const SizedBox(width: 10),

            Text(

              attendanceCompleted
                  ? "View Attendance"
                  : "Mark Attendance",

              style: const TextStyle(
                fontSize: 16,
                fontWeight:
                FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner() {

    return Container(

      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color:
        const Color(0xFFF4F6FF),

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color:
          const Color(0xFFDCE7FF),
        ),
      ),

      child: Row(

        children: [

          Container(

            height: 42,
            width: 42,

            decoration: BoxDecoration(

              color:
              const Color(
                  0xFF2457FF),

              borderRadius:
              BorderRadius.circular(
                  12),
            ),

            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(

            child: Text(

              "Attendance percentage is calculated based on students marked present for the selected date.",

              style: TextStyle(
                fontSize: 13,
                color:
                Color(0xFF667085),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(
      SectionWithClass section,
      ) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),

      decoration: BoxDecoration(

        color: const Color(0xFFF4F6FF),

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Column(

        children: [

          const Text(

            "Attendance",

            style: TextStyle(
              fontSize: 12,
              fontWeight:
              FontWeight.w600,
              color:
              Color(0xFF667085),
            ),
          ),

          const SizedBox(height: 6),

          Text(

            "${section.attendancePercentage.toStringAsFixed(0)}%",

            style: const TextStyle(
              fontSize: 15,
              fontWeight:
              FontWeight.w700,
              color: Color(0xFF2457FF),
            ),
          ),

          const SizedBox(height: 3),

          Text(

            "${section.presentCount}/${section.totalStudents}",

            style: const TextStyle(
              fontSize: 12,
              fontWeight:
              FontWeight.w600,
              color: Color(0xFF667085),
            ),
          ),
        ],
      ),
    );
  }

  void initState(){
    super.initState();
    loadAcademicYear();
  }

  Future<void> loadAcademicYear() async {

    try {

      final response =
      await AcademicYearService
          .getActiveAcademicYear(

        accessToken:
        widget.accessToken,
      );

      setState(() {

        academicYears = [response];

        selectedAcademicYear = "2026-2027";

        classrooms = response.classrooms;

        classList = [

          "All Classes",

          ...response.classrooms
              .map((e) => e.name)
              .toList(),
        ];

        sectionList =
            academicYears
                .expand((academicYear) => academicYear.classrooms)
                .expand(
                  (classroom) => classroom.sections.map(
                    (section) => SectionWithClass(
                      className: classroom.name,
                      section: section,

                      fnCaptured: false,
                      anCaptured: false,

                      presentCount: 0,
                      totalStudents: 0,
                      partialCount: 0,
                      absentCount: 0,
                    ),
              ),
            )
                .toList();
        classesCovered = academicYears[0].classrooms.length;
        print(sectionList[0].className);
      });

      await loadAttendanceData();

      setState(() {

        isLoading = false;
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  Future<void> loadAttendanceData() async {

    /// RESET OLD DATA

    for (final section in sectionList) {

      section.fnCaptured = false;

      section.anCaptured = false;

      section.totalStudents = 0;

      section.presentCount = 0;

      section.partialCount = 0;

      section.absentCount = 0;
    }

    final service =
    FirebaseAttendanceService();

    for (final section
    in sectionList) {

      final attendance =
      await service.getAttendance(

        className:
        section.className,

        sectionName:
        section.section.name,

        date: selectedDate,
      );

      if (attendance != null) {

        section.fnCaptured =
            attendance.fnCaptured;

        section.anCaptured =
            attendance.anCaptured;

        section.totalStudents =
            attendance.totalStudents;

        section.presentCount =
            attendance.presentCount;

        section.partialCount =
            attendance.partialCount;

        section.absentCount =
            attendance.absentCount;
      }
    }

    setState(() {});
  }

  Future<void> _selectAttendanceDate() async {

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) return;

    setState(() {

      selectedDate = pickedDate;

      isLoading = true;
    });

    try {

      await loadAttendanceData();

    } catch (e) {

      debugPrint(
        "Date Change Error: $e",
      );

    } finally {

      if (mounted) {

        setState(() {

          isLoading = false;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      if (isLoading) {

        return const AppLoadingWidget(

          title:
          "Loading Attendance",

          subtitle:
          "Fetching class and attendance details...",
        );
      }
    }
    return Scaffold(

      body: SafeArea(

        child: Column(

          children: [

            _buildHeader(),


            Expanded(

              child: SingleChildScrollView(

                padding:
                const EdgeInsets.all(20),

                child: Column(

                  children: [

                    _buildDateSelector(),

                    const SizedBox(height: 10),

                    _buildSummaryCards(),

                    const SizedBox(height: 5),

                    _buildSectionHeader(),

                   const SizedBox(height: 5),

                    ...filteredSections.map(
                          (section) =>
                          _buildSectionCard(
                            section,
                          ),
                    ),

                    const SizedBox(height: 20),

                 //   _buildInfoBanner(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

