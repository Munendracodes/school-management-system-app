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
import '../../widgets/app_primary_button.dart';
import '../students/add_student_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/app_segmented_control.dart';
import '../../services/homework_service.dart';
import '../../models/student_homework_review_model.dart';
import 'package:intl/intl.dart';


class HomeworkInfoScreen extends StatefulWidget {

  final String accessToken;
  final Color backgroundColor;
  final String selectedClass;
  final String selectedSection;
  final String subject;
  final String homeWorkTitle;
  final String homeWorkDescription;
  final DateTime assignedDate;
  final String homeWorkId;
  final String academicYearId;


  const HomeworkInfoScreen({
    super.key,
    required this.accessToken,
    required this.backgroundColor,
    required this.selectedClass,
    required this.selectedSection,
    required this.subject,
    required this.homeWorkTitle,
    required this.homeWorkDescription,
    required this.academicYearId,
    required this.assignedDate,
    required this.homeWorkId
  });

  @override
  State<HomeworkInfoScreen> createState() =>
      _HomeworkInfoScreenState();
}
class _HomeworkInfoScreenState
    extends State<HomeworkInfoScreen> {
  StudentsResponse? studentsResponse;
  List<StudentData> currentsectionstudents=[];

  Map<String, bool> homeworkStatus = {};

  bool isSaving=false;

  Map<String, int> homeworkRatings = {};

  bool isReviewCompleted = false;

  bool isLoading = true;
  final TextEditingController searchController =
  TextEditingController();

  List<StudentData> filteredStudents = [];
  List<StudentData> studentsList = [];

  List<ActiveAcademicYearResponse> academicYears = [];
  String? selectedAcademicYear;

  List<ClassroomData> classrooms = [];

  final HomeworkService homeworkService =
  HomeworkService();


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

      for (final student in response.students) {

        homeworkStatus.putIfAbsent(
          student.id,
              () => false,
        );

        homeworkRatings.putIfAbsent(
          student.id,
              () => 0,
        );
      }


      setState(()  {

        studentsList = response.students;
        currentsectionstudents = studentsList.where(
                (student) =>
            student.className == widget.selectedClass && student.sectionName == widget.selectedSection
        ).toList();

         loadHomeworkReview();

        setState(() {

          studentsResponse = response;

          filteredStudents =
              response.students;


        });


      });

      await loadHomeworkReview();

      setState(() {
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

  Future<void> saveHomeworkReview() async {

    try {

      setState(() {

        isSaving = true;

      });

      final List<StudentHomeworkReviewModel>
      reviews = [];

      for (final student
      in currentsectionstudents) {

        reviews.add(

          StudentHomeworkReviewModel(

            studentId: student.id,

            studentName: student.fullName,

            isSubmitted:

            homeworkStatus[student.id]
                ?? false,

            rating:

            homeworkRatings[student.id]
                ?? 0,

            remarks: "",

            submittedAt:
            DateTime.now()
                .toIso8601String(),
          ),
        );
      }

      await homeworkService.saveHomeworkReview(

        academicYearId:
        widget.academicYearId,

        className:
        widget.selectedClass,

        sectionName:
        widget.selectedSection,

        assignedDate:

        widget.assignedDate,

        homeworkId:
        widget.homeWorkId,

        reviewedBy: "",

        students: reviews,
      );

      if (!mounted) return;

      setState(() {

        isReviewCompleted = true;

      });

      ScaffoldMessenger.of(context)

          .showSnackBar(

        const SnackBar(

          content: Text(

            "Homework review saved successfully.",

          ),
        ),
      );

    }

    catch (e) {

      ScaffoldMessenger.of(context)

          .showSnackBar(

        SnackBar(

          content: Text(

            e.toString(),
          ),
        ),
      );

    }

    finally {

      if (mounted) {

        setState(() {

          isSaving = false;

        });
      }
    }
  }

  Future<void> loadHomeworkReview() async {

    final reviews =
    await homeworkService.getHomeworkReview(

      academicYearId: widget.academicYearId,

      className: widget.selectedClass,

      sectionName: widget.selectedSection,

      assignedDate: widget.assignedDate,

      homeworkId: widget.homeWorkId,
    );

    if (reviews.isEmpty) {

      return;
    }

    setState(() {

      isReviewCompleted = true;

      for (final review in reviews) {

        homeworkStatus[review.studentId] =
            review.isSubmitted;

        homeworkRatings[review.studentId] =
            review.rating;
      }
    });
  }

  Widget _buildInfoChip(

      IconData icon,

      String text,

      ) {

    return Container(

      padding: const EdgeInsets.symmetric(

        horizontal: 12,

        vertical: 10,
      ),

      decoration: BoxDecoration(

        color: Colors.white.withOpacity(.15),

        borderRadius:
        BorderRadius.circular(14),
      ),

      child: Row(

        children: [

          Icon(

            icon,

            color: Colors.white,

            size: 16,
          ),

          const SizedBox(width: 8),

          Expanded(

            child: Text(

              text,

              overflow:
              TextOverflow.ellipsis,

              style: const TextStyle(

                color: Colors.white,

                fontSize: 12,

                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        ],
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
      final bool isCompleted =
          homeworkStatus[student.id] ?? false;

      final int rating =
          homeworkRatings[student.id] ?? 0;

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE7ECF5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [

            //----------------------------------------------------
            // Header
            //----------------------------------------------------

            Row(
              children: [

                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                  widget.backgroundColor.withOpacity(.12),
                  child: Text(
                    name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.backgroundColor,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              name,
                              overflow:
                              TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color:
                                Color(0xFF081B5C),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {

                              if (isReviewCompleted) return;

                              if (isCompleted) return;

                              setState(() {

                                homeworkStatus[student.id] = true;

                              });

                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? const Color(0xFF22C55E)
                                    : const Color(0xFFEF4444),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Icon(
                                    isCompleted
                                        ? Icons.check
                                        : Icons.schedule,
                                    color: Colors.white,
                                    size: 16,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    isCompleted
                                        ? "Submitted"
                                        : "Pending",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),



                      Row(
                        children: [

                          if (isCompleted)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: List.generate(
                                  5,
                                      (index) {
                                    return GestureDetector(
                                      onTap: () {

                                        if (isReviewCompleted) return;

                                        setState(() {

                                          homeworkRatings[student.id] = index + 1;

                                        });

                                      },
                                      child: AnimatedScale(
                                        duration:
                                        const Duration(milliseconds: 180),
                                        scale:
                                        index < rating ? 1.15 : 1,
                                        child: Icon(
                                          index < rating
                                              ? Icons.star_rounded
                                              : Icons.star_outline_rounded,
                                          color: Colors.amber,
                                          size: 23,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
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
                      height: 35,
                      width: 35,

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
                          "Homework Info",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF081B5C),
                          ),
                        ),
                        Text(
                          "Manage Homework Details",
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

                      Expanded(
                        child: _buildInfoChip(
                          Icons.calendar_today,
                          DateFormat("dd MMM yyyy")
                              .format(widget.assignedDate),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _buildInfoChip(
                          Icons.school,
                          "${widget.selectedClass} • ${widget.selectedSection}",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

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

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "${widget.subject} - ${widget.homeWorkTitle}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            widget.homeWorkDescription,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Divider(color: Colors.grey.shade200),

                      const SizedBox(height: 14),
                    ],
                  ),


                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [

                      const SizedBox(width: 10),

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Assigned",
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

                      const SizedBox(width: 20),
                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Submitted",

                              style: TextStyle(
                                color:
                                Colors.white70,
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              homeworkStatus.values
                                  .where((e) => e)
                                  .length
                                  .toString(),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                              "Pending",

                              style: TextStyle(
                                color:
                                Colors.white70,
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                          Text(
                            currentsectionstudents
                                .where((student) =>
                            !(homeworkStatus[student.id] ?? false))
                                .length
                                .toString(),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

            if (isReviewCompleted)

              Container(

                margin: const EdgeInsets.only(

                  left: 18,

                  right: 18,

                  bottom: 15,
                ),

                padding: const EdgeInsets.symmetric(

                  horizontal: 16,

                  vertical: 14,
                ),

                decoration: BoxDecoration(

                  color: Colors.green.shade50,

                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(

                    color: Colors.green.shade200,
                  ),
                ),

                child: Row(

                  children: [

                    const Icon(

                      Icons.verified_rounded,

                      color: Colors.green,

                      size: 26,
                    ),

                    const SizedBox(width: 12),

                    const Expanded(

                      child: Column(

                        crossAxisAlignment:

                        CrossAxisAlignment.start,

                        children: [

                          Text(

                            "Homework Review Completed",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                              fontSize: 15,

                              color: Colors.green,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(

                            "Students' homework has been reviewed successfully.",

                            style: TextStyle(

                              fontSize: 12,

                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



            /// STUDENTS LIST
            Expanded(
              child: Column(
                children: [

                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        0,
                        20,
                        20,
                      ),
                      itemCount: currentsectionstudents.length,
                      itemBuilder: (context, index) {

                        final student = currentsectionstudents[index];

                        return _buildStudentCard(
                          student: student,
                          name: student.fullName,
                          className: student.className,
                          section: "Section ${student.sectionName}",
                          image: student.profileImage,
                        );
                      },
                    ),
                  ),

                  if (!isReviewCompleted)
                    SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          10,
                          20,
                          20,
                        ),
                        child: AppPrimaryButton(
                          title: "Save Homework Review",
                          loading: isSaving,
                          onPressed: () {
                            saveHomeworkReview();

                            setState(() {

                              isReviewCompleted = true;


                            });

                          },
                        ),
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
}

