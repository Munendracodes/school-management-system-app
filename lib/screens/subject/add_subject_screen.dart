import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/widgets/app_read_only_field.dart';

import '../../core/constants/app_colors.dart';
import '../../services/subject_service.dart';
import '../../widgets/app_form_card.dart';
import '../../widgets/app_page_header.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/app_text_field.dart';

class AddSubjectScreen extends StatefulWidget {
  final String accessToken;
  final String academicYear;

  const AddSubjectScreen({
    super.key,
    required this.accessToken,
    required this.academicYear
  });

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  bool isLoading = false;
  bool isSaving = false;
  bool isActive = true;
  final subjectNameController = TextEditingController();

  Widget _buildActiveToggle() {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFDCE4F2),
        ),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(

        children: [

          Container(

            height: 30,
            width: 30,

            decoration: BoxDecoration(

              color: AppColors.primaryBlue.withOpacity(.10),

              shape: BoxShape.circle,
            ),

            child: const Icon(

              Icons.verified_rounded,

              color: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Text(

                  "Active Subject",

                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF081B5C),
                  ),
                ),


              ],
            ),
          ),
          SizedBox(width: 5),


          Switch(

            value: isActive,

            activeColor: Colors.white,

            activeTrackColor: AppColors.primaryBlue,

            inactiveThumbColor: Colors.white,

            inactiveTrackColor: Colors.grey.shade300,

            onChanged: (value) {

              setState(() {

                isActive = value;

              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> createSubject() async {

    if(subjectNameController.text
        .trim()
        .isEmpty){

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please Enter Subject Name")
        )
      );

      return;
    }

    setState((){

      isSaving = true;

    });

    try{

      await SubjectService
          .createSubject(

        name:
        subjectNameController.text,

        isActive: isActive,
      );

      if(!mounted) return;

      Navigator.pop(
          context,
          true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Subject Added Successfully"))
      );

    }catch(e){

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
          Text(e.toString()),
        ),
      );

    }finally{

      if(mounted){

        setState((){

          isSaving=false;

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

                title: "Subject",

                subtitle: "Create and manage subjects",

                icon: Icons.auto_stories_rounded,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(horizontal: 18),

                child: Column(

                  children: [

                    AppFormCard(

                      title: "Subject Information",

                      children: [

                        AppReadOnlyField(
                            label: "Academic Year",
                            value: widget.academicYear,
                          icon: Icons.calendar_today_outlined,

                        ),
                        SizedBox(height: 10),

                        AppTextField(

                          label: "Subject Name",

                          hint: "Enter Subject Name",

                          icon: Icons.menu_book_outlined,

                          controller: subjectNameController,
                        ),

                        SizedBox(height: 20),

                        _buildActiveToggle(),


                      ],
                    ),

                    const SizedBox(height: 28),

                    AppPrimaryButton(

                      title: "Create Subject",

                      loading: isSaving,

                      onPressed: () {

                        HapticFeedback.lightImpact();

                        createSubject();
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
