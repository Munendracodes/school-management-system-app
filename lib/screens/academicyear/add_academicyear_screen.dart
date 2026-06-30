import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../services/academic_year_service.dart';
import '../../widgets/app_date_field.dart';
import '../../widgets/app_form_card.dart';
import '../../widgets/app_page_header.dart';
import '../../widgets/app_primary_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/app_timeline.dart';

class AddAcademicyearScreen extends StatefulWidget {
  final String accessToken;
  const AddAcademicyearScreen({
    super.key,
    required this.accessToken
  });

  @override
  State<AddAcademicyearScreen> createState() => _AddAcademicyearScreenState();
}

class _AddAcademicyearScreenState extends State<AddAcademicyearScreen> {

  bool isSaving = false;

  bool isActive = true;

final academicYearNameController = TextEditingController();

final startDateController = TextEditingController();

final endDateController = TextEditingController();

Widget _buildDateField(String fieldName, TextEditingController controller, String hinText) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

       Text(
        fieldName,

        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5B6475),
        ),
      ),
      SizedBox(height: 5),
      TextField(
        controller: controller,
        readOnly: true,

        decoration: InputDecoration(

          hintText: hinText,

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

            controller.text =
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

Widget _buildTextField(String fieldName, TextEditingController controller, String hinText) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Text(
        fieldName,

        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5B6475),
        ),
      ),
      SizedBox(height: 5),
      TextField(
        controller: controller,
        decoration: InputDecoration(

          hintText: hinText,

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
      ),
    ],
  );
}

Widget _buildHeader(){
  return Row(
    children: [

      IconButton(onPressed: (){
        Navigator.pop(context);
      },
          icon: Icon(Icons.arrow_back_ios_new,
          color: AppColors.primaryBlue,
            size: 18,
          ),
      ),
      SizedBox(width: 10.0),

      Column(
        children: [
          Text("Add Academic Year",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
                color: Color(0xFF081B5C)
            ),
          )
        ],
      )
    ],
  );
}

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

                  "Active Academic Year",

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

  Future<void> saveAcademicYear() async {

    if (academicYearNameController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please enter Academic Year",
          ),
        ),
      );

      return;
    }

    if (startDateController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please select Start Date",
          ),
        ),
      );

      return;
    }

    if (endDateController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please select End Date",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {

        isSaving = true;

      });

      final apiStartDate = DateFormat("yyyy-MM-dd").format(
        DateFormat("dd MMM yyyy").parse(startDateController.text),
      );

      final apiEndDate = DateFormat("yyyy-MM-dd").format(
        DateFormat("dd MMM yyyy").parse(endDateController.text),
      );

      await AcademicYearService.createAcademicYear(

        accessToken: widget.accessToken,

        name: academicYearNameController.text.trim(),

        startDate: apiStartDate,

        endDate: apiEndDate,

        isActive: isActive,
      );

      if (!mounted) return;

      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Academic Year added successfully",
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F9FC),

      body: SafeArea(

        child: Column(

          children: [

            const SizedBox(height: 10),

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 18),

              child: AppPageHeader(

                title: "Academic Year",

                subtitle: "Create and manage academic sessions",

                icon: Icons.calendar_month_rounded,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(horizontal: 18),

                child: Column(

                  children: [

                    AppFormCard(

                      title: "Session Information",

                      children: [

                        AppTextField(

                          label: "Academic Year",

                          hint: "Ex : 2025 - 2026",

                          icon: Icons.school_rounded,

                          controller:
                          academicYearNameController,
                        ),

                        const SizedBox(height: 10),

                        AppDateField(

                          label: "Start Date",

                          hint: "Select Start Date",

                          controller:
                          startDateController,
                        ),

                        const AppTimeline(),

                        AppDateField(

                          label: "End Date",

                          hint: "Select End Date",

                          controller:
                          endDateController,
                        ),

                        const SizedBox(height: 20),

                        _buildActiveToggle(),
                      ],
                    ),

                    const SizedBox(height: 28),

                    AppPrimaryButton(

                      title: "Create Academic Year",

                      loading: isSaving,

                      onPressed: () {

                        HapticFeedback.lightImpact();

                        saveAcademicYear();
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
