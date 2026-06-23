import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:school_management_app/core/constants/app_colors.dart';
import 'package:school_management_app/models/section_with_class.dart';

import '../../models/active_academic_year_response.dart';
import '../../models/student_attendance_model.dart';
import '../../models/students_response.dart';
import '../../services/academic_year_service.dart';
import '../../services/firebase_attendance_service.dart';
import '../../services/students_service.dart';

class MarkAttendanceScreen extends StatefulWidget {

  final String accessToken;
  final SectionWithClass section;
  final DateTime attendanceDate;
  const MarkAttendanceScreen({
    super.key,
    required this.accessToken,
    required this.section,
    required this.attendanceDate
  });


  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {

  bool get isAttendanceAlreadyCaptured {

    if (attendanceSession == "FN") {
      return widget.section.fnCaptured;
    }

    return widget.section.anCaptured;
  }

  bool isEditMode = false;

  String? selectedClass;

  String? selectedSections;

  DateTime selectedDate = DateTime.now();

  bool attendanceMarked = false;

  bool issearchTapped = false;

  String attendanceSession = "FN";

  String? selectedClassroom;

  List<ClassroomData> classrooms = [];

  List<SectionData> sections = [];

  List<ActiveAcademicYearResponse> academicYears = [];

  bool isLoading = true;

  final attendancecontroller =
  TextEditingController();

  List<StudentData> filteredStudents = [];
  List<StudentData> studentsList = [];
  List<StudentData> currentsectionstudents =[];
  StudentsResponse? studentsResponse;


  List<StudentAttendanceModel> students = [

    StudentAttendanceModel(
      id: "1",
      name: "Arjun Kumar",
    ),

    StudentAttendanceModel(
      id: "2",
      name: "Sai Teja",
    ),

    StudentAttendanceModel(
      id: "3",
      name: "Pranavi",
    ),

    StudentAttendanceModel(
      id: "4",
      name: "Samhitha",
    ),

    StudentAttendanceModel(
      id: "5",
      name: "Venkata Sai",
    ),

    StudentAttendanceModel(
      id: "6",
      name: "Harsha Vardhan",
    ),

    StudentAttendanceModel(
      id: "7",
      name: "Akhil Kumar",
    ),

    StudentAttendanceModel(
      id: "8",
      name: "Nikhil Reddy",
    ),

    StudentAttendanceModel(
      id: "9",
      name: "Bhavya Sri",
    ),

    StudentAttendanceModel(
      id: "10",
      name: "Keerthana",
    ),

    StudentAttendanceModel(
      id: "11",
      name: "Manoj Kumar",
    ),

    StudentAttendanceModel(
      id: "12",
      name: "Rohith",
    ),

    StudentAttendanceModel(
      id: "13",
      name: "Likitha",
    ),

    StudentAttendanceModel(
      id: "14",
      name: "Charan Teja",
    ),

    StudentAttendanceModel(
      id: "15",
      name: "Poojitha",
    ),
  ];

  int get totalStudents => currentsectionstudents.length;


  int get absentCount {

    return totalStudents - presentCount;
  }

  int get presentCount {

    if (attendanceSession == "FN") {

      return currentsectionstudents
          .where((e) => e.isFnPresent)
          .length;
    }

    return currentsectionstudents
        .where((e) => e.isAnPresent)
        .length;
  }

  double get attendancePercentage {

    if (totalStudents == 0) {
      return 0;
    }

    return (presentCount / totalStudents) * 100;
  }

  Widget _buildSummaryCards() {

    return Row(

      children: [

        Expanded(
          child: _summaryCard(
            "Total",
            totalStudents.toString(),
            Colors.blue,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _summaryCard(
            "Present",
            presentCount.toString(),
            Colors.green,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _summaryCard(
            "Absent",
            absentCount.toString(),
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _summaryCard(
      String title,
      String value,
      Color color,
      ) {

    return Container(

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: color.withOpacity(0.08),

        borderRadius:
        BorderRadius.circular(16),
      ),

      child: Column(

        children: [

          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          Text(title),
        ],
      ),
    );
  }

  Widget _buildStudentTile(
      StudentData student,
      int id
      ) {

    final isPresent =
    attendanceSession == "FN"
        ? student.isFnPresent
        : student.isAnPresent;

    return Container(

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE9EEF9),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(

        children: [

          /// PROFILE ICON
          Container(

            height: 50,
            width: 50,

            decoration: const BoxDecoration(
              color: Color(0xFFEFF4FF),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.person_rounded,
              color: Color(0xFF2457FF),
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          /// STUDENT DETAILS
          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  student.fullName,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  "ID : ${id}",

                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF667085),
                  ),
                ),
              ],
            ),
          ),

          /// STATUS LABEL
          /// Container(
          //
          //     padding: const EdgeInsets.symmetric(
          //     horizontal: 10,
          //     vertical: 5,
          //     ),
          //
          //     decoration: BoxDecoration(
          //
          //     color: isPresent
          //     ? Colors.green.shade50
          //         : Colors.red.shade50,
          //
          //     borderRadius:
          //     BorderRadius.circular(20),
          //     ),
          //
          //     child: Text(
          //
          //     isPresent
          //     ? "Present"
          //         : "Absent",
          //
          //     style: TextStyle(
          //
          //     color: isPresent
          //     ? Colors.green
          //         : Colors.red,
          //
          //     fontWeight: FontWeight.w600,
          //     fontSize: 11,
          //     ),
          //     ),
          //     ),




          /// CHECKBOX
          GestureDetector(

            onTap: () {

              setState(() {

                if (attendanceSession == "FN") {

                  student.isFnPresent =
                  !student.isFnPresent;

                } else {

                  student.isAnPresent =
                  !student.isAnPresent;
                }
              });
            },

            child: Container(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),

              decoration: BoxDecoration(

                color: isPresent
                    ? const Color(0xFF22C55E)
                    : const Color(0xFFEF4444),

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Row(

                mainAxisSize: MainAxisSize.min,

                children: [

                  Icon(

                    isPresent
                        ? Icons.check
                        : Icons.close,

                    color: Colors.white,
                    size: 16,
                  ),

                  const SizedBox(width: 4),

                  Text(

                    isPresent
                        ? "Present"
                        : "Absent",

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
    );
  }

  Future<void> _saveAttendance() async {

    try {

      setState(() {

        isLoading = true;
      });

      await FirebaseAttendanceService()
          .saveAttendance(

        className:
        widget.section.className,

        sectionName:
        widget.section.section.name,

        attendanceDate:
        widget.attendanceDate,

        session:
        attendanceSession,

        students:
        currentsectionstudents,
      );

      setState(() {

        if (attendanceSession == "FN") {

          widget.section.fnCaptured =
          true;
        }

        if (attendanceSession == "AN") {

          widget.section.anCaptured =
          true;
        }

        isEditMode = false;

        isLoading = false;
      });

      Navigator.pop(
        context,
        widget.section.fnCaptured || widget.section.anCaptured,
      );

    } catch (e) {

      setState(() {

        isLoading = false;
      });

      print(e);
    }
  }

  Widget _buildHeader() {

    return Padding(

      padding: const EdgeInsets.all(10),

      child: Row(

        children: [

          CircleAvatar(

            backgroundColor: Colors.white,

            child: IconButton(

              icon:
              const Icon(Icons.arrow_back),

              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  "Mark Attendance",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Select class, section and mark",
                ),
              ],
            ),
          ),

          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionSelector() {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Row(

        children: [

          Expanded(

            child: RadioListTile<String>(

              contentPadding:
              EdgeInsets.zero,

              value: "FN",

              groupValue:
              attendanceSession,

              title: const Text(
                "Forenoon",
              ),

              onChanged: (value) {

                setState(() {

                  attendanceSession =
                  value!;
                  isEditMode = false;
                });
              },
            ),
          ),

          Expanded(

            child: RadioListTile<String>(

              contentPadding:
              EdgeInsets.zero,

              value: "AN",

              groupValue:
              attendanceSession,

              title: const Text(
                "Afternoon",
              ),

              onChanged: (value) {

                setState(() {

                  attendanceSession =
                  value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildInfoBanner() {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.blue.shade50,

        borderRadius:
        BorderRadius.circular(20),
      ),

      child: const Text(

        "If you mark only absent students, all others will be considered present automatically.",
      ),
    );
  }
  Widget _buildStudentList() {

    return ListView.builder(

      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      itemCount: currentsectionstudents.length,

      itemBuilder: (context,index) {

        final student =
        currentsectionstudents[index];

        return _buildStudentTile(
          student, index+1
        );
      },
    );
  }

  Widget _buildBottomSummary() {

    return Container(

      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Row(

        children: [

          Expanded(
            child: Text(
              "Absent : $absentCount",
            ),
          ),

          Expanded(
            child: Text(
              "Present : $presentCount",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(String buttonText) {

    return Padding(

      padding: const EdgeInsets.all(16),

      child: SizedBox(

        width: double.infinity,
        height: 58,

        child: ElevatedButton.icon(

          style: ElevatedButton.styleFrom(

            backgroundColor:
            const Color(0xFF2457FF),

            foregroundColor:
            Colors.white,

            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(18),
            ),

            padding:
            const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),

          onPressed: () async {

            if (buttonText ==
                "Search Attendance") {
              loadStudents();

              setState(() {
                isLoading = true;
                issearchTapped = true;
              });
            }

            if (buttonText ==
                "Save Attendance") {

              await _saveAttendance();
            }
          },

          icon: Icon(

            buttonText ==
                "Search Attendance"

                ? Icons.search_rounded
                : Icons.save_rounded,

            size: 22,
          ),

          label: Text(

            buttonText,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }

  void initState() {

    super.initState();

    if (widget.section.fnCaptured &&
        !widget.section.anCaptured) {

      attendanceSession = "AN";
    }

    else if (!widget.section.fnCaptured &&
        widget.section.anCaptured) {

      attendanceSession = "FN";
    }

    else {

      attendanceSession = "FN";
    }

    loadAcademicYear();

    loadStudents();

    selectedClassroom =
        widget.section.className;

    attendancecontroller.text =
        DateFormat(
          'dd MMM yyyy',
        ).format(
          widget.attendanceDate,
        );
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

      print(widget);

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
        response.students.first.parentName,
      );

     setState(() {
       currentsectionstudents = studentsList.where(
             (student) =>
         student.className == selectedClassroom &&
             student.sectionName == widget.section.section.name,
       ).toList();
     });
     print("current section students are ");
     print(currentsectionstudents);

    } catch (e) {

      print(
        "STUDENTS API ERROR",
      );

      print(e);

      print(widget.accessToken);

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildAttendanceToggle({

    required bool isPresent,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: AnimatedContainer(

        duration:
        const Duration(
          milliseconds: 250,
        ),

        height: 40,
        width: 110,

        padding:
        const EdgeInsets.all(4),

        decoration: BoxDecoration(

          color: isPresent
              ? const Color(0xFF22C55E)
              : const Color(0xFFEF4444),

          borderRadius:
          BorderRadius.circular(
              25),

          boxShadow: [

            BoxShadow(

              color:
              (isPresent
                  ? const Color(
                  0xFF22C55E)
                  : const Color(
                  0xFFEF4444))
                  .withOpacity(
                  0.25),

              blurRadius: 12,

              offset:
              const Offset(0, 4),
            ),
          ],
        ),

        child: AnimatedAlign(

          duration:
          const Duration(
            milliseconds: 250,
          ),

          alignment: isPresent
              ? Alignment.centerLeft
              : Alignment.centerRight,

          child: Container(

            width: 60,

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(
                  20),
            ),

            child: Row(

              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                Icon(

                  isPresent
                      ? Icons.check_circle
                      : Icons.cancel,

                  size: 16,

                  color: isPresent
                      ? const Color(
                      0xFF22C55E)
                      : const Color(
                      0xFFEF4444),
                ),

                const SizedBox(width: 4),

                Text(

                  isPresent
                      ? "P"
                      : "A",

                  style: TextStyle(

                    fontWeight:
                    FontWeight.bold,

                    color: isPresent
                        ? const Color(
                        0xFF22C55E)
                        : const Color(
                        0xFFEF4444),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceBody() {

    /// FN already captured

    if (attendanceSession == "FN" &&
        widget.section.fnCaptured &&
        !isEditMode) {

      return buildAttendanceCapturedCard(
        "Forenoon",
      );
    }

    /// AN already captured

    if (attendanceSession == "AN" &&
        widget.section.anCaptured &&
        !isEditMode) {

      return buildAttendanceCapturedCard(
        "Afternoon",
      );
    }

    /// Show student list

    return _buildStudentList();
  }

  Widget buildAttendanceCapturedCard(
      String session,
      ) {

    return Container(

      width: double.infinity,

      padding:
      const EdgeInsets.all(24),

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(30),

        gradient: const LinearGradient(

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

          colors: [

            Color(0xFF2457FF),

            Color(0xFF4B7BFF),
          ],
        ),

        boxShadow: [

          BoxShadow(

            color: const Color(
              0xFF2457FF,
            ).withOpacity(0.25),

            blurRadius: 24,

            offset: const Offset(
              0,
              10,
            ),
          ),
        ],
      ),

      child: Column(

        children: [

          Container(

            height: 70,
            width: 70,

            decoration: BoxDecoration(

              color:
              Colors.white
                  .withOpacity(
                0.15,
              ),

              shape:
              BoxShape.circle,
            ),

            child: const Icon(

              Icons.check_circle,

              color: Colors.white,

              size: 42,
            ),
          ),

          const SizedBox(height: 18),

          const Text(

            "Attendance Captured",

            style: TextStyle(

              color: Colors.white,

              fontSize: 22,

              fontWeight:
              FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),

          SizedBox(

            width:
            double.infinity,

            child: ElevatedButton.icon(

              onPressed: () async {

                await loadCapturedAttendance();

                setState(() {

                  isEditMode = true;
                });
              },

              style:
              ElevatedButton.styleFrom(

                backgroundColor:
                Colors.white,

                foregroundColor:
                const Color(
                  0xFF2457FF,
                ),

                elevation: 0,

                shape:
                RoundedRectangleBorder(

                  borderRadius:
                  BorderRadius.circular(
                      16),
                ),
              ),

              icon: const Icon(
                Icons.edit_outlined,
              ),

              label: const Text(
                "Edit Attendance",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadCapturedAttendance() async {

    try {

      setState(() {

        isLoading = true;
      });

      final studentsData =

      await FirebaseAttendanceService()
          .getAttendanceStudents(

        className:
        widget.section.className,

        sectionName:
        widget.section.section.name,

        attendanceDate:
        widget.attendanceDate,
      );

      if (studentsData == null) {

        setState(() {

          isLoading = false;
        });

        return;
      }

      for (final student
      in currentsectionstudents) {

        final firebaseStudent =

        studentsData[
        student.id.toString()
        ];

        if (firebaseStudent == null) {
          continue;
        }

        student.isFnPresent =

            firebaseStudent[
            "fnPresent"] ??
                false;

        student.isAnPresent =

            firebaseStudent[
            "anPresent"] ??
                false;
      }

      setState(() {

        isLoading = false;
      });

    } catch (e) {

      print(
        "Load Attendance Error: $e",
      );

      setState(() {

        isLoading = false;
      });
    }
  }





  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(

        child: Column(

          children: [

            _buildHeader(),


            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    Row(
                      children: [
                        Chip(

                          label: Text(

                            widget.section.className,

                            style: const TextStyle(

                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),

                          backgroundColor:
                          const Color(0xFFEFF4FF),

                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),

                          shape: RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(30),

                            side: const BorderSide(
                              color: Color(0xFFD6E4FF),
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Chip(

                          label: Text(

                            "Section ${widget.section.section.name}",

                            style: TextStyle(

                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),

                          backgroundColor:
                          const Color(0xFFEFF4FF),

                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),

                          shape: RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(30),

                            side: const BorderSide(
                              color: Color(0xFFD6E4FF),
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Chip(

                          label: Text(

                            attendancecontroller.text,

                            style: const TextStyle(

                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),

                          backgroundColor:
                          const Color(0xFFEFF4FF),

                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),

                          shape: RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(30),

                            side: const BorderSide(
                              color: Color(0xFFD6E4FF),
                              width: 1,
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            HapticFeedback.lightImpact();
                            setState(() {
                              issearchTapped = false;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(

                                color: attendanceMarked
                                    ? Colors.green.shade50
                                    : Colors.white,

                                borderRadius:
                                BorderRadius.circular(20),
                              ),

                              child:Icon(Icons.edit,
                                  size: 20
                              )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(

                      children: [

                        const Text(
                          "Capture Attendance",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    _buildSummaryCards(),

                  SizedBox(height: 10.0),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 5.0),

                      _buildSessionSelector(),

                     // const SizedBox(height: 16),

                     // _buildInfoBanner(),

                      const SizedBox(height: 16),

                      if (isAttendanceAlreadyCaptured &&
                          !isEditMode)

                        buildAttendanceCapturedCard(
                            attendanceSession == "AN"
                                ? "Afternoon"
                                : "Forenoon"
                        )

                      else ...[


                        _buildStudentList(),

                        const SizedBox(height: 10),

                        _buildBottomSummary(),

                        const SizedBox(height: 16),

                        _buildSaveButton("Save Attendance"),
                      ]
                    ],
                  )

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
