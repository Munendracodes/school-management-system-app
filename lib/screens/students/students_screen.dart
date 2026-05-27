import 'package:flutter/material.dart';
import '../../services/students_service.dart';
import '../../models/students_response.dart';
import '../../core/constants/app_colors.dart';
import 'add_student_screen.dart';

class StudentsScreen extends StatefulWidget {

  final String accessToken;

  const StudentsScreen({
    super.key,
    required this.accessToken,
  });

  @override
  State<StudentsScreen> createState() =>
      _StudentsScreenState();
}
class _StudentsScreenState
    extends State<StudentsScreen> {
  StudentsResponse? studentsResponse;

  bool isLoading = true;
  final TextEditingController searchController =
  TextEditingController();

  List<StudentData> filteredStudents = [];
  List<StudentData> studentsList = [];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;



    Widget _buildClassSection({

      required String className,

      required List<Widget> sections,

    }) {

      return Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          /// CLASS TITLE
          Padding(
            padding: const EdgeInsets.only(
              left: 4,
              bottom: 12,
              top: 10,
            ),

            child: Text(
              className,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF081B5C),
              ),
            ),
          ),

          /// SECTION LIST
          ...sections,

        ],
      );
    }

    Widget _buildSectionGroup({
      required String sectionName,
      required List<Widget> students,
    }) {

      return Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          /// SECTION TAG
        /*  Container(
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
          ),*/

         // const SizedBox(height: 10),

          ...students,
        ],
      );
    }

    Widget _buildStudentCard({
      required String name,
      required String className,
      required String section,
      required String image,
    }) {

      return Container(
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

              child: const Icon(
                Icons.person_rounded,
                size: 30,
                color: AppColors.purple,
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
                        color: AppColors.primaryBlue,
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

                      const Icon(
                        Icons.groups_rounded,
                        size: 16,
                        color: AppColors.orange,
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
              color: Color(0xFF98A2B3),
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

    final groupedStudents =
    <String, Map<String, List<StudentData>>>{};
    final studentsToDisplay =
    searchController.text.trim().isEmpty

        ? studentsResponse?.students ?? []

        : filteredStudents;
    final students = filteredStudents;

    for (var student in filteredStudents) {

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
        const Color(0xFF2457FF),

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
                          "Students",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF081B5C),
                          ),
                        ),
                        Text(
                          "Manage student details",
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
            Padding(
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

                          child: const Icon(
                            Icons.tune_rounded,
                            color: Color(0xFF2457FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            /// STUDENTS LIST
            Expanded(

              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),

                children: [
                  /// CLASS 1
                  ...groupedStudents.entries.map((classEntry) {

                    final className =
                        classEntry.key;

                    final sections =
                        classEntry.value;

                    return _buildClassSection(

                      className: className,

                      sections:

                      sections.entries.map((sectionEntry) {

                        final sectionName =
                            sectionEntry.key;

                        final students = sectionEntry.value;
                        return _buildSectionGroup(

                          sectionName: sectionName,

                          students:

                          students.map((student) {

                            return _buildStudentCard(

                              name:
                              student.fullName,

                              className:
                              student.className,

                              section:
                              "Section ${student.sectionName}",

                              image:
                              student.profileImage,
                            );

                          }).toList(),
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

