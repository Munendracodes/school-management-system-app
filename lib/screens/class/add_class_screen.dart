import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/services/class_room_service.dart';

import '../../models/academic_year_response.dart';
import '../../services/academic_year_service.dart';
import '../../widgets/app_dropdown_field.dart';
import '../../widgets/app_form_card.dart';
import '../../widgets/app_page_header.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/app_text_field.dart';

class AddClassScreen extends StatefulWidget {

  final String accessToken;
  const AddClassScreen({
    super.key,
    required this.accessToken
  });

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final classNameController =
  TextEditingController();

  AcademicYearData? selectedAcademicYear;

  List<AcademicYearData> academicYears = [];

  bool isLoading = true;

  bool isSaving = false;

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

  Future<void> createClass() async {

    if (classNameController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please enter Class Name",
          ),
        ),
      );

      return;
    }

    if (selectedAcademicYear == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please select Academic Year",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {

        isSaving = true;

      });

      await ClassroomService.createClassroom(

        accessToken: widget.accessToken,

        name: classNameController.text.trim(),

        academicYearId: selectedAcademicYear!.id,
      );

      if (!mounted) return;

      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(

            content: Text(
              "${classNameController.text} added successfully",
            ),
          )
      );

    } catch (e) {

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
  void initState(){
    super.initState();
    loadAcademicYears();
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

                title: "Class",

                subtitle: "Create and manage classes",

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

                      title: "Class Information",

                      children: [

                        AppDropdownField<AcademicYearData>(

                          label: "Academic Year",

                          icon: Icons.calendar_month_rounded,

                          value: selectedAcademicYear,

                          hint: "Select Academic Year",

                          items: academicYears.map((year) {

                            return DropdownMenuItem<AcademicYearData>(

                              value: year,

                              child: Row(

                                children: [

                                  Expanded(
                                    child: Text(year.name),
                                  ),

                                  if (year.isActive)

                                    Container(

                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),

                                      decoration: BoxDecoration(

                                        color: Colors.green.shade100,

                                        borderRadius: BorderRadius.circular(20),
                                      ),

                                      child: const Text(

                                        "ACTIVE",

                                        style: TextStyle(

                                          color: Colors.green,

                                          fontWeight: FontWeight.bold,

                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );

                          }).toList(),

                          onChanged: (AcademicYearData? value) {

                            setState(() {
                              selectedAcademicYear = value;
                            });

                          },
                        ),

                        const SizedBox(height: 20),

                        AppTextField(

                          label: "Class Name",

                          hint: "Enter Class Name",

                          icon: Icons.school_outlined,

                          controller: classNameController,
                        ),




                      ],
                    ),

                    const SizedBox(height: 28),

                    AppPrimaryButton(

                      title: "Create Class",

                      loading: isSaving,

                      onPressed: () {

                       HapticFeedback.lightImpact();
                       createClass();
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
