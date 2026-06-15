import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/core/constants/app_colors.dart';

import '../../models/active_academic_year_response.dart';
import '../../models/student_attendance_model.dart';
import '../../models/students_response.dart';
import '../../services/academic_year_service.dart';
import '../../services/students_service.dart';

class MarkAttendanceScreen extends StatefulWidget {
  final String accessToken;

  const MarkAttendanceScreen({
    super.key,
    required this.accessToken,
  });

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String? selectedClass;

  String? selectedSections;

  DateTime selectedDate = DateTime.now();

  bool attendanceMarked = false;

  bool issearchTapped = false;

  bool markAbsentOnly = true;

  bool markPresentOnly = false;

  String? selectedAcademicYear;

  String? selectedClassroom;

  SectionData? selectedSection;

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
    if(markAbsentOnly){
      return currentsectionstudents.where((e) => e.isAbsent).length;
    }
    else{
      return totalStudents - presentCount;
    }
  }

  int get presentCount {

    if (markAbsentOnly) {

      return totalStudents - absentCount;
    }

    return currentsectionstudents
        .where((e) => e.isPresent)
        .length;
  }

  double get attendancePercentage {

    if (totalStudents == 0) {
      return 0;
    }

    return (presentCount / totalStudents) * 100;
  }
  Widget _buildClassDropdown() {

    return DropdownButtonFormField<String>(

      value: selectedClass,

      decoration: const InputDecoration(
        labelText: "Class",
        border: OutlineInputBorder(),
      ),

      items: const [

        DropdownMenuItem(
          value: "Class 1",
          child: Text("Class 1"),
        ),

        DropdownMenuItem(
          value: "Class 2",
          child: Text("Class 2"),
        ),
      ],

      onChanged: (value) {

        setState(() {

          selectedClass = value;
        });
      },
    );
  }

  Widget _buildSectionDropdown() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const Text(
          "Section",

          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5B6475),
          ),
        ),

        const SizedBox(height: 10),

        DropdownButtonFormField<SectionData>(

          value: selectedSection,

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFFDCE4F2),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFF2457FF),
              ),
            ),
          ),

          hint: const Text(
            "Select section",
          ),

          items: sections.map((section) {

            return DropdownMenuItem<SectionData>(

              value: section,

              child: Text(section.name),
            );

          }).toList(),

          onChanged: (value) {

            setState(() {

              selectedSection = value;
            });
          },
        ),
      ],
    );
  }


  Widget _buildStringDropdownField({

    required String label,

    required String hint,

    required List<String> items,

    required String? value,

    required Function(String?) onChanged,
  }) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          label,

          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5B6475),
          ),
        ),

        const SizedBox(height: 10),

        DropdownButtonFormField<String>(

          value: value,

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFFDCE4F2),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFF2457FF),
              ),
            ),
          ),

          hint: Text(hint),

          items: items.map((item) {

            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );

          }).toList(),

          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDateField() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const Text(
          "Attendance Date",

          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5B6475),
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: attendancecontroller,
          readOnly: true,

          decoration: InputDecoration(

            hintText: "Select Attendance Date",

            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
            ),

            filled: true,
            fillColor: Colors.white,

            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFFDCE4F2),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(18),

              borderSide: const BorderSide(
                color: Color(0xFF2457FF),
              ),
            ),
          ),

          onTap: () async {

            final pickedDate =
            await showDatePicker(

              context: context,

              initialDate: DateTime.now(),

              firstDate: DateTime(2000),

              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {

              attendancecontroller.text =
                  pickedDate
                      .toIso8601String()
                      .split("T")
                      .first;
            }
          },
        ),
      ],
    );
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
          if (student.isAbsent)

            Container(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),

              decoration: BoxDecoration(

                color: Colors.red.shade50,

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: const Text(

                "Absent",

                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),

          if(student.isPresent)
            Container(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),

              decoration: BoxDecoration(

                color: Colors.green.shade50,

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: const Text(

                "Present",

                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),

          const SizedBox(width: 8),

          /// CHECKBOX
          if(markAbsentOnly)
          Transform.scale(

            scale: 1.1,

            child: Checkbox(

              activeColor:
              Colors.red,

              value:
              student.isAbsent,

              onChanged: (value) {

                setState(() {

                  student.isAbsent =
                      value ?? false;
                });
              },
            ),
          ),
          if(markPresentOnly)
            Transform.scale(

              scale: 1.1,

              child: Checkbox(

                activeColor:
                Colors.green,

                value:
                student.isPresent,

                onChanged: (value) {

                  setState(() {

                    student.isPresent =
                        value ?? false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  void _saveAttendance() {
    Navigator.pop(context);

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(
        content: Text(
          "Attendance Saved",
        ),
      ),
    );
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

  Widget _buildAttendanceCard() {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          /// ACADEMIC YEAR
          _buildStringDropdownField(
            label: "Academic Year",

            value: selectedAcademicYear,

            hint: "Select academic year",

            items: academicYears
                .map((e) => e.name)
                .toList(),

            onChanged: (value) {

              setState(() {

                selectedAcademicYear = value;

                final year =
                academicYears.firstWhere(
                      (e) => e.name == value,
                );

                classrooms = year.classrooms;

                selectedClassroom = null;
                selectedSection = null;

                sections = [];
              });
            },
          ),

          const SizedBox(height: 10),

          /// CLASS
          _buildStringDropdownField(
            label: "Class",

            value: selectedClassroom,

            hint: "Select class",

            items: classrooms
                .map((e) => e.name)
                .toList(),

            onChanged: (value) {

              setState(() {

                selectedClassroom = value;

                final classroom =
                classrooms.firstWhere(
                      (e) => e.name == value,
                );

                sections =
                    classroom.sections;

                selectedSection = null;
              });
            },
          ),

          const SizedBox(height: 10),

          /// SECTION
          _buildSectionDropdown(),


          const SizedBox(height: 12),

          _buildDateField(),

          _buildSaveButton("Search Attendance"),
        ],
      ),
    );
  }

  Widget _buildMarkingMode() {

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

            child: RadioListTile<bool>(

              contentPadding: EdgeInsets.zero,

              value: true,

              groupValue: markAbsentOnly,

              title: const Text(
                "Mark Absent Only",
                style: TextStyle(fontSize: 13),
              ),

              onChanged: (value) {

                setState(() {

                  markAbsentOnly = true;
                  markPresentOnly = false;

                  /// CLEAR OLD PRESENT DATA
                  for (final student in students) {

                    student.isPresent = false;
                  }
                });
              },
            ),
          ),

          Expanded(

            child: RadioListTile<bool>(

              contentPadding: EdgeInsets.zero,

              value: false,

              groupValue: markAbsentOnly,

              title: const Text(
                "Mark Present Only",
                style: TextStyle(fontSize: 13),
              ),

              onChanged: (value) {

                setState(() {

                  markPresentOnly = true;
                  markAbsentOnly = false;

                  /// CLEAR OLD ABSENT DATA
                  for (final student in students) {

                    student.isAbsent = false;
                  }
                });
              },
            ),
          ),
        ],
      )
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

          onPressed: () {

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

              _saveAttendance();
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

    loadAcademicYear();
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
       currentsectionstudents = studentsList.where(
             (student) =>
         student.className == selectedClassroom &&
             student.sectionName == selectedSection?.name,
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
                    Visibility(
                      visible: issearchTapped,
                      child: Row(
                        children: [
                          Chip(

                            label: Text(

                              "$selectedClassroom",

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

                              "Section ${selectedSection?.name}",

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

                              "${attendancecontroller.text}",

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
                    ),
                    SizedBox(height: 10.0),

                    Visibility(
                      visible: !issearchTapped,
                        child: _buildAttendanceCard()
                    ),
                    Visibility(
                      visible: issearchTapped,
                      child: Row(

                        children: [

                          const Text(
                            "Attendance Marked",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),

                          Container(

                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(

                              color: attendanceMarked
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,

                              borderRadius:
                              BorderRadius.circular(20),
                            ),

                            child: Text(
                              attendanceMarked
                                  ? "Yes"
                                  : "No",
                            ),
                          ),
                          SizedBox(width: 5.0),

                          Visibility(
                            visible: attendanceMarked,
                            child: InkWell(
                              onTap: (){
                                HapticFeedback.lightImpact();
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),

                    Visibility(
                      visible: issearchTapped,
                        child: _buildSummaryCards()
                    ),
                  SizedBox(height: 10.0),

                  Visibility(
                    visible: !attendanceMarked && issearchTapped,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 5.0),

                        _buildMarkingMode(),

                       // const SizedBox(height: 16),

                       // _buildInfoBanner(),

                        const SizedBox(height: 16),

                        _buildStudentList(),

                        const SizedBox(height: 16),

                        _buildBottomSummary(),

                     //   const SizedBox(height: 90),

                        _buildSaveButton("Save Attendance"),
                      ],
                    ),
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
