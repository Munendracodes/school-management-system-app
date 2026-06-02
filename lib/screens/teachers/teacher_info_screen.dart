import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../models/teacher_info_response.dart';
import '../../services/teachers_service.dart';


class TeacherInfoScreen extends StatefulWidget {

  final String accessToken;
  final String teacherId;

  const TeacherInfoScreen({
    super.key,
    required this.accessToken,
    required this.teacherId,
  });

  @override
  State<TeacherInfoScreen> createState() =>
      _TeacherInfoScreenState();
}

class _TeacherInfoScreenState
    extends State<TeacherInfoScreen> {

  bool isLoading = true;

  TeacherInfoResponse? teacher;

  @override
  void initState() {
    super.initState();

    getTeacherById();
  }

  Future<void> getTeacherById() async {

    try {

      final response =
      await TeachersService.getTeacherById(

        accessToken:
        widget.accessToken,

        teacherId:
        widget.teacherId,
      );

      setState(() {

        teacher = response;

        isLoading = false;
      });

    } catch (e) {

      debugPrint(
        "TEACHER INFO ERROR",
      );

      debugPrint(
        e.toString(),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    if (isLoading) {

      return const Scaffold(

        body: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F9FC),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              /// HEADER
              Row(

                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  Row(
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

                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.primaryBlue,
                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(

                        "Teacher Info",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF081B5C),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [

                      _buildTopActionButton(
                        Icons.download_rounded,
                      ),

                      const SizedBox(width: 5),

                      _buildTopActionButton(
                        Icons.share_rounded,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// PROFILE CARD
              Container(

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(32),

                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2457FF),
                      Color(0xFF7A3CFF),
                    ],
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    Padding(

                      padding: const EdgeInsets.all(22),

                      child: Row(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          /// IMAGE
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://i.pravatar.cc/300?img=12",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(width: 18),

                          /// DETAILS
                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Row(

                                  mainAxisAlignment:
                                  MainAxisAlignment.start,

                                  children: [

                                    Expanded(
                                      child: Text(

                                        teacher?.fullName ?? "",

                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),

                                const SizedBox(height: 10),

                                Container(
                                  width: 100,

                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.18),
                                    borderRadius:
                                    BorderRadius.circular(30),
                                  ),

                                  child: const Row(
                                    children: [

                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF7DFFA0),
                                        size: 18,
                                      ),

                                      SizedBox(width: 6),

                                      Text(
                                        "Active",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// WHITE INFO BOX
                    Container(

                      width: double.infinity,

                      padding: const EdgeInsets.all(10),

                      decoration: const BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),

                      child: Column(

                        children: [

                          Row(
                            children: [

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.call_rounded,
                                  title: "Mobile Number",
                                  value:
                                  teacher?.mobileNumber ?? "",
                                  color:
                                  AppColors.primaryBlue,
                                ),
                              ),

                              Container(
                                width: 1,
                                height: 55,
                                color: const Color(0xFFE5E7EB),
                              ),

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.email_rounded,
                                  title: "Email",
                                  value:
                                  teacher?.email ?? "",
                                  color:
                                  AppColors.purple,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Row(
                            children: [

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.menu_book_rounded,
                                  title: "Department",
                                  value: "Mathematics",
                                  color:
                                  AppColors.orange,
                                ),
                              ),

                              Container(
                                width: 1,
                                height: 55,
                                color: const Color(0xFFE5E7EB),
                              ),

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.work_rounded,
                                  title: "Experience",
                                  value: "6+ Years",
                                  color:
                                  AppColors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// ACADEMIC INFO
              _buildSectionCard(

                title: "Academic Information",

                icon: Icons.menu_book_rounded,

                child: Row(

                  children: [

                    Expanded(
                      child: _buildStatTile(
                        icon: Icons.groups_rounded,
                        label: "Classes",
                        value: "2",
                        color: AppColors.primaryBlue,
                      ),
                    ),

                    Expanded(
                      child: _buildStatTile(
                        icon: Icons.school_rounded,
                        label: "Sections",
                        value: "2",
                        color: AppColors.green,
                      ),
                    ),

                    Expanded(
                      child: _buildStatTile(
                        icon: Icons.book_rounded,
                        label: "Subjects",
                        value: "Maths",
                        color: AppColors.purple,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// ATTENDANCE
              _buildSectionCard(

                title: "Attendance Overview",

                icon: Icons.calendar_month_rounded,

                child: Row(

                  children: [

                    Expanded(
                      child: Container(

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F4FF),
                          borderRadius:
                          BorderRadius.circular(24),
                        ),

                        child: Column(
                          children: const [

                            Text(
                              "92%",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryBlue,
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              "Attendance",
                              style: TextStyle(
                                color: Color(0xFF667085),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        children: [

                          _buildAttendanceTile(
                            title: "Working Days",
                            value: "22",
                            color:
                            AppColors.green,
                          ),

                          const SizedBox(height: 10),

                          _buildAttendanceTile(
                            title: "Leaves",
                            value: "2",
                            color:
                            AppColors.orange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// CONTACT
              _buildSectionCard(

                title: "Contact Information",

                icon: Icons.call_rounded,

                child: Column(

                  children: [

                    _buildContactTile(
                      icon: Icons.call_rounded,
                      title: "Mobile Number",
                      value:
                      teacher?.mobileNumber ?? "",
                      actionText: "Call",
                    ),

                    const SizedBox(height: 10),

                    _buildContactTile(
                      icon: Icons.email_rounded,
                      title: "Email Address",
                      value:
                      teacher?.email ?? "",
                      actionText: "Email",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// QUICK ACTIONS
              _buildSectionCard(

                title: "Quick Actions",

                icon: Icons.flash_on_rounded,

                child: GridView.count(

                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  crossAxisCount: 4,

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  childAspectRatio: 0.9,

                  children: [

                    _buildQuickAction(
                      Icons.assignment_ind_rounded,
                      "Assign Class",
                    ),

                    _buildQuickAction(
                      Icons.calendar_month_rounded,
                      "Attendance",
                    ),

                    _buildQuickAction(
                      Icons.account_balance_wallet_rounded,
                      "Salary",
                    ),

                    _buildQuickAction(
                      Icons.folder_rounded,
                      "Documents",
                    ),

                    _buildQuickAction(
                      Icons.schedule_rounded,
                      "Timetable",
                    ),

                    _buildQuickAction(
                      Icons.note_alt_rounded,
                      "Leave",
                    ),

                    _buildQuickAction(
                      Icons.bar_chart_rounded,
                      "Performance",
                    ),

                    _buildQuickAction(
                      Icons.edit_rounded,
                      "Edit",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopActionButton(
      IconData icon,
      ) {

    return Container(

      padding: const EdgeInsets.all(10),

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
        icon,
        color: AppColors.primaryBlue,
      ),
    );
  }

  Widget _buildMiniInfo({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),

      child: Row(

        children: [

        /*  Container(

            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),*/

          const SizedBox(width: 12),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF667085),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {

    return Container(

      padding: const EdgeInsets.all(10),

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

              Container(

                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4FF),

                  borderRadius:
                  BorderRadius.circular(16),
                ),

                child: Icon(
                  icon,
                  color: AppColors.primaryBlue,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          child,
        ],
      ),
    );
  }

  Widget _buildStatTile(
      {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
      }) {

    return Column(

      children: [

        Container(

          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius:
            BorderRadius.circular(18),
          ),

          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF667085),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF081B5C),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceTile({
    required String title,
    required String value,
    required Color color,
  }) {

    return Container(

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius:
        BorderRadius.circular(20),
      ),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF667085),
            ),
          ),

          Text(
            value,

            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String value,
    required String actionText,
  }) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE9EEF9),
        ),
      ),

      child: Row(

        children: [

          Container(

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: const Color(0xFFF3F4FF),
              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    color: Color(0xFF667085),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF081B5C),
                  ),
                ),
              ],
            ),
          ),

          Container(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(16),

              border: Border.all(
                color: AppColors.primaryBlue,
              ),
            ),

            child: Text(
              actionText,

              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
      IconData icon,
      String title,
      ) {

    return InkWell(

      borderRadius:
      BorderRadius.circular(20),

      onTap: () {

        HapticFeedback.lightImpact();
      },

      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(20),

          border: Border.all(
            color: const Color(0xFFE9EEF9),
          ),
        ),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              color: AppColors.primaryBlue,
              size: 25,
            ),

            const SizedBox(height: 5),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF081B5C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}