import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/screens/fees/class_fee_summary_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../models/active_academic_year_response.dart';
import '../../models/fees_response.dart';
import '../../models/students_response.dart';
import '../../services/academic_year_service.dart';
import '../../services/students_service.dart';

class FeesScreen extends StatefulWidget {

  final String accessToken;
  final Color backgroundColor;

  const FeesScreen({
    super.key,
    required this.accessToken,
    required this.backgroundColor
  });

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  int count=0;

  StudentsResponse? studentsResponse;

  List<ActiveAcademicYearResponse> academicYears = [];

  List<ClassroomData> classrooms = [];

  bool isLoading = true;

  String? selectedAcademicYear;

  List<StudentData> filteredStudents = [];
  List<StudentData> studentsList = [];


  List<FeeData> fees = [
    FeeData(
      className: "Class 1",
      studentCount: 60,
      schoolFee: 120000,
      booksFee: 30000,
      admissionFee: 20000,
      uniformFee: 20000,
    ),
    FeeData(
      className: "Class 2",
      studentCount: 55,
      schoolFee: 110000,
      booksFee: 25000,
      admissionFee: 18000,
      uniformFee: 17000,
    ),
  ];
  Widget _buildHeader() {

    return  Row(

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
                "Fees Management",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  AppColors.darkText,
                ),
              ),
              Text(
                "Manage Fee Structure",
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
    );
  }

  Widget buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    String? percentage,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: bgColor,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: Colors.white,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(
            height: 40,
            width: 40,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(16),

              border: Border.all(
                color: iconColor.withOpacity(0.15),
              ),
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 25,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF667085),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewBox({

    required IconData icon,

    required String title,

    required String value,

  }) {

    return Container(

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: Colors.white.withOpacity(0.15),

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),

          const SizedBox(height: 10),

          Text(

            title,

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          Text(

            value,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {

    return Container(
      width: 1,
      height: 80,
      color: Colors.white24,
    );
  }

  Widget _overviewMetric({

    required IconData icon,

    required Color iconColor,

    required String title,

    required String value,

  }) {

    return Column(

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Container(

          height: 52,
          width: 52,

          decoration: BoxDecoration(

            color: Colors.white,

            shape: BoxShape.circle,
          ),

          child: Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
        ),

        const SizedBox(height: 12),

        Text(

          title,

          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 4),

        Text(

          value,

          maxLines: 2,

          overflow:
          TextOverflow.ellipsis,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _overviewItem(
      String title,
      String value,
      ) {

    return Column(

      children: [

        Text(
          title,

          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          value,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {

    return Container(

      height: 55,

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),

      child: TextField(

        decoration: const InputDecoration(

          border: InputBorder.none,

          prefixIcon:
          Icon(Icons.search_rounded),

          hintText: "Search Class",
        ),
      ),
    );
  }

  Widget _buildFeeCard(
      FeeData fee,
      ) {

    return Container(

      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE9EEF9),
        ),
      ),

      child: Column(

        children: [

          Row(

            children: [

              Container(

                height: 55,
                width: 55,

                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),

                  borderRadius:
                  BorderRadius.circular(16),
                ),

                child: const Icon(
                  Icons.school_rounded,
                  color: AppColors.primaryBlue,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      fee.className,

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "${fee.studentCount} Students",

                      style: const TextStyle(
                        color: AppColors.lightText,
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,

                children: [

                  const Text(
                    "Total Fees",
                  ),
                  SizedBox(height: 5.0),

                  Text(
                    "₹${fee.totalFee.toInt()}",

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                      AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),

       /*   const SizedBox(height: 20),

          GridView.count(

            shrinkWrap: true,

            physics:
            const NeverScrollableScrollPhysics(),

            crossAxisCount: 2,

            childAspectRatio: 1.8,

            crossAxisSpacing: 10,

            mainAxisSpacing: 10,

            children: [

              _buildFeeItem(
                Icons.school,
                "School Fee",
                fee.schoolFee,
              ),

              _buildFeeItem(
                Icons.menu_book,
                "Books Fee",
                fee.booksFee,
              ),

              _buildFeeItem(
                Icons.app_registration,
                "Admission Fee",
                fee.admissionFee,
              ),

              _buildFeeItem(
                Icons.checkroom,
                "Uniform Fee",
                fee.uniformFee,
              ),
            ],
          ),*/
        ],
      ),
    );
  }

  Widget _buildFeeItem(
      IconData icon,
      String title,
      double amount,
      ) {

    return Container(

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: const Color(0xFFF8FAFC),

        borderRadius:
        BorderRadius.circular(16),
      ),

      child: Row(

        children: [

          Icon(
            icon,
            size: 20,
            color: AppColors.primaryBlue,
          ),

          const SizedBox(width: 8),

          Expanded(

            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

                children: [

                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "₹${amount.toInt()}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  void initState() {

    super.initState();

    loadAcademicYear();

    loadStudents();
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

        isLoading = false;
        print("printed");
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  Future<void> loadStudents() async {

    try {

      final response =
      await StudentsService.getStudents(

        accessToken:
        widget.accessToken,
      );

      print(response);

      setState(() {

        studentsList = response.students;

        calculateStudentCount();

        setState(() {

          studentsResponse = response;

          filteredStudents =
              response.students;

          isLoading = false;
        });

        isLoading = false;
      });
      print(
        response.students.length,
      );
      print(
        response.students.first.fullName,
      );

    } catch (e) {

      print(
        "STUDENTS API ERROR",
      );

      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  void calculateStudentCount() {

    final Map<String, int> classStudentCount = {};

    for (final student in studentsList) {

      classStudentCount[student.className] =
          (classStudentCount[student.className] ?? 0) + 1;
    }

    for (final classroom in classrooms) {

      classroom.studentCount =
          classStudentCount[classroom.name] ?? 0;
    }
  }

  Widget _buildCollectFeeButton() {

    return Container(

      height: 58,

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(30),

        gradient: const LinearGradient(
          colors: [
            AppColors.primaryBlue,
            Color(0xFF4F7BFF),
          ],
        ),

        boxShadow: [
          BoxShadow(
            color:
            AppColors.primaryBlue
                .withOpacity(0.35),

            blurRadius: 15,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: FloatingActionButton.extended(

        elevation: 0,

        backgroundColor:
        Colors.transparent,

        onPressed: () {

          /// TODO
          /// Navigate to Collect Fee Screen

        },

        icon: const Icon(
          Icons.currency_rupee_rounded,
          color: Colors.white,
        ),

        label: const Text(
          "Collect Fee",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            children: [

              _buildHeader(),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                crossAxisCount: 2,

                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

                childAspectRatio: 1.2,

                children: [

                  buildSummaryCard(
                    title: "Total Students",
                    value: "25",
                    icon: Icons.groups_rounded,
                    iconColor: const Color(0xFF2457FF),
                    bgColor: const Color(0xFFF4F6FF),
                  ),

                  buildSummaryCard(
                    title: "Total Fees",
                    value: "₹75,000",
                    icon: Icons.currency_rupee_rounded,
                    iconColor: const Color(0xFFF97316),
                    bgColor: const Color(0xFFFFF8F2),
                  ),

                  buildSummaryCard(
                    title: "Collected",
                    value: "₹60,000",
                    percentage: "80%",
                    icon: Icons.check_circle_rounded,
                    iconColor: const Color(0xFF22C55E),
                    bgColor: const Color(0xFFF2FCF5),
                  ),

                  buildSummaryCard(
                    title: "Pending",
                    value: "₹15,000",
                    percentage: "20%",
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: const Color(0xFFEC4899),
                    bgColor: const Color(0xFFFFF3F7),
                  ),
                ],
              ),

             // const SizedBox(height: 15),

           //   _buildSearchBox(),

              const SizedBox(height: 15),

              Expanded(

                child: ListView.builder(

                  itemCount: classrooms.length,

                  itemBuilder: (_, index) {

                    return InkWell(
                      onTap: (){
                        HapticFeedback.lightImpact();
                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) => ClassFeeSummaryScreen(

                              accessToken: widget.accessToken,
                                className: classrooms[index].name
                            ),
                          ),
                        );
                      },
                      child: _buildFeeCard(
                          FeeData(
                            className: classrooms[index].name,
                            studentCount: classrooms[index].studentCount,
                            schoolFee: 120000,
                            booksFee: 30000,
                            admissionFee: 20000,
                            uniformFee: 20000,
                          ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildCollectFeeButton()
    );
  }
}
