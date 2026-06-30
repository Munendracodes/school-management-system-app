import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/circular_class_option.dart';
import 'package:school_management_app/models/active_academic_year_response.dart';
import '../../models/academic_year_response.dart';
import '../../models/subject_model.dart';
import '../../services/academic_year_service.dart';
import '../../services/diary_service.dart';
import '../../widgets/app_dropdown_field.dart';
import '../../widgets/app_form_card.dart';
import '../../widgets/app_page_header.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/app_read_only_field.dart';
import '../../widgets/app_text_area.dart';
import '../../widgets/app_text_field.dart';


class SchoolCircularScreen extends StatefulWidget {
  final String accessToken;
  final String className;
  final String sectionName;

  const SchoolCircularScreen({
    super.key,
    required this.accessToken,
    required this.className,
    required this.sectionName
  });

  @override
  State<SchoolCircularScreen> createState() => _SchoolCircularScreenState();
}

class _SchoolCircularScreenState extends State<SchoolCircularScreen> {

  final assignedDateController =
  TextEditingController();

  final noteTitleController =
  TextEditingController();

  bool isLoading= true;
  bool isSaving = false;
  ActiveAcademicYearResponse? activeAcademicYear;
  List<CircularClassOption> classOptions = [];
  CircularClassOption? selectedClass;
  final schoolCircularController = TextEditingController();


  @override
  void initState(){
    assignedDateController.text =
        DateFormat(
          "dd-MM-yyyy",
        ).format(DateTime.now());
    super.initState();
    loadActiveAcademicYear();

  }

  Future<void> loadActiveAcademicYear() async {

    try {

      final response =
      await AcademicYearService.getActiveAcademicYear(

        accessToken: widget.accessToken,
      );

      setState(() {

        activeAcademicYear = response;

        classOptions = [

          const CircularClassOption(

            name: "All Classes",

            isAllClasses: true,
          ),

          CircularClassOption(

            name: widget.className,
          ),
        ];

        selectedClass = classOptions.first;

        isLoading = false;

      });

    } catch (e) {

      setState(() {

        isLoading = false;

      });
    }
  }

  Future<void> addSchoolCircular() async {

    if (noteTitleController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please enter note title",
          ),
        ),
      );

      return;
    }

    if (schoolCircularController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please enter teacher note",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {

        isSaving = true;

      });

      if (selectedClass!.isAllClasses) {

        for (final classroom
        in activeAcademicYear!.classrooms) {

          await DiaryService().createSchoolCircular(

            academicYearId: activeAcademicYear!.id,

            className: classroom.name,

            sectionName: "ALL",

            title: noteTitleController.text.trim(),

            description:
            schoolCircularController.text.trim(),

            teacherId: "",

            teacherName: "",

            entryDate:
            assignedDateController.text,
          );
        }

      } else {

        await DiaryService().createSchoolCircular(

          academicYearId: activeAcademicYear!.id,

          className: widget.className,

          sectionName: widget.sectionName,

          title: noteTitleController.text.trim(),

          description:
          schoolCircularController.text.trim(),

          teacherId: "",

          teacherName: "",

          entryDate:
          assignedDateController.text,
        );
      }

      if (!mounted) return;

      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "School Circular added successfully.",
          ),
        ),
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(
            e.toString(),
          ),
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

                title: "School Circular",

                subtitle: "Create and manage Circular",

                icon: Icons.class_rounded,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                SizedBox(width: 10),
                Chip(

                  label: Text(

                    activeAcademicYear?.name ?? "",

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

                SizedBox(width: 5.0),
                if (!(selectedClass?.isAllClasses ?? false))

                  Chip(

                    label: Text(

                      "Section ${widget.sectionName}",

                      style: const TextStyle(

                        color: Colors.white,

                        fontWeight: FontWeight.w600,

                        fontSize: 14,
                      ),
                    ),

                    backgroundColor: const Color(0xFF2457FF),

                    padding: const EdgeInsets.symmetric(

                      horizontal: 8,

                      vertical: 4,
                    ),

                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(30),

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

                      title: "School Circular",

                      children: [

                        AppReadOnlyField(

                          label: "Assigned Date",

                          value: assignedDateController.text,

                          icon: Icons.calendar_today_outlined,

                        ),

                        const SizedBox(height: 10),

                        AppDropdownField<CircularClassOption>(

                          label: "Class",

                          hint: "Select Class",

                          icon: Icons.school_outlined,

                          value: selectedClass,

                          items: classOptions.map((item) {

                            return DropdownMenuItem<CircularClassOption>(

                              value: item,

                              child: Text(item.name),
                            );

                          }).toList(),

                          onChanged: (value) {

                            setState(() {

                              selectedClass = value;

                            });

                          },
                        ),

                        SizedBox(height: 10),

                        AppTextField(

                          label: "Title",

                          hint: "Enter Note Title",

                          icon: Icons.title,

                          controller: noteTitleController,
                        ),

                        SizedBox(height: 10),

                        AppTextArea(

                          label: "School Circular",

                          hint:
                          "Describe the School Circular",

                          icon: Icons.description_outlined,

                          controller:
                          schoolCircularController,

                          maxLines: 6,

                          maxLength: 500,
                        ),


                      ],
                    ),

                    const SizedBox(height: 28),

                    AppPrimaryButton(

                      title: "Add School Circular",

                      loading: isSaving,

                      onPressed: () {

                        HapticFeedback.lightImpact();
                        addSchoolCircular();



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
