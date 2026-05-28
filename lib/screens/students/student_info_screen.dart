import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/student_info_response.dart';
import '../../services/student_info_service.dart';
import '../parents/parent_screen.dart';


class StudentInfoScreen extends StatefulWidget {

  final String accessToken;
  final String studentId;

  const StudentInfoScreen({
    super.key,
    required this.accessToken,
    required this.studentId,
  });

  @override
  State<StudentInfoScreen> createState() =>
      _StudentInfoScreenState();
}

class _StudentInfoScreenState
    extends State<StudentInfoScreen> {

  bool isLoading = true;

  StudentInfoResponse? student;

  @override
  void initState() {

    super.initState();

    getStudentInfo();
  }


  Future<void> getStudentInfo() async {

    try {

      final response =
      await StudentInfoService.getStudentById(

        accessToken:
        widget.accessToken,

        studentId:
        widget.studentId,
      );

      setState(() {

        student = response;

        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> refreshStudentInfo() async {

    setState(() {
      isLoading = true;
    });

    await getStudentInfo();
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    Widget _buildTopInfo({

      required String title,
      required String value,
      required IconData icon,
      required Color iconColor

    }) {

      return Expanded(

        child: Column(

          children: [

            Icon(
              icon,
              color: iconColor,
              size: 22,
            ),

            const SizedBox(height: 4),

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
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF081B5C),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildInfoCard({

      required String title,
      required List<Widget> children,

    }) {

      return Container(

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(24),

          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
        ),

        child: Column(

          children: [

            Align(

              alignment: Alignment.centerLeft,

              child: Text(

                title,

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF081B5C),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ...children,
          ],
        ),
      );
    }

    Widget _buildInfoRow(

        String title,
        String value,
        IconData icon,
        ) {

      return Padding(

        padding:
        const EdgeInsets.only(bottom: 18),

        child: Row(

          children: [

            Icon(
              icon,
              size: 20,
              color: const Color(0xFF2457FF),
            ),

            const SizedBox(width: 12),

            Expanded(

              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF667085),
                ),
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF081B5C),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildFeeCard() {

      return Container(

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(

          color: const Color(0xFFF5F7FF),

          borderRadius:
          BorderRadius.circular(24),

          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
        ),

        child: Column(

          children: [

            Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                const Text(

                  "Fee Information",

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),

                Container(

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E5),
                    borderRadius:
                    BorderRadius.circular(30),
                  ),

                  child: const Text(
                    "PENDING",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(

              children: [

                Expanded(

                  child: Column(

                    children: const [

                      Text(
                        "71%",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2457FF),
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Paid",
                        style: TextStyle(
                          color: Color(0xFF667085),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 1,
                  height: 100,
                  color: Color(0xFFE5E7EB),
                ),

                const SizedBox(width: 20),

                const Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Total Fees : ₹45,000",
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Paid : ₹32,000",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Pending : ₹13,000",
                        style: TextStyle(
                          color: Colors.red,
                        ),
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

    Widget _buildQuickAction(
        IconData icon,
        String title,
        ) {

      return Container(

        width: 78,

        padding:
        const EdgeInsets.symmetric(
          vertical: 18,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(18),

          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
        ),

        child: Column(

          children: [

            Icon(
              icon,
              color: const Color(0xFF2457FF),
              size: 20,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF081B5C),
              ),
            ),
          ],
        ),
      );
    }

    if (isLoading) {

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(

        backgroundColor:
        Colors.transparent,

        elevation: 0,

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryBlue,
            size: 20,
          ),

          onPressed: () {

            Navigator.pop(context);
          },
        ),

        title: const Text(

          "Student Profile",

          style: TextStyle(
            color: Color(0xFF081B5C),
            fontWeight: FontWeight.w700,
            fontSize: 20
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(10),

        child: Column(

          children: [

            /// PROFILE CARD
            Container(

              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color: const Color(0xFFF5F7FF),

                borderRadius:
                BorderRadius.circular(28),

                border: Border.all(
                  color: const Color(0xFFE8ECF4),
                ),
              ),

              child: Column(

                children: [

                  Row(

                    crossAxisAlignment:
                    CrossAxisAlignment.center,

                    children: [

                      /// IMAGE
                      Container(

                        height: 70,
                        width: 70,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.person,
                          size: 45,
                          color: Color(0xFF2457FF),
                        ),
                      ),

                      const SizedBox(width: 18),

                      /// DETAILS
                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,


                          children: [

                            Text(

                              student?.fullName ?? "",

                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.w700,
                                color:
                                Color(0xFF081B5C),
                              ),
                            ),

                            const SizedBox(height: 5),

                            Container(

                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 2,
                              ),

                              decoration: BoxDecoration(

                                color: Colors.white,

                                borderRadius:
                                BorderRadius.circular(30),
                              ),

                              child: Text(

                                student
                                    ?.admissionNumber ??
                                    "",

                                style: const TextStyle(
                                  color:
                                  Color(0xFF2457FF),
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                            ),

                            const SizedBox(height: 5),

                            Row(

                              children: [

                                const Icon(
                                  Icons.calendar_month,
                                  size: 18,
                                  color: Color(0xFF2457FF),
                                ),

                                const SizedBox(width: 6),

                                Expanded(
                                  child: Text(
                                    student?.dateOfBirth ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF475467),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            Row(

                              children: [

                                const Icon(
                                  Icons.person_outline,
                                  size: 18,
                                  color: Color(0xFF2457FF),
                                ),

                                const SizedBox(width: 6),

                                Text(

                                  student?.gender ?? "",

                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF475467),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Divider(
                    color: Color(0xFFE5E7EB),
                  ),

                  const SizedBox(height: 5),

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      _buildTopInfo(
                        title: "Class",
                        value:
                        student?.classroom.name ?? "",
                        icon: Icons.school_outlined,
                        iconColor: AppColors.purple
                      ),

                      _buildTopInfo(
                        title: "Section",
                        value:
                        student?.section.name ?? "",
                        icon: Icons.groups_rounded,
                        iconColor: AppColors.orange
                      ),

                      _buildTopInfo(
                        title: "Academic Year",
                        value:
                        student?.academicYear.name ?? "",
                        icon:
                        Icons.calendar_today_rounded,
                        iconColor: AppColors.primaryBlue
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// ACADEMIC INFORMATION
            _buildInfoCard(

              title: "Academic Information",

              children: [

                _buildInfoRow(
                  "Gender",
                  student?.gender ?? "",
                  Icons.person_outline,
                ),

                _buildInfoRow(
                  "Date of Birth",
                  student?.dateOfBirth ?? "",
                  Icons.calendar_month,
                ),

                _buildInfoRow(
                  "Classroom",
                  student?.classroom.name ?? "",
                  Icons.school_outlined,
                ),

                _buildInfoRow(
                  "Section",
                  student?.section.name ?? "",
                  Icons.groups_rounded,
                ),

                _buildInfoRow(
                  "Academic Year",
                  student?.academicYear.name ?? "",
                  Icons.calendar_today_rounded,
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// PARENT DETAILS
            Container(

              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(24),

                border: Border.all(
                  color: const Color(0xFFE8ECF4),
                ),
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(

                        "Parent Details",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF081B5C),
                        ),
                      ),

                      InkWell(

                        borderRadius: BorderRadius.circular(14),

                        onTap: () async {

                          await Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) => AddParentScreen(

                                accessToken: widget.accessToken,

                                studentId: widget.studentId,

                                studentName:
                                student?.fullName ?? "",

                                className:
                                student?.classroom.name ?? "",

                                sectionName:
                                student?.section.name ?? "",

                                academicYear:
                                student?.academicYear.name ?? "",
                              ),
                            ),
                          );

                          refreshStudentInfo();
                        },

                        child: Container(

                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(

                            color:
                            const Color(0xFFF2F5FF),

                            borderRadius:
                            BorderRadius.circular(14),
                          ),

                          child: const Row(

                            children: [

                              Icon(
                                Icons.add,
                                size: 18,
                                color: Color(0xFF2457FF),
                              ),

                              SizedBox(width: 4),

                              Text(
                                "Add Parent",
                                style: TextStyle(
                                  color: Color(0xFF2457FF),
                                  fontWeight:
                                  FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  ...student!.parents.map(

                        (parent) {

                      return Container(

                        margin:
                        const EdgeInsets.only(
                          bottom: 12,
                        ),

                        padding:
                        const EdgeInsets.all(14),

                        decoration: BoxDecoration(

                          color:
                          const Color(0xFFF8FAFF),

                          borderRadius:
                          BorderRadius.circular(18),

                          border: Border.all(
                            color:
                            const Color(0xFFE8ECF4),
                          ),
                        ),

                        child: Row(

                          children: [

                            CircleAvatar(

                              radius: 28,

                              backgroundColor:
                              Colors.white,

                              child: const Icon(
                                Icons.person,
                                color:
                                Color(0xFF2457FF),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Text(

                                    parent.fullName,

                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.w700,
                                      fontSize: 17,
                                      color:
                                      Color(0xFF081B5C),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    parent.relationshipType,
                                    style: const TextStyle(
                                      color:
                                      Color(0xFF667085),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                              const Color(0xFFF2F5FF),

                              child: const Icon(
                                Icons.call,
                                size: 18,
                                color: Color(0xFF2457FF),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// FEE INFORMATION
            _buildFeeCard(),

            const SizedBox(height: 10),

            /// QUICK ACTIONS
            Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const Align(

                  alignment: Alignment.centerLeft,

                  child: Text(

                    "Quick Actions",

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF081B5C),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    _buildQuickAction(
                      Icons.event_available,
                      "Attendance",
                    ),

                    _buildQuickAction(
                      Icons.receipt_long,
                      "Fees",
                    ),

                    _buildQuickAction(
                      Icons.call,
                      "Contact",
                    ),

                    _buildQuickAction(
                      Icons.edit,
                      "Edit",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}