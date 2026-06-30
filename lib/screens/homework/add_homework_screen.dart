import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../models/homework_model.dart';

import '../../services/homework_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/models/active_academic_year_response.dart';
import 'package:school_management_app/models/student_info_response.dart';
import '../../models/academic_year_response.dart';
import '../../models/subject_model.dart';
import '../../services/academic_year_service.dart';
import '../../services/section_service.dart';
import '../../widgets/app_dropdown_field.dart';
import '../../widgets/app_form_card.dart';
import '../../widgets/app_page_header.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/app_read_only_field.dart';
import '../../widgets/app_text_area.dart';
import '../../widgets/app_text_field.dart';
import '../../models/subject_model.dart';
import '../../services/subject_service.dart';

import '../../models/diary_entry_model.dart';
import '../../services/diary_service.dart';

class AddHomeworkScreen extends StatefulWidget {
  final String accessToken;
  final String className;
  final String sectionName;

  const AddHomeworkScreen({
    super.key,
    required this.accessToken,
    required this.className,
    required this.sectionName
  });

  @override
  State<AddHomeworkScreen> createState() => _AddHomeworkScreenState();
}

class _AddHomeworkScreenState extends State<AddHomeworkScreen> {

  final assignedDateController =
  TextEditingController();

  bool isLoading= true;
  bool isSaving = false;
  AcademicYearData? selectedAcademicYear;
  List<AcademicYearData> academicYears = [];
  List<ClassroomData> classrooms =[];
  ClassroomData? selectedClassroom;
  ActiveAcademicYearResponse? activeAcademicYear;
  final homeWorkTitleController = TextEditingController();
  final homeWorkDescriptionController = TextEditingController();
  List<SubjectModel> subjects = [];
  SubjectModel? selectedSubject;

  @override
  void initState(){
    assignedDateController.text =
        DateFormat(
          "dd-MM-yyyy",
        ).format(DateTime.now());
    super.initState();
    loadAcademicYears();
    loadActiveAcademicYear();
    loadSubjects();
  }

  Future<void> loadAcademicYears() async {

    final response =
    await AcademicYearService.getAcademicYears(

      accessToken: widget.accessToken,
    );

    setState(() {

      academicYears = response.academicYears;

      if (academicYears.isNotEmpty) {

        selectedAcademicYear =
            academicYears.firstWhere(

                  (e) => e.isActive,

              orElse: () => academicYears.first,
            );
      }

      isLoading = false;
    });
  }

  Future<void> loadActiveAcademicYear() async {

    try {

      final response =
      await AcademicYearService.getActiveAcademicYear(

        accessToken: widget.accessToken,
      );

      setState(() {

        activeAcademicYear = response;

        classrooms = response.classrooms;

        if (response.classrooms.isNotEmpty) {

          selectedClassroom =
              response.classrooms.first;
        }

        isLoading = false;

        print(classrooms.first.name);
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  Future<void> addHomework() async {

    if (selectedSubject == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please select Subject",
          ),
        ),
      );

      return;
    }

    if (homeWorkTitleController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please enter Homework Title",
          ),
        ),
      );

      return;
    }

    if (homeWorkDescriptionController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please enter Homework Description",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {

        isSaving = true;

      });

      final now = DateTime.now();

      final homework = HomeworkModel(

        id: const Uuid().v4(),

        subjectId: selectedSubject!.id,

        subjectName: selectedSubject!.name,

        title: homeWorkTitleController.text.trim(),

        description:
        homeWorkDescriptionController.text.trim(),

        academicYearId:
        activeAcademicYear!.id,

        academicYearName:
        activeAcademicYear!.name,

        classId:
        selectedClassroom!.id,

        className:
        selectedClassroom!.name,

        sectionId:
        "",

        sectionName:
        widget.sectionName,

        teacherId: "",

        teacherName: "",

        assignedDate:
       assignedDateController.text,

        dueDate: null,

        totalStudents: 0,

        submittedStudents: 0,

        pendingStudents: 0,

        isActive: true,

        createdAt: now,

        updatedAt: now,
      );

      await HomeworkService()

          .createHomework(

        homework: homework,
      );

      final diary = DiaryEntryModel(

        id: const Uuid().v4(),

        type: "homework",

        title: homework.title,

        description: homework.description,

        academicYearId: homework.academicYearId,

        className: homework.className,

        sectionName: homework.sectionName,

        subjectId: homework.subjectId,

        subjectName: homework.subjectName,

        teacherId: homework.teacherId,

        teacherName: homework.teacherName,

        referenceId: homework.id,

        entryDate: homework.assignedDate,

        isActive: true,

        createdAt: DateTime.now(),

        updatedAt: DateTime.now(),
      );

      await DiaryService().createDiaryEntry(

        diary: diary,
      );

      if (!mounted) return;

      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Homework added successfully",
          ),
        ),
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {

          isSaving = false;

        });
      }
    }
  }

  Future<void> loadSubjects() async {

    try {

      final response =
      await SubjectService.getSubjects();

      setState(() {

        subjects = response;
        selectedSubject = subjects.first;

      });

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(e.toString()),
        ),
      );
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

      backgroundColor: const Color(0xFFF7F9FC),

      body: SafeArea(

        child: Column(

          children: [

            const SizedBox(height: 10),


            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 18),

              child: AppPageHeader(

                title: "Homework",

                subtitle: "Create and manage Homeworks",

                icon: Icons.class_rounded,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                SizedBox(width: 10),
                Chip(

                  label: Text(

                    "2026-2027",

                    style: const TextStyle(
                      color: Colors.white,

                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  backgroundColor:
                  const Color(0xFF2457FF),

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

                    widget.className,

                    style: const TextStyle(
                      color: Colors.white,

                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  backgroundColor:
                  const Color(0xFF2457FF),

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

                    "Section ${widget.sectionName}",

                    style: TextStyle(
                      color: Colors.white,

                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  backgroundColor:
                  const Color(0xFF2457FF),

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

              ],
            ),

            SizedBox(height: 10),


            Expanded(

              child: SingleChildScrollView(


                padding: const EdgeInsets.symmetric(horizontal: 18),

                child: Column(

                  children: [

                    AppFormCard(

                      title: "Homework Information",

                      children: [

                        AppReadOnlyField(

                          label: "Assigned Date",

                          value: assignedDateController.text,

                          icon: Icons.calendar_today_outlined,

                        ),


                        AppDropdownField<SubjectModel>(
                          label: "Subject",

                          hint: "Select Subject",

                          icon: Icons.menu_book_rounded,

                          value: selectedSubject,

                          items: subjects.map((subject) {

                            return DropdownMenuItem<SubjectModel>(

                              value: subject,

                              child: Text(subject.name),
                            );

                          }).toList(),

                          onChanged: (value) {

                            setState(() {

                              selectedSubject = value;

                            });
                          },
                        ),

                        const SizedBox(height: 10),

                        AppTextField(

                          label: "Home Work title",

                          hint: "Enter Homework title",

                          icon: Icons.school_outlined,

                          controller: homeWorkTitleController,
                        ),

                        const SizedBox(height: 10),

                        AppTextArea(

                          label: "Homework Description",

                          hint:
                          "Describe the homework to be completed...",

                          icon: Icons.description_outlined,

                          controller:
                          homeWorkDescriptionController,

                          maxLines: 6,

                          maxLength: 500,
                        ),


                      ],
                    ),

                    const SizedBox(height: 28),

                    AppPrimaryButton(

                      title: "Add Homework",

                      loading: isSaving,

                      onPressed: () {

                        HapticFeedback.lightImpact();
                        addHomework();
                      },
                    ),

                    const SizedBox(height: 25),


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
