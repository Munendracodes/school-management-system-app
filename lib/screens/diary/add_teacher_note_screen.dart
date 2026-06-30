import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/models/active_academic_year_response.dart';
import '../../models/academic_year_response.dart';
import '../../models/subject_model.dart';
import '../../services/academic_year_service.dart';
import '../../services/diary_service.dart';
import '../../widgets/app_form_card.dart';
import '../../widgets/app_page_header.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/app_read_only_field.dart';
import '../../widgets/app_text_area.dart';
import '../../widgets/app_text_field.dart';


class AddTeacherNoteScreen extends StatefulWidget {
  final String accessToken;
  final String className;
  final String sectionName;

  const AddTeacherNoteScreen({
    super.key,
    required this.accessToken,
    required this.className,
    required this.sectionName
  });

  @override
  State<AddTeacherNoteScreen> createState() => _AddTeacherNoteScreenState();
}

class _AddTeacherNoteScreenState extends State<AddTeacherNoteScreen> {

  final assignedDateController =
  TextEditingController();

  final noteTitleController =
  TextEditingController();

  bool isLoading= true;
  bool isSaving = false;
  ActiveAcademicYearResponse? activeAcademicYear;
  final teacherNotesController = TextEditingController();


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

        isLoading = false;

      });

    } catch (e) {

      setState(() {

        isLoading = false;

      });
    }
  }

  Future<void> addTeacherNote() async {

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

    if (teacherNotesController.text.trim().isEmpty) {

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

      await DiaryService().createTeacherNote(

        academicYearId: activeAcademicYear!.id,

        className: widget.className,

        sectionName: widget.sectionName,

        title: noteTitleController.text.trim(),

        description: teacherNotesController.text.trim(),

        teacherId: "",

        teacherName: "",

        entryDate: assignedDateController.text,
      );

      if (!mounted) return;

      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Teacher note added successfully.",
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

                title: "Teacher Notes",

                subtitle: "Create and manage Teacher Notes",

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

                      title: "Teacher Note",

                      children: [

                        AppReadOnlyField(

                          label: "Assigned Date",

                          value: assignedDateController.text,

                          icon: Icons.calendar_today_outlined,

                        ),

                        const SizedBox(height: 10),

                        AppTextField(

                          label: "Title",

                          hint: "Enter Note Title",

                          icon: Icons.title,

                          controller: noteTitleController,
                        ),

                        SizedBox(height: 10),

                        AppTextArea(

                          label: "Teacher Notes",

                          hint:
                          "Describe the Teacher Notes",

                          icon: Icons.description_outlined,

                          controller:
                          teacherNotesController,

                          maxLines: 6,

                          maxLength: 500,
                        ),


                      ],
                    ),

                    const SizedBox(height: 28),

                    AppPrimaryButton(

                      title: "Add Teacher Notes",

                      loading: isSaving,

                      onPressed: () {

                        HapticFeedback.lightImpact();

                        addTeacherNote();

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
