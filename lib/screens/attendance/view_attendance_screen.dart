import 'package:flutter/material.dart';
import 'package:school_management_app/core/constants/app_colors.dart';
import 'package:school_management_app/screens/attendance/mark_attendance_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../models/attenndace_student.dart';
import '../../models/section_with_class.dart';
import '../../services/firebase_attendance_service.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String accessToken;
  final String className;
  final String sectionName;
  final DateTime attendanceDate;
  final SectionWithClass section;

  const ViewAttendanceScreen({
    super.key,
    required this.accessToken,
    required this.className,
    required this.sectionName,
    required this.attendanceDate,
    required this.section
  });

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {

  bool notificationSent = false;

  List<AttendanceStudent> presentStudents = [];

  List<AttendanceStudent> partialStudents = [];

  List<AttendanceStudent> absentStudents = [];

  int selectedTab = 0;

  bool isLoading = true;

  int totalStudents = 0;

  int presentCount = 0;

  int partialCount = 0;

  int absentCount = 0;

  double attendancePercentage = 0;

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

                "View Attendance",

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

          PopupMenuButton<String>(

            icon: Icon(
              Icons.more_vert,
              color: AppColors.primaryBlue,
            ),

            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(16),
            ),

            onSelected: (value) {

              if (value == "edit") {

                /// Navigate to Edit Attendance Screen

                 Navigator.push(context,
                 MaterialPageRoute(
                     builder: (_) => MarkAttendanceScreen(
                         accessToken: widget.accessToken,
                         section: widget.section,
                         attendanceDate: widget.attendanceDate)
                 )
                 );
              }

              if (value == "share") {

                /// Future Enhancement
                /// Share Attendance Report
              }
            },

            itemBuilder: (context) => [

              const PopupMenuItem(

                value: "edit",

                child: Row(

                  children: [

                    Icon(
                      Icons.edit_rounded,
                      color: Color(0xFF2457FF),
                    ),

                    SizedBox(width: 10),

                    Text(
                      "Edit Attendance",
                    ),
                  ],
                ),
              ),

              const PopupMenuItem(

                value: "share",

                child: Row(

                  children: [

                    Icon(
                      Icons.share_rounded,
                      color: Color(0xFF22C55E),
                    ),

                    SizedBox(width: 10),

                    Text(
                      "Share Report",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassInfoCard() {

    return Container(

      padding: const EdgeInsets.all(18),

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

      child: Row(

        children: [

          Container(

            height: 60,
            width: 60,

            decoration: BoxDecoration(

              color:
              const Color(
                  0xFFF4F6FF),

              borderRadius:
              BorderRadius.circular(
                  18),
            ),

            child: const Icon(

              Icons.school_rounded,

              size: 30,

              color:
              Color(0xFF2457FF),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  "${widget.className} - ${widget.sectionName}",

                  style:
                  const TextStyle(

                    fontSize: 18,

                    fontWeight:
                    FontWeight.w700,

                    color:
                    Color(
                        0xFF081B5C),
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                const Text(

                  "22-06-2024",

                  style: TextStyle(
                    color:
                    Color(
                        0xFF667085),
                  ),
                ),

              ],
            ),
          ),

          Container(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),

            decoration: BoxDecoration(

              color:
              const Color(
                  0xFFF0FDF4),

              borderRadius:
              BorderRadius.circular(
                  20),
            ),

            child: const Text(

              "Captured",

              style: TextStyle(
                fontSize: 14,

                color:
                Color(
                    0xFF22C55E),

                fontWeight:
                FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {

    return GridView.count(

      crossAxisCount: 4,

      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      mainAxisSpacing: 5,

      crossAxisSpacing: 5,

      childAspectRatio: 0.5,

      children: [

        _buildSummaryCard(

          icon: Icons.groups_rounded,

          iconColor:
          const Color(0xFF2457FF),

          iconBg:
          const Color(0xFFF4F6FF),

          title: "Total",

          value: totalStudents.toString(),
        ),

        _buildSummaryCard(

          icon:
          Icons.how_to_reg_rounded,

          iconColor:
          const Color(0xFF22C55E),

          iconBg:
          const Color(0xFFF0FDF4),

          title: "Present",

          value: presentCount.toString(),
        ),

        _buildSummaryCard(

          icon:
          Icons.schedule_rounded,

          iconColor:
          const Color(0xFFF97316),

          iconBg:
          const Color(0xFFFFF7ED),

          title: "Partial",

          value: partialCount.toString(),
        ),

        _buildSummaryCard(

          icon:
          Icons.person_off_rounded,

          iconColor:
          const Color(0xFFEF4444),

          iconBg:
          const Color(0xFFFEF2F2),

          title: "Absent",

          value: absentCount.toString(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({

    required IconData icon,

    required Color iconColor,

    required Color iconBg,

    required String title,

    required String value,
  }) {

    return Container(

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(
              0xFFE4EAF7),
        ),
      ),

      child: Column(

        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Container(

            height: 42,
            width: 42,

            decoration: BoxDecoration(

              color: iconBg,

              borderRadius:
              BorderRadius.circular(
                  14),
            ),

            child: Icon(

              icon,

              color: iconColor,

              size: 22,
            ),
          ),

          const SizedBox(height: 10),

          Text(

            value,

            style: TextStyle(

              fontSize: 24,

              fontWeight:
              FontWeight.w700,

              color: iconColor,
            ),
          ),

          const SizedBox(height: 4),

          Text(

            title,

            textAlign:
            TextAlign.center,

            style: const TextStyle(

              fontSize: 13,

              color:
              Color(0xFF667085),

              fontWeight:
              FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallAttendance() {

    final percentage =
        attendancePercentage;

    return Container(

      width: double.infinity,

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(

        gradient:
        const LinearGradient(

          colors: [

            Color(0xFF7C3AED),
            Color(0xFF9333EA),
          ],

          begin: Alignment.topLeft,

          end:
          Alignment.bottomRight,
        ),

        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          const Text(

            "Overall Attendance",

            style: TextStyle(

              fontSize: 16,

              color: Colors.white70,

              fontWeight:
              FontWeight.w500,
            ),
          ),
       SizedBox(width: 10),
       Column(
         children: [

           Text(

             "${percentage.toStringAsFixed(1)}%",

             style: const TextStyle(

               fontSize: 25,

               fontWeight:
               FontWeight.w700,

               color: Colors.white,
             ),
           ),
         ],
       )
        ],
      ),
    );
  }

  Widget _buildAttendanceTabs() {

    return Container(

      padding: const EdgeInsets.all(4),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Row(

        children: [

          _buildTabItem(
            index: 0,
            title: "Present",
            count: presentCount,
            color: const Color(0xFF22C55E),
          ),

          _buildTabItem(
            index: 1,
            title: "Partial",
            count: partialCount,
            color: const Color(0xFFF97316),
          ),

          _buildTabItem(
            index: 2,
            title: "Absent",
            count: absentCount,
            color: const Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({

    required int index,

    required String title,

    required int count,

    required Color color,
  }) {

    final isSelected =
        selectedTab == index;

    return Expanded(

      child: GestureDetector(

        onTap: () {

          setState(() {

            selectedTab = index;
          });
        },

        child: AnimatedContainer(

          duration:
          const Duration(
            milliseconds: 250,
          ),

          padding:
          const EdgeInsets.symmetric(
            vertical: 12,
          ),

          decoration: BoxDecoration(

            color: isSelected
                ? color
                : Colors.transparent,

            borderRadius:
            BorderRadius.circular(
                16),
          ),

          child: Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              Text(

                count.toString(),

                style: TextStyle(

                  fontSize: 18,

                  fontWeight:
                  FontWeight.w700,

                  color: isSelected
                      ? Colors.white
                      : color,
                ),
              ),

              const SizedBox(height: 4),

              Text(

                title,

                style: TextStyle(

                  fontSize: 12,

                  fontWeight:
                  FontWeight.w600,

                  color: isSelected
                      ? Colors.white
                      : const Color(
                      0xFF667085),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentList() {

    List<AttendanceStudent> students = [];

    if (selectedTab == 0) {

      students = presentStudents;

    } else if (selectedTab == 1) {

      students = partialStudents;

    } else {

      students = absentStudents;
    }

    return Column(

      children: students.map((student) {

        return Padding(

          padding:
          const EdgeInsets.only(
            bottom: 12,
          ),

          child: _buildStudentCard(
            student,
          ),
        );

      }).toList(),
    );
  }

  Widget _buildStudentCard(
      AttendanceStudent student,
      ) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Column(

        children: [

          Row(

            children: [

              CircleAvatar(

                radius: 24,

                backgroundColor:
                const Color(
                    0xFFF4F6FF),

                child: Text(

                  student.name
                      .substring(0, 1),

                  style:
                  const TextStyle(

                    fontSize: 18,

                    fontWeight:
                    FontWeight.w700,

                    color:
                    Color(
                        0xFF2457FF),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [

                    Text(

                      student.name,

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
                      height: 4,
                    ),

                  /*  Text(

                      "Roll No : ${student.rollNo}",

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

              _buildAttendanceBadge(
                student,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(

            children: [

              Expanded(

                child:
                _buildSessionStatus(

                  title: "FN",

                  isPresent:
                  student.fnPresent,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(

                child:
                _buildSessionStatus(

                  title: "AN",

                  isPresent:
                  student.anPresent,
                ),
              ),
            ],
          ),

    if (selectedTab == 1 ||
    selectedTab == 2) ...[

            const SizedBox(height: 14),

            _buildNotifyParentButton(
              student,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAttendanceBadge(
      AttendanceStudent student,
      ) {

    final isPresent =
        student.fnPresent &&
            student.anPresent;

    final isAbsent =
        !student.fnPresent &&
            !student.anPresent;

    String text;
    Color color;

    if (isPresent) {

      text = "Present";
      color = const Color(0xFF22C55E);

    } else if (isAbsent) {

      text = "Absent";
      color = const Color(0xFFEF4444);

    } else {

      text = "Partial";
      color = const Color(0xFFF97316);
    }

    return Container(

      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(

        color: color.withOpacity(
          0.12,
        ),

        borderRadius:
        BorderRadius.circular(
            20),
      ),

      child: Text(

        text,

        style: TextStyle(

          color: color,

          fontWeight:
          FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSessionStatus({

    required String title,

    required bool isPresent,
  }) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        vertical: 12,
      ),

      decoration: BoxDecoration(

        color: isPresent
            ? const Color(
            0xFFF0FDF4)
            : const Color(
            0xFFFEF2F2),

        borderRadius:
        BorderRadius.circular(
            16),
      ),

      child: Column(

        children: [

          Text(

            title,

            style: const TextStyle(

              fontWeight:
              FontWeight.w700,

              color:
              Color(0xFF081B5C),
            ),
          ),

          const SizedBox(height: 6),

          Icon(

            isPresent
                ? Icons.check_circle
                : Icons.cancel,

            color: isPresent
                ? const Color(
                0xFF22C55E)
                : const Color(
                0xFFEF4444),
          ),

          const SizedBox(height: 4),

          Text(

            isPresent
                ? "Present"
                : "Absent",

            style: TextStyle(

              color: isPresent
                  ? const Color(
                  0xFF22C55E)
                  : const Color(
                  0xFFEF4444),

              fontWeight:
              FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifyParentButton(
      AttendanceStudent student,
      ) {

    if (student.notificationSent) {

      return Container(

        width: double.infinity,

        padding:
        const EdgeInsets.symmetric(
          vertical: 12,
        ),

        decoration: BoxDecoration(

          color:
          const Color(0xFFF0FDF4),

          borderRadius:
          BorderRadius.circular(
              16),
        ),

        child: const Row(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.check_circle,
              color:
              Color(0xFF22C55E),
            ),

            SizedBox(width: 8),

            Text(

              "Parent Notified",

              style: TextStyle(

                color:
                Color(0xFF22C55E),

                fontWeight:
                FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(

      width: double.infinity,

      child: ElevatedButton.icon(

        onPressed: () {

          _notifyParent(student);
        },

        icon: const Icon(
          Icons.message,
        ),

        label: const Text(
          "Notify Parent",
        ),

        style:
        ElevatedButton.styleFrom(

          backgroundColor:
          const Color(
              0xFF25D366),

          foregroundColor:
          Colors.white,

          shape:
          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(
                16),
          ),
        ),
      ),
    );
  }
  Future<void> _notifyParent(
      AttendanceStudent student,
      ) async {

    final phone =
        student.parentMobile;

    final message =
    _buildAttendanceMessage(
      student,
    );

    final Uri whatsappUri =
    Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    try {

      await launchUrl(

        whatsappUri,

        mode:
        LaunchMode.externalApplication,
      );

      _showNotificationDialog(
        student,
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(
            "Unable to open WhatsApp",
          ),
        ),
      );
    }
  }

  void _showNotificationDialog(
      AttendanceStudent student,
      ) {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            "Notification Sent?",
          ),

          content: Text(
            "Was WhatsApp message sent to ${student.name}'s parent?",
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                "No",
              ),
            ),

            ElevatedButton(

              onPressed: () {

                setState(() {

                  student.notificationSent =
                  true;
                });

                Navigator.pop(
                  context,
                );

                /// Call API Here
              },

              child: const Text(
                "Yes",
              ),
            ),
          ],
        );
      },
    );
  }

  String _buildAttendanceMessage(
      AttendanceStudent student,
      ) {

    String attendanceInfo;

    if (!student.fnPresent &&
        !student.anPresent) {

      attendanceInfo =
      "was absent for the entire day.";

    } else if (!student.fnPresent &&
        student.anPresent) {

      attendanceInfo =
      "was absent during the Forenoon session.";

    } else if (student.fnPresent &&
        !student.anPresent) {

      attendanceInfo =
      "was absent during the Afternoon session.";

    } else {

      attendanceInfo =
      "was present today.";
    }

    return """

Dear Parent,

This is to inform you that your child ${student.name}
(Class ${widget.className}-${widget.sectionName})

$attendanceInfo

Date : ${DateFormat('dd MMM yyyy').format(widget.attendanceDate)}

If you have any questions, please contact the school administration.

Thank You.
""";
  }

  Widget _buildAttendanceInsights() {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Text(

            "Attendance Insights",

            style: TextStyle(

              fontSize: 18,

              fontWeight:
              FontWeight.w700,

              color:
              Color(0xFF081B5C),
            ),
          ),

          const SizedBox(height: 16),

          _buildInsightRow(

            color: const Color(0xFF22C55E),

            title: "Full Present",

            count: presentCount,
          ),

          const SizedBox(height: 12),

          _buildInsightRow(

            color: const Color(0xFFF97316),

            title: "Partial Attendance",

            count: partialCount,
          ),

          const SizedBox(height: 12),

          _buildInsightRow(

            color: const Color(0xFFEF4444),

            title: "Full Day Absent",

            count: absentCount,
          ),

          const Divider(height: 24),

          _buildInsightRow(

            color: const Color(0xFF2457FF),

            title: "Parents Notified",

            count: absentStudents
                .where(
                  (e) =>
              e.notificationSent,
            )
                .length,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightRow({

    required Color color,

    required String title,

    required int count,
  }) {

    return Row(

      children: [

        Container(

          height: 12,
          width: 12,

          decoration: BoxDecoration(

            color: color,

            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(

          child: Text(

            title,

            style: const TextStyle(

              fontSize: 15,

              color:
              Color(0xFF667085),
            ),
          ),
        ),

        Text(

          count.toString(),

          style: TextStyle(

            fontSize: 18,

            fontWeight:
            FontWeight.w700,

            color: color,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {

    super.initState();

    loadAttendance();
  }

  Future<void> loadAttendance() async {

    try {

      setState(() {

        isLoading = true;
      });

      final attendance =
      await FirebaseAttendanceService()
          .getAttendance(

        className:
        widget.className,

        sectionName:
        widget.sectionName,

        date:
        widget.attendanceDate,
      );

      final studentsMap =
      await FirebaseAttendanceService()
          .getAttendanceStudents(

        className:
        widget.className,

        sectionName:
        widget.sectionName,

        attendanceDate:
        widget.attendanceDate,
      );

      if (attendance == null ||
          studentsMap == null) {

        setState(() {

          isLoading = false;
        });

        return;
      }

      presentStudents.clear();

      partialStudents.clear();

      absentStudents.clear();

      totalStudents =
          attendance.totalStudents;

      presentCount =
          attendance.presentCount;

      partialCount =
          attendance.partialCount;

      absentCount =
          attendance.absentCount;

      attendancePercentage =
      totalStudents == 0

          ? 0

          : ((presentCount +
          (partialCount * 0.5))
          / totalStudents) * 100;

      studentsMap.forEach(

            (key, value) {

          final student =
          AttendanceStudent(

            name:
            value["studentName"] ?? "",

            rollNo:
            key,

            fnPresent:
            value["fnPresent"] ?? false,

            anPresent:
            value["anPresent"] ?? false,

            parentMobile:
            value["mobileNumber"] ?? "",
          );

          final isPresent =
              student.fnPresent &&
                  student.anPresent;

          final isAbsent =
              !student.fnPresent &&
                  !student.anPresent;

          if (isPresent) {

            presentStudents
                .add(student);
          }

          else if (isAbsent) {

            absentStudents
                .add(student);
          }

          else {

            partialStudents
                .add(student);
          }
        },
      );

      setState(() {

        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {

        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF8FAFC),

      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            _buildHeader(),



            Expanded(

              child: SingleChildScrollView(

                padding:
                const EdgeInsets.all(
                  10,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(

                      "${widget.className} - ${widget.sectionName} (${DateFormat( "dd MMM yyyy").format(widget.attendanceDate)})",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w700,
                        color:
                        Color(0xFF081B5C),
                      ),
                    ),
                SizedBox(height: 10),

                //    _buildClassInfoCard(),
                    _buildSummaryCards(),

                    const SizedBox(
                      height: 16,
                    ),

                    _buildOverallAttendance(),

                    const SizedBox(
                      height: 16,
                    ),

                    _buildAttendanceTabs(),

                    const SizedBox(
                      height: 16,
                    ),

                    _buildStudentList(),



                    _buildAttendanceInsights(),

                    const SizedBox(
                      height: 100,
                    ),
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
