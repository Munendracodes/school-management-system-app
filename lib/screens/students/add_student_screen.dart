import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../../models/active_academic_year_response.dart';

import '../../models/create_student_request.dart';
import '../../services/academic_year_service.dart';
import '../../services/students_service.dart';


class AddStudentScreen extends StatefulWidget {

  final String accessToken;

  final VoidCallback onStudentAdded;

  const AddStudentScreen({
    super.key,
    required this.accessToken,
    required this.onStudentAdded,
  });

  @override
  State<AddStudentScreen> createState() =>
      _AddStudentScreenState();
}

class _AddStudentScreenState
    extends State<AddStudentScreen> {

  bool isLoading = true;
  bool isSaving = false;

  final admissionNumberController =
  TextEditingController();

  final fullNameController =
  TextEditingController();

  final dobController =
  TextEditingController();

  String? selectedGender;

  String? selectedAcademicYear;

  String? selectedClassroom;

  SectionData? selectedSection;

  List<ClassroomData> classrooms = [];

  List<SectionData> sections = [];

  List<ActiveAcademicYearResponse> academicYears = [];


  ActiveAcademicYearResponse?
  academicYear;

  @override
  void initState() {

    super.initState();

    loadAcademicYear();
  }
  Future<void> createStudent() async {

    if (selectedSection == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            "Please select section",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {

        isSaving = true;
      });

      final request =
      CreateStudentRequest(

        admissionNumber:
        admissionNumberController.text,

        fullName:
        fullNameController.text,

        gender:
        selectedGender ?? "",

        dateOfBirth:
        dobController.text,

        sectionId:
        selectedSection!.id,
      );

      await StudentsService.createStudent(

        accessToken: widget.accessToken,

        request: request,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            "Student created successfully",
          ),
        ),
      );

      widget.onStudentAdded();

      Navigator.pop(context);

    } catch (e) {

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

        selectedAcademicYear = response.name;

        classrooms = response.classrooms;

        isLoading = false;
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    Widget _buildTextField({
      required String label,
      required String hint,
      required TextEditingController controller,
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

          const SizedBox(height: 5),

          TextField(
            controller: controller,

            decoration: InputDecoration(
              hintText: hint,

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


    if (isLoading) {

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      backgroundColor:
      const Color(0xFFF8FAFF),

      appBar: AppBar(

        backgroundColor:
        Colors.transparent,

        elevation: 0,

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryBlue,
            size: 20,
          ),

          onPressed: () {

            Navigator.pop(context);
          },
        ),

        title: const Text(

          "Add Student",

          style: TextStyle(
            color: Color(0xFF081B5C),
            fontWeight: FontWeight.w700,
            fontSize: 20
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// STUDENT INFORMATION
            const Text(
              "Student Information",

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF081B5C),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),

                border: Border.all(
                  color: const Color(0xFFE6ECF5),
                ),
              ),

              child: Column(
                children: [

                  /// ADMISSION NUMBER
                  _buildTextField(
                    label: "Admission Number",
                    hint: "Enter admission number",
                    controller: admissionNumberController,
                  ),

                  const SizedBox(height: 5),

                  /// FULL NAME
                  _buildTextField(
                    label: "Full Name",
                    hint: "Enter full name",
                    controller: fullNameController,
                  ),

                  const SizedBox(height: 5),
                  _buildDateField(),
                  const SizedBox(height: 5),

                  Row(
                    children: [

                      /// GENDER
                      Expanded(
                        child: _buildStringDropdownField(
                          label: "Gender",
                          value: selectedGender,
                          hint: "Select Gender",

                          items: const [
                            "Male",
                            "Female",
                          ],

                          onChanged: (value) {

                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// ACADEMIC INFO
            const Text(
              "Academic Information",

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF081B5C),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),

                border: Border.all(
                  color: const Color(0xFFE6ECF5),
                ),
              ),

              child: Column(
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

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F8FF),

                      borderRadius:
                      BorderRadius.circular(18),
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFF2457FF),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            "Class and section determines where the student will be added.",

                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton.icon(

               onPressed: isSaving
                  ? null
                  : createStudent,

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF2457FF),

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                ),

                icon: const Icon(
                  Icons.save_outlined,
                  color: Colors.white,
                ),

                label: isSaving
                    ? const SizedBox(

                  height: 22,
                  width: 22,

                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )

                    : const Text(
                  "Add Student",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 14),

            /// CANCEL BUTTON
            SizedBox(
              width: double.infinity,
              height: 58,

              child: OutlinedButton(

                onPressed: () {
                  Navigator.pop(context);
                },

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF2457FF),
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                ),

                child: const Text(
                  "Cancel",

                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2457FF),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const Text(
          "Date of Birth",

          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5B6475),
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: dobController,
          readOnly: true,

          decoration: InputDecoration(

            hintText: "Select date of birth",

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

              dobController.text =
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


  Widget _buildField({

    required TextEditingController
    controller,

    required String label,

    String? hint,
  }) {

    return TextField(

      controller: controller,

      decoration:
      _inputDecoration(
        label,
      ).copyWith(

        hintText: hint,
      ),
    );
  }

  InputDecoration _inputDecoration(
      String label,
      ) {

    return InputDecoration(

      labelText: label,

      filled: true,

      fillColor: Colors.white,

      contentPadding:
      const EdgeInsets.symmetric(

        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(20),

        borderSide: BorderSide.none,
      ),
    );
  }
}