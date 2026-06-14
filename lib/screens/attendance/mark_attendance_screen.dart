import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/core/constants/app_colors.dart';

import '../../models/student_attendance_model.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String? selectedClass;

  String? selectedSection;

  DateTime selectedDate = DateTime.now();

  bool attendanceMarked = false;

  bool issearchTapped = false;

  bool markAbsentOnly = true;

  bool markPresentOnly = false;

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

  int get totalStudents => students.length;


  int get absentCount {
    if(markAbsentOnly){
      return students.where((e) => e.isAbsent).length;
    }
    else{
      return totalStudents - presentCount;
    }
  }

  int get presentCount {

    if (markAbsentOnly) {

      return totalStudents - absentCount;
    }

    return students
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

    return DropdownButtonFormField<String>(

      value: selectedSection,

      decoration: const InputDecoration(
        labelText: "Section",
        border: OutlineInputBorder(),
      ),

      items: const [

        DropdownMenuItem(
          value: "A",
          child: Text("Section A"),
        ),

        DropdownMenuItem(
          value: "B",
          child: Text("Section B"),
        ),
      ],

      onChanged: (value) {

        setState(() {

          selectedSection = value;
        });
      },
    );
  }

  Widget _buildDatePicker() {

    return InkWell(

      onTap: () async {

        final picked =
        await showDatePicker(

          context: context,

          initialDate: selectedDate,

          firstDate:
          DateTime(2025),

          lastDate:
          DateTime(2035),
        );

        if (picked != null) {

          setState(() {

            selectedDate = picked;
          });
        }
      },

      child: Container(

        width: double.infinity,

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(

          border: Border.all(
            color: Colors.grey.shade300,
          ),

          borderRadius:
          BorderRadius.circular(12),
        ),

        child: Text(
          selectedDate.toString().split(' ')[0],
        ),
      ),
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
      StudentAttendanceModel student,
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

                  student.name,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  "ID : ${student.id}",

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
          _buildClassDropdown(),

          const SizedBox(height: 12),

          _buildSectionDropdown(),

          const SizedBox(height: 12),

          _buildDatePicker(),

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

      itemCount: students.length,

      itemBuilder: (context,index) {

        final student =
        students[index];

        return _buildStudentTile(
          student,
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

              setState(() {

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



  @override
  Widget build(BuildContext context) {

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

                            label: const Text(

                              "Class 1",

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

                            label: const Text(

                              "Section B",

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

                            label: const Text(

                              "14-06-2026",

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
