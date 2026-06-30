import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/screens/diary/add_teacher_note_screen.dart';
import 'package:school_management_app/screens/diary/add_school_circular_screen.dart';
import '../../models/active_academic_year_response.dart';
import '../../models/diary_entry_model.dart';
import '../../services/academic_year_service.dart';
import '../../services/diary_service.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/dairy_header.dart';
import '../../widgets/diar_date_navigation.dart';
import '../../widgets/diary_date_card.dart';
import '../../widgets/diary_section.dart';
import '../../widgets/home_work_item.dart';
import '../../widgets/homework_date_selector.dart';
import '../../widgets/school_circular_card.dart';
import '../../widgets/teacher_note_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DiaryScreen extends StatefulWidget {

  final String accessToken;

  final String className;

  final String sectionName;

  const DiaryScreen({

    super.key,

    required this.accessToken,

    required this.className,

    required this.sectionName,
  });

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  DateTime selectedDate = DateTime.now();

  bool isLoading = true;

  ActiveAcademicYearResponse? activeAcademicYear;

  List<DiaryEntryModel> diaryEntries = [];

  List<DiaryEntryModel> homeworkEntries = [];

  List<DiaryEntryModel> teacherNotes = [];

  List<DiaryEntryModel> circulars = [];

  @override
  void initState() {

    super.initState();

    loadDiary();
  }

  Future<void> loadDiary() async {

    try {

      final response =
      await AcademicYearService.getActiveAcademicYear(

        accessToken: widget.accessToken,
      );

      activeAcademicYear = response;

      diaryEntries =
      await DiaryService().getDiaryEntries(

        academicYearId: response.id,

        className: widget.className,

        sectionName: widget.sectionName,

        date: selectedDate,
      );

      homeworkEntries = diaryEntries.where(

            (e) => e.type == "homework",

      ).toList();

      teacherNotes = diaryEntries.where(

            (e) => e.type == "teacherNote",

      ).toList();

      circulars = diaryEntries.where(

            (e) => e.type == "circular",

      ).toList();

      if (!mounted) return;

      setState(() {

        isLoading = false;

      });

    } catch (e) {

      if (!mounted) return;

      setState(() {

        isLoading = false;

      });

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

      backgroundColor: const Color(0xFFF5F8FF),

      body: SafeArea(

      child: SingleChildScrollView(

      child: Column(

      children: [

      /// HEADER
      DiaryHeader(

      className:

        "${widget.className} • ${widget.sectionName}",

      onBack: () {

        Navigator.pop(context);

      },

      onCalendar: () {},
    ),



    /// DATE CARD
           /*  DiaryDateCard(

    selectedDate: selectedDate,
          ),*/

    /// DATE NAVIGATION
    HomeworkDateSelector(

      selectedColor: AppColors.primaryBlue,

      selectedDate: selectedDate,

      onPrevious: () {

        setState(() {

          selectedDate = selectedDate.subtract(

            const Duration(days: 1),
          );
        });

        loadDiary();
      },

      onNext: () {

        setState(() {

          selectedDate = selectedDate.add(

            const Duration(days: 1),
          );
        });

        loadDiary();
      },

      onPickDate: () async {

        final picked = await showDatePicker(

          context: context,

          initialDate: selectedDate,

          firstDate: DateTime(2025),

          lastDate: DateTime(2035),
        );

        if (picked == null) return;

        setState(() {

          selectedDate = picked;

        });

        loadDiary();
      },
    ),

SizedBox(height: 10),

    Padding(

    padding: const EdgeInsets.symmetric(
    horizontal: 15,
    ),

    child: diaryEntries.isEmpty

    ? Container(

      width: double.infinity,

      margin: const EdgeInsets.only(top: 30),

      padding: const EdgeInsets.symmetric(

        horizontal: 28,

        vertical: 35,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        border: Border.all(

          color: const Color(0xFFE7ECF4),
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.03),

            blurRadius: 12,

            offset: const Offset(0, 5),
          )
        ],
      ),

      child: Column(

        children: [

          Container(

            height: 85,

            width: 85,

            decoration: BoxDecoration(

              color: AppColors.primaryBlue.withOpacity(.08),

              shape: BoxShape.circle,
            ),

            child: const Icon(

              Icons.menu_book_rounded,

              size: 42,

              color: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(height: 22),

          const Text(

            "Your Diary is Empty",

            style: TextStyle(

              fontSize: 22,

              fontWeight: FontWeight.bold,

              color: Color(0xFF081B5C),
            ),
          ),

          const SizedBox(height: 10),

          const Text(

            "No homework, teacher notes\nor school circulars have been\nadded for this date.",

            textAlign: TextAlign.center,

            style: TextStyle(

              fontSize: 15,

              color: Colors.grey,

              height: 1.5,
            ),
          ),


        ],
      ),
    )

              : Column(

      children: [

        DiarySection(

          icon: Icons.menu_book_rounded,

          title: "Homework",

          badge: "${homeworkEntries.length} Items",

          color: Colors.blue,

          children: homeworkEntries.isEmpty

              ? [

            const Padding(

              padding: EdgeInsets.symmetric(vertical: 20),

              child: Text(

                "No homework assigned.",

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 15,
                ),
              ),
            )

          ]

              : homeworkEntries.map((homework) {

            return HomeworkItem(

              subjectName: homework.subjectName,

              homework: homework.description,

              icon: Icons.menu_book,

              iconColor: Colors.blue,

            );

          }).toList(),
        ),
        const SizedBox(height: 12),
        DiarySection(

          icon: Icons.edit_note_rounded,

          title: "Teacher Notes",

          badge: "${teacherNotes.length} Notes",

          color: Colors.orange,

          children: teacherNotes.isEmpty

              ? [

                SizedBox(height: 10),

            const Padding(

              padding: EdgeInsets.symmetric(vertical: 20),

              child: Text(

                "No teacher notes.",

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 15,
                ),
              ),
            )

          ]

              : teacherNotes.map((note) {

            return Padding(
              padding: EdgeInsets.all(10),
              child: TeacherNoteCard(

                note: note.description,

              ),
            );

          }).toList(),
        ),
        const SizedBox(height: 15),
        DiarySection(

          icon: Icons.campaign_rounded,

          title: "School Circulars",

          badge: "${circulars.length} Circulars",

          color: Colors.pink,

          children: circulars.isEmpty

              ? [

                SizedBox(height: 10),

            const Padding(

              padding: EdgeInsets.symmetric(vertical: 20),

              child: Text(

                "No circulars.",

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 15,
                ),
              ),
            )

          ]

              : circulars.map((circular) {

            return Padding(
              padding: EdgeInsets.all(10),
              child: SchoolCircularCard(

                circular: circular.description,

              ),
            );

          }).toList(),
        ),
        const SizedBox(height: 30),

      ],
    ),
    ),
      ],
      ),
      ),
      ),

      floatingActionButton: SpeedDial(

        animatedIcon: AnimatedIcons.menu_close,

        backgroundColor: AppColors.primaryBlue,

        foregroundColor: Colors.white,

        overlayColor: Colors.black,

        overlayOpacity: .25,

        spacing: 12,

        spaceBetweenChildren: 12,

        children: [

          SpeedDialChild(

            child: const Icon(

              Icons.edit_note_rounded,

              color: Colors.white,
            ),

            backgroundColor: Colors.orange,

            label: "Teacher Note",

            onTap: () {

             HapticFeedback.lightImpact();
             Navigator.push(context,
             MaterialPageRoute(
                 builder: (_)=> AddTeacherNoteScreen(
                     accessToken: widget.accessToken, className: widget.className, sectionName: widget.sectionName)
             )
             );

            },
          ),

          SpeedDialChild(

            child: const Icon(

              Icons.campaign_rounded,

              color: Colors.white,
            ),

            backgroundColor: Colors.pink,

            label: "School Circular",

            onTap: () {

              HapticFeedback.lightImpact();
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_)=> SchoolCircularScreen(
                          accessToken: widget.accessToken, className: widget.className, sectionName: widget.sectionName)
                  )
              );

            },
          ),
        ],
      ),
    );
  }
}
