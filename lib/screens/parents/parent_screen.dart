import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';

import '../../models/parent_response.dart';

import '../../services/parents_service.dart';

class AddParentScreen
    extends StatefulWidget {

  final String accessToken;

  final String studentId;

  final String studentName;

  final String className;

  final String sectionName;

  final String academicYear;

  const AddParentScreen({
    super.key,

    required this.accessToken,

    required this.studentId,

    required this.studentName,

    required this.className,

    required this.sectionName,

    required this.academicYear,
  });

  @override
  State<AddParentScreen>
  createState() =>
      _AddParentScreenState();
}

class _AddParentScreenState
    extends State<AddParentScreen> {

  bool isLoading = true;

  List<ParentData> parents = [];

  bool isExistingParent = false;

  ParentData? selectedParent;

  final fullNameController =
  TextEditingController();

  final mobileController =
  TextEditingController();

  final emailController =
  TextEditingController();

  String? selectedRelation;

  final relations = [

    "Father",
    "Mother",
    "Guardian",
  ];

  @override
  void initState() {

    super.initState();

    loadParents();
  }

  Future<void> loadParents() async {

    try {

      final response =
      await ParentsService.getParents(

        accessToken:
        widget.accessToken,
      );

      setState(() {

        parents =
            response.parents;

        isLoading = false;
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  Future<void> saveParent() async {

    if (selectedRelation == null) {
      return;
    }

    try {

      String parentId = "";

      /// EXISTING PARENT
      if (selectedParent != null) {

        parentId =
            selectedParent!.id;

      } else {

        /// CREATE PARENT
        parentId =
        await ParentsService
            .createParent(

          accessToken:
          widget.accessToken,

          fullName:
          fullNameController.text,

          mobileNumber:
          mobileController.text,

          email:
          emailController.text,
        );
      }

      /// MAP PARENT
      await ParentsService.mapParent(

        accessToken:
        widget.accessToken,

        studentId:
        widget.studentId,

        parentId:
        parentId,

        relation:
        selectedRelation!,
      );

      if (!mounted) return;

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
          Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

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

          "Add Parent",

          style: TextStyle(
            color: Color(0xFF081B5C),
            fontWeight: FontWeight.w700,
            fontSize: 20
          ),
        ),
      ),

      body:
      isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : SingleChildScrollView(

        padding:
        const EdgeInsets.all(16),

        child: Column(
          children: [

            /// STUDENT CARD
            Container(

              padding:
              const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(28),

                border: Border.all(
                  color:
                  const Color(0xFFE9EEF9),
                ),
              ),

              child: Row(
                children: [

                  Container(

                    height: 75,
                    width: 75,

                    decoration:
                    const BoxDecoration(

                      color:
                      Color(0xFFEFF4FF),

                      shape:
                      BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.person_rounded,
                      size: 40,
                      color:
                      AppColors.primaryBlue,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          widget.studentName,

                          style:
                          const TextStyle(

                            fontSize: 20,

                            fontWeight:
                            FontWeight.w700,

                            color:
                            Color(0xFF081B5C),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [

                            const Icon(
                              Icons.school_rounded,
                              size: 18,
                              color:
                              AppColors.primaryBlue,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              "${widget.className} • Section  ${widget.sectionName}",
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [

                            const Icon(
                              Icons.calendar_month_rounded,
                              size: 18,
                              color:
                              AppColors.primaryBlue,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              widget.academicYear,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// PARENT INFO
            Container(

              padding:
              const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(28),

                border: Border.all(
                  color:
                  const Color(0xFFE9EEF9),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Parent Information",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF081B5C),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// AUTOCOMPLETE
                  Autocomplete<ParentData>(

                    displayStringForOption:
                        (option) =>
                    option.fullName,

                    optionsBuilder:
                        (value) {

                          if (value.text.trim().isEmpty) {

                            setState(() {

                              isExistingParent = false;

                              selectedParent = null;

                              mobileController.text = "";

                              emailController.text = "";
                            });
                          }

                      return parents.where(

                            (parent) {

                          return parent
                              .fullName
                              .toLowerCase()
                              .contains(

                            value.text
                                .toLowerCase(),
                          );
                        },
                      );
                    },

                    onSelected: (parent) {

                      setState(() {

                        selectedParent = parent;

                        fullNameController.text =
                            parent.fullName;

                        mobileController.text =
                            parent.mobileNumber;

                        emailController.text =
                            parent.email;
                      });
                    },

                    fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                        ) {

                      /// sync controller
                      textEditingController.text =
                          fullNameController.text;

                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,

                        onChanged: (value) {

                          fullNameController.text = value;

                          final matchedParent = parents.firstWhere(

                                (parent) =>
                            parent.fullName.toLowerCase() ==
                                value.toLowerCase(),

                            orElse: () => ParentData(
                              id: "",
                              fullName: "",
                              mobileNumber: "",
                              email: "",
                            ),
                          );

                          if (matchedParent.id.isNotEmpty) {

                            setState(() {

                              selectedParent = matchedParent;

                              mobileController.text =
                                  matchedParent.mobileNumber;

                              emailController.text =
                                  matchedParent.email;

                              isExistingParent = true;
                            });

                          } else {

                            setState(() {

                              selectedParent = null;

                              isExistingParent = false;

                              mobileController.clear();

                              emailController.clear();
                            });
                          }
                        },

                        decoration: InputDecoration(
                          hintText: "Enter parent full name",

                          prefixIcon: const Icon(
                            Icons.person_search_rounded,
                          ),

                          filled: true,
                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(18),

                            borderSide: BorderSide.none,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(18),

                            borderSide: BorderSide(
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(18),

                            borderSide: BorderSide(
                              color: AppColors.primaryBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  TextField(

                    controller:
                    mobileController,

                    keyboardType:
                    TextInputType.phone,

                    inputFormatters: [

                      LengthLimitingTextInputFormatter(10),
                    ],

                    decoration:
                    InputDecoration(

                      hintText:
                      "Mobile Number",

                      prefixIcon:
                      const Icon(
                        Icons.phone_rounded,
                      ),

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(

                    controller:
                    emailController,

                    decoration:
                    InputDecoration(

                      hintText:
                      "Email Address",

                      prefixIcon:
                      const Icon(
                        Icons.email_rounded,
                      ),

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(

                    value:
                    selectedRelation,

                    items:
                    relations.map(

                          (relation) {

                        return DropdownMenuItem(

                          value:
                          relation,

                          child:
                          Text(relation),
                        );
                      },
                    ).toList(),

                    onChanged:
                        (value) {

                      setState(() {

                        selectedRelation =
                            value;
                      });
                    },

                    decoration:
                    InputDecoration(

                      hintText:
                      "Select Relation",

                      prefixIcon:
                      const Icon(
                        Icons.groups_rounded,
                      ),

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              height: 56,

              child: ElevatedButton(

                onPressed: saveParent,

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  AppColors.primaryBlue,

                  shape:
                  RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),

                child: Text(

                  selectedParent != null

                      ? "Map Parent"

                      : "Add & Map Parent",

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}