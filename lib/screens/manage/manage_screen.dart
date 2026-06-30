import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/screens/academicyear/academic_year_screen.dart';
import 'package:school_management_app/screens/attendance/attendance_summary_screen.dart';
import 'package:school_management_app/screens/attendance/mark_attendance_screen.dart';
import 'package:school_management_app/screens/class/class_screen.dart';
import 'package:school_management_app/screens/exam/exam_screen.dart';
import 'package:school_management_app/screens/fees/fees_screen.dart';
import 'package:school_management_app/screens/parents/parents_screen.dart';
import 'package:school_management_app/screens/students/students_screen.dart';
import 'package:school_management_app/screens/teachers/teachers_screen.dart';
import '../../core/constants/app_colors.dart';
import '../section/section_screen.dart';
import '../subject/subject_screen.dart';


class ManageScreen extends StatelessWidget {

  final String accessToken;
  final Color backgroundColor;

  const ManageScreen({
    super.key,
    required this.accessToken,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {

    final academicItems = [
      ManageItem("Academic Year", Icons.calendar_month_rounded, const Color(0xFF8B5CF6)),
      ManageItem("Class", Icons.school_rounded, const Color(0xFF3B82F6)),
      ManageItem("Section", Icons.apartment_rounded, const Color(0xFF22C55E)),
      ManageItem("Subject", Icons.menu_book_rounded, const Color(0xFFF97316)),
      ManageItem("Exams", Icons.assignment_rounded, const Color(0xFFEC4899)),
    ];

    final peopleItems = [
      ManageItem("Students", Icons.person_rounded, const Color(0xFF3B82F6)),
      ManageItem("Teachers", Icons.co_present_rounded, const Color(0xFF22C55E)),
      ManageItem("Parents", Icons.family_restroom_rounded, const Color(0xFFF97316)),
      ManageItem("Roles", Icons.security_rounded, const Color(0xFF8B5CF6)),
    ];

    final operationItems = [
      ManageItem("Mark Attendance", Icons.check_circle_rounded, const Color(0xFF22C55E)),
      ManageItem("Fees", Icons.account_balance_wallet_rounded, const Color(0xFFF97316)),
      ManageItem("Transport", Icons.directions_bus_rounded, const Color(0xFF3B82F6)),
      ManageItem("Time Table", Icons.timelapse, const Color(0xFF8B5CF6)),
    ];

    final reportItems = [
      ManageItem("Attendance Report", Icons.bar_chart_rounded, const Color(0xFF22C55E)),
      ManageItem("Fee Report", Icons.credit_card_rounded, const Color(0xFFF97316)),
      ManageItem("Student Report", Icons.school_rounded, const Color(0xFF3B82F6)),
      ManageItem("Teacher Report", Icons.co_present_rounded, const Color(0xFF8B5CF6)),
    ];

    final inventoryItems = [
      ManageItem("Books", Icons.bar_chart_rounded, const Color(0xFF22C55E)),
      ManageItem("Uniform", Icons.credit_card_rounded, const Color(0xFFF97316))
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              /// HEADER
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// MENU
                  IconButton(

                    icon: const Icon(
                      Icons.person_2_rounded,
                      size: 30,
                      color: AppColors.primaryBlue,

                    ),

                    onPressed: () {

                      Scaffold.of(context)
                          .openDrawer();
                    },
                  ),



                  /// LOGO + SCHOOL
                  Expanded(
                    child: Row(
                      children: [

                        /// LOGO
                        /*   AppLogo(
                          size: width * 0.12,
                        ),*/

                        const SizedBox(width: 5),

                        /// SCHOOL NAME
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Sunshine Public School",

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,

                                color:
                                Color(0xFF081B5C),
                              ),
                            ),

                            Text(
                              "Admin Dashboard",

                              style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight.w500,

                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// NOTIFICATION
                  Stack(
                    children: [

                      const Padding(
                        padding:
                        EdgeInsets.only(top: 10),

                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 28,
                          color: Color(0xFF081B5C),
                        ),
                      ),

                      Positioned(
                        right: -1,
                        top: 1,

                        child: Container(
                          height: 22,
                          width: 22,

                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),

                          child: const Center(
                            child: Text(
                              "3",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _buildSection(
                title: "Academic Setup",
                icon: Icons.school_rounded,
                items: academicItems,
              ),

              _buildSection(
                title: "People Management",
                icon: Icons.people_rounded,
                items: peopleItems,
              ),

              _buildSection(
                title: "Operations",
                icon: Icons.settings_rounded,
                items: operationItems,
              ),
              _buildSection(
                title: "Inventory",
                icon: Icons.bar_chart_rounded,
                items: inventoryItems,
              ),

              _buildSection(
                title: "Reports",
                icon: Icons.bar_chart_rounded,
                items: reportItems,
              ),


              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<ManageItem> items,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(28),

        border: Border.all(
          color: const Color(0xFFE9EEF9),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        children: [

          Row(
            children: [

            /*  Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: const Color(0xFFF4F3FF),
                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Icon(
                  icon,
                  color: AppColors.primaryBlue,
                ),
              ),*/

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
              ),

              Text(
                "${items.length} Items",
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.primaryBlue,
              ),
            ],
          ),

          const SizedBox(height: 18),

          GridView.builder(
            shrinkWrap: true,

            physics:
            const NeverScrollableScrollPhysics(),

            itemCount: items.length,

            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2,
            ),

            itemBuilder: (context, index) {
              return _buildMenuCard(items[index],context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
      ManageItem item,
      BuildContext context
      ) {
    return InkWell(

      borderRadius:
      BorderRadius.circular(20),

      onTap: () async{
        /// HAPTIC FEEDBACK
        await HapticFeedback.lightImpact();
        if(item.title == "Academic Year")
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                AcademicYearScreen(accessToken: accessToken,

                ),
          ),
        );
        if(item.title == "Class")
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ClassScreen(
                      accessToken: accessToken, backgroundColor: backgroundColor
                  ),
            ),
          );
        if(item.title == "Section")
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  SectionScreen(
                      accessToken: accessToken, backgroundColor: backgroundColor
                  ),
            ),
          );
        if(item.title == "Subject")
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  SubjectScreen(
                  ),
            ),
          );
        if(item.title == "Exams")
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ExamScreen()
            ),
          );
        if(item.title == "Students")
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    StudentsScreen(accessToken: accessToken, backgroundColor: backgroundColor)
            ),
          );
        if(item.title == "Teachers")
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    TeachersScreen(accessToken: accessToken, backgroundColor: backgroundColor)
            ),
          );
        if(item.title == "Parents")
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ParentsScreen(accessToken: accessToken, backgroundColor: backgroundColor)
            ),
          );
        if(item.title == "Mark Attendance")
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                   AttendanceSummaryScreen(
                     accessToken: accessToken,
                   )
            ),
          );
        if(item.title == "Fees")
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    FeesScreen(
                      accessToken: accessToken,
                      backgroundColor: backgroundColor,

                    )
            ),
          );
      },

      child: Container(

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: item.color.withOpacity(0.06),

          borderRadius:
          BorderRadius.circular(20),
        ),

        child: Row(
          children: [

            Icon(
              item.icon,
              color: item.color,
            ),

            const SizedBox(width: 7),

            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class ManageItem {

  final String title;
  final IconData icon;
  final Color color;

  ManageItem(
      this.title,
      this.icon,
      this.color,
      );
}

