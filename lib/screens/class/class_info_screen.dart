import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/screens/students/student_info_screen.dart';
import '../../models/active_academic_year_response.dart';
import '../../services/academic_year_service.dart';
import '../../services/students_service.dart';
import '../../models/students_response.dart';
import '../../core/constants/app_colors.dart';
import '../students/add_student_screen.dart';
import 'add_student_screen.dart';

class ClassInfoScreen extends StatefulWidget {

  final String accessToken;
  final Color backgroundColor;
  final String selectedClass;

  const ClassInfoScreen({
    super.key,
    required this.accessToken,
    required this.backgroundColor,
    required this.selectedClass
  });

  @override
  State<ClassInfoScreen> createState() =>
      _ClassInfoScreenState();
}
class _ClassInfoScreenState
    extends State<ClassInfoScreen> {
  StudentsResponse? studentsResponse;

  List<ActiveAcademicYearResponse> academicYears = [];

  List<StudentData> currentclassstudents =[];

  String? selectedAcademicYear;

  List<ClassroomData> classrooms = [];

  bool isLoading = true;
  final TextEditingController searchController =
  TextEditingController();

  List<StudentData> filteredStudents = [];
  List<StudentData> studentsList = [];

  @override
  void initState() {
    super.initState();
    loadAcademicYear();
    loadStudents();


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

      setState(() {
        currentclassstudents = studentsList.where(
              (student) =>
          student.className == widget.selectedClass
        ).toList();
      });

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

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;





    Widget _buildSectionGroup({
      required String sectionName,
      required List<Widget> students,
    }) {

      return Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          /// SECTION TAG
           Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FF),
              borderRadius:
              BorderRadius.circular(30),
            ),

            child: Text(
              "Section "+sectionName,

              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2457FF),
              ),
            ),
          ),

          const SizedBox(height: 10),

          ...students,
        ],
      );
    }

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
    <String, List<StudentData>>{};

    for (var student in currentclassstudents) {

      groupedStudents.putIfAbsent(
        student.sectionName,
            () => [],
      );

      groupedStudents[student.sectionName]!
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
                          "Class Info",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF081B5C),
                          ),
                        ),
                        Text(
                          "Manage Class Details",
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
           /* Padding(
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
                         widget.selectedClass ,
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

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Total Sections",

                              style: TextStyle(
                                color:
                                Colors.white70,
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              currentclassstudents.map((student)=> student.sectionName).toSet().length.toString(),

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
                      const SizedBox(width: 10),

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
                              "Total Students",

                              style: TextStyle(
                                color:
                                Colors.white70,
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              currentclassstudents.length.toString(),

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

                    ],
                  ),
                ],
              ),
            ),

            /// STUDENTS LIST
            Expanded(

                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),

                  children: [
                    /// CLASS 1
                    ...groupedStudents.entries.map((sectionEntry) {

                      final sectionName =
                          sectionEntry.key;

                      final students =
                          sectionEntry.value;

                      return _buildSectionGroup(

                        sectionName: sectionName,

                        students: students.map((student) {

                          return _buildStudentCard(

                            student: student,

                            name: student.fullName,

                            className: student.className,

                            section:
                            "Section ${student.sectionName}",

                            image:
                            student.profileImage,
                          );
                        }).toList(),
                      );
                    }),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

