import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/models/active_academic_year_response.dart';
import 'package:school_management_app/models/student_info_response.dart';
import '../../models/academic_year_response.dart';
import '../../services/academic_year_service.dart';
import '../../services/section_service.dart';
import '../../widgets/app_dropdown_field.dart';
import '../../widgets/app_form_card.dart';
import '../../widgets/app_page_header.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/app_read_only_field.dart';
import '../../widgets/app_text_field.dart';

class AddSectionScreen extends StatefulWidget {
  final String accessToken;

  const AddSectionScreen({
    super.key,
    required this.accessToken
  });

  @override
  State<AddSectionScreen> createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  bool isLoading= true;
  bool isSaving = false;
  AcademicYearData? selectedAcademicYear;
  List<AcademicYearData> academicYears = [];
  List<ClassroomData> classrooms =[];
  ClassroomData? selectedClassroom;
  ActiveAcademicYearResponse? activeAcademicYear;
  final sectionNameController = TextEditingController();

  @override
  void initState(){
    super.initState();
    loadAcademicYears();
    loadActiveAcademicYear();

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

  Future<void> createSection() async {

    if (sectionNameController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please enter Section Name",
          ),
        ),
      );

      return;
    }

    if (selectedClassroom == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please select Class",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {

        isSaving = true;

      });

      await SectionService.createSection(

        accessToken: widget.accessToken,

        sectionName:
        sectionNameController.text.trim(),

        classroomId:
        selectedClassroom!.id,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Section ${sectionNameController.text} added successfully"))
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

                title: "Section",

                subtitle: "Create and manage sections",

                icon: Icons.class_rounded,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(horizontal: 18),

                child: Column(

                  children: [

                    AppFormCard(

                      title: "Section Information",

                      children: [

                        AppReadOnlyField(

                          label: "Academic Year",

                          value: activeAcademicYear?.name ?? "",

                          icon: Icons.calendar_month_rounded,

                          badge: "ACTIVE",
                        ),

                        const SizedBox(height: 10),

                        AppDropdownField<ClassroomData>(

                          label: "Class",

                          hint: "Select Class",

                          icon: Icons.school_outlined,

                          value: selectedClassroom,

                          items:classrooms.map((classroom) {

                            return DropdownMenuItem<ClassroomData>(

                              value: classroom,

                              child: Text(classroom.name),
                            );

                          }).toList(),

                          onChanged: (ClassroomData? value) {

                            setState(() {

                              selectedClassroom = value;

                            });
                          },
                        ),

                        const SizedBox(height: 10),

                        AppTextField(

                          label: "Section Name",

                          hint: "Enter Section Name",

                          icon: Icons.school_outlined,

                          controller: sectionNameController,
                        ),

                      ],
                    ),

                    const SizedBox(height: 28),

                    AppPrimaryButton(

                      title: "Create Section",

                      loading: isSaving,

                      onPressed: () {

                        HapticFeedback.lightImpact();
                        createSection();
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
