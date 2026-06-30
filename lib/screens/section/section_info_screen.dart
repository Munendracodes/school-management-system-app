import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/models/section_with_class.dart';
import 'package:school_management_app/screens/diary/diary_screen.dart';
import 'package:school_management_app/screens/homework/home_work_screen.dart';
import 'package:school_management_app/screens/students/student_info_screen.dart';
import '../../models/active_academic_year_response.dart';
import '../../services/academic_year_service.dart';
import '../../services/students_service.dart';
import '../../models/students_response.dart';
import '../../core/constants/app_colors.dart';
import '../students/add_student_screen.dart';
import 'add_student_screen.dart';

class SectionInfoScreen extends StatefulWidget {

  final String accessToken;
  final Color backgroundColor;
  final String selectedClass;
  final String selectedSection;


  const SectionInfoScreen({
    super.key,
    required this.accessToken,
    required this.backgroundColor,
    required this.selectedClass,
    required this.selectedSection
  });

  @override
  State<SectionInfoScreen> createState() =>
      _SectionInfoScreenState();
}
class _SectionInfoScreenState
    extends State<SectionInfoScreen> {
  StudentsResponse? studentsResponse;
  List<StudentData> currentsectionstudents=[];

  bool isLoading = true;
  final TextEditingController searchController =
  TextEditingController();

  List<StudentData> filteredStudents = [];
  List<StudentData> studentsList = [];

  List<ActiveAcademicYearResponse> academicYears = [];
  String? selectedAcademicYear;

  List<ClassroomData> classrooms = [];


  @override
  void initState() {
    super.initState();
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
  void filterStudents(String query) {

    final allStudents =
        studentsResponse?.students ?? [];

    if (query.trim().isEmpty) {

      filteredStudents = allStudents;

    } else {

      final lowerQuery =
      query.toLowerCase();

      filteredStudents = allStudents.where((student) {

        return student.fullName
            .toLowerCase()
            .contains(lowerQuery)

            ||

            student.className
                .toLowerCase()
                .contains(lowerQuery)

            ||

            student.sectionName
                .toLowerCase()
                .contains(lowerQuery);

      }).toList();
    }

    setState(() {});
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
        currentsectionstudents = studentsList.where(
                (student) =>
            student.className == widget.selectedClass && student.sectionName == widget.selectedSection
        ).toList();

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

  Widget buildQuickCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(

          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE7ECF5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF081B5C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF667085),
                      ),
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

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;



    Widget _buildStudentCard({
      required String name,
      required String className,
      required String section,
      required String image,
      required StudentData student,
    }) {

      return InkWell(
        borderRadius: BorderRadius.circular(24),

        onTap: () {

          HapticFeedback.lightImpact();

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) => StudentInfoScreen(

                accessToken: widget.accessToken,

                studentId: student.id,
              ),
            ),
          );
        },

        child: Container(
          margin: const EdgeInsets.only(bottom: 10),

          padding: const EdgeInsets.all(15),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
            BorderRadius.circular(24),

            border: Border.all(
              color: const Color(0xFFE9EEF9),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Row(
            children: [

              /// PROFILE IMAGE
              Container(
                height: 50,
                width: 50,

                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.person_rounded,
                  size: 30,
                  color: widget.backgroundColor,
                ),
              ),

              const SizedBox(width: 15),

              /// DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      name,

                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF081B5C),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        const Icon(
                          Icons.school_rounded,
                          size: 16,
                          color: Color(0xFF081B5C),
                        ),

                        const SizedBox(width: 6),

                        Text(
                          className,

                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF667085),
                          ),
                        ),

                        const SizedBox(width: 5),

                        Container(
                          width: 1,
                          height: 14,
                          color: Color(0xFFD0D5DD),
                        ),

                        const SizedBox(width: 5),

                        Icon(
                            Icons.groups_rounded,
                            size: 16,
                            color: Color(0xFF081B5C)
                        ),

                        const SizedBox(width: 6),

                        Text(
                          section,

                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// ARROW
              const Icon(
                Icons.chevron_right_rounded,
                size: 30,
                color: Color(0xFF081B5C),
              ),
            ],
          ),
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

    final groupedStudents =
    <String, Map<String, List<StudentData>>>{};
    final studentsToDisplay =
    searchController.text.trim().isEmpty
        ? currentsectionstudents
        : filteredStudents;

    for (var student in studentsToDisplay) {

      final className =
          student.className;

      final sectionName =
          student.sectionName;

      groupedStudents.putIfAbsent(
        className,
            () => {},
      );

      groupedStudents[className]!.putIfAbsent(
        sectionName,
            () => [],
      );

      groupedStudents[className]![sectionName]!
          .add(student);
    }

    return Scaffold(

      backgroundColor:
      const Color(0xFFF8FAFF),
      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        widget.backgroundColor,

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) => AddStudentScreen(
                accessToken: widget.accessToken,

                onStudentAdded: () {
                  loadStudents();
                },
              ),
            ),
          );
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SafeArea(

        child: Column(

          children: [

            /// HEADER
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),

              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Container(
                      height: 42,
                      width: 42,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(14),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Color(0xFF081B5C),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Section Info",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF081B5C),
                          ),
                        ),
                        Text(
                          "Manage Section Details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// SEARCH + FILTER
        /*    Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Row(
                children: [

                  /// SEARCH BAR
                  Expanded(
                    child: Row(
                      children: [

                        Expanded(
                          child: SearchBar(

                            controller: searchController,

                            onChanged: (value) {

                              filterStudents(value);
                            },

                            hintText:
                            "Search by name, class or section...",

                            leading: const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF9CA3AF),
                            ),

                            backgroundColor:
                            WidgetStateProperty.all(
                              Colors.white,
                            ),

                            elevation:
                            WidgetStateProperty.all(0),

                            side:
                            WidgetStateProperty.all(
                              BorderSide(
                                color: const Color(0xFFE3EAFD),
                                width: 1.2,
                              ),
                            ),

                            padding:
                            WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                            ),

                            shape:
                            WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(18),
                              ),
                            ),

                            hintStyle:
                            WidgetStateProperty.all(
                              const TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          height: 56,
                          width: 56,

                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F7FF),
                            borderRadius:
                            BorderRadius.circular(18),
                          ),

                          child: Icon(
                            Icons.tune_rounded,
                            color: widget.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/

            const SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(10.0),

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
                          "${widget.selectedClass} - ${widget.selectedSection}",
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [


                      Container(
                        width: 1,
                        height: 60,
                        color:
                        Colors.white24,
                      ),

                      const SizedBox(width: 10),

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Total Students",
                              style: TextStyle(color: Colors.white70),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              currentsectionstudents
                                  .length
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

                      const SizedBox(width: 10),
                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Class Teacher",

                              style: TextStyle(
                                color:
                                Colors.white70,
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              "Raja Ram",

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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                children: [

                  buildQuickCard(

                    icon: Icons.menu_book_rounded,

                    title: "Homework",

                    subtitle: "12 Pending",

                    color: Colors.deepOrange,

                    onTap: () async {
                      HapticFeedback.lightImpact();
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HomeWorkScreen(
                                accessToken: widget.accessToken,
                                backgroundColor: widget.backgroundColor,
                              className: widget.selectedClass,
                              sectionName: widget.selectedSection,

                            )
                        )
                      );

                    },
                  ),

                  const SizedBox(width: 12),

                  buildQuickCard(

                    icon: Icons.auto_stories_rounded,

                    title: "Diary",

                    subtitle: "3 New Notes",

                    color: Colors.green,

                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_)=>DiaryScreen(accessToken: widget.accessToken,
                              className: widget.selectedClass,
                              sectionName: widget.selectedSection,)
                        )
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// STUDENTS LIST
            Expanded(

              child: ListView.builder(

                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  120,
                ),

                itemCount: currentsectionstudents.length,

                itemBuilder: (context, index) {

                  final student =
                  currentsectionstudents[index];

                  return _buildStudentCard(

                    student: student,

                    name: student.fullName,

                    className: student.className,

                    section:
                    "Section ${student.sectionName}",

                    image: student.profileImage,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

