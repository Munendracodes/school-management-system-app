import 'package:flutter/material.dart';
import 'package:school_management_app/core/constants/app_colors.dart';
import 'package:school_management_app/models/teachers_response.dart';
import 'package:school_management_app/screens/parents/add_parent_screen.dart';
import 'package:school_management_app/screens/parents/parent_info_screen.dart';
import 'package:school_management_app/screens/teachers/add_teacher_screen.dart';
import 'package:school_management_app/services/parents_service.dart';
import 'package:school_management_app/services/teachers_service.dart';
import 'package:flutter/services.dart';

import '../../models/parent_response.dart';

class ParentsScreen extends StatefulWidget {
  final accessToken;
  final Color backgroundColor;
  const ParentsScreen({
    super.key,
    required this.accessToken,
    required this.backgroundColor
  });

  @override
  State<ParentsScreen> createState() => _ParentsScreenState();
}

class _ParentsScreenState extends State<ParentsScreen> {
  bool isLoading = true;
  List<ParentData> parentsList = [];
  List<ParentData> parents = [];
  List<ParentData> filteredParents = [];
  final TextEditingController searchController =
  TextEditingController();

  @override
  void initState(){
    super.initState();
    loadParents();
  }
  Future<void> loadParents() async{
    try{
      final response = await ParentsService.getParents(
          accessToken: widget.accessToken
      );
      print(response);
      setState(() {
        parentsList = response.parents;
        parents = response.parents;

        filteredParents = response.parents;

        isLoading = false;
      });
      print(parentsList.first.fullName);
    }
    catch(e){
      print("Parent API Error");
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }
  void filterTeachers(String query) {

    if (query.trim().isEmpty) {

      setState(() {

        filteredParents = parents;
      });

      return;
    }

    final lowerQuery =
    query.toLowerCase();

    setState(() {

      filteredParents =
          parents.where((parent) {

            return parent.fullName
                .toLowerCase()
                .contains(lowerQuery);

          }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (isLoading) {

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),
     /* floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      AddTeacherScreen(accessToken: widget.accessToken,
                          onTeacherAdded: (){
                            loadParents();
                          }
                      )
              )
          );
        },
        backgroundColor: AppColors.primaryBlue,
        child: Icon(Icons.add,
          color: Colors.white,
        ),
      ),*/
      body: SafeArea(
          child: Column(
            children: [
              /// HEADER
              Padding(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),

                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Container(
                        height: 42,
                        width: 42,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(14),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Color(0xFF081B5C),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            "Parents",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF081B5C),
                            ),
                          ),
                          Text(
                            "Manage Parent details",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// SEARCH + FILTER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Row(
                  children: [

                    /// SEARCH BAR
                    Expanded(
                      child: Row(
                        children: [

                          Expanded(
                            child: SearchBar(

                              controller: searchController,

                              onChanged: filterTeachers,

                              hintText:
                              "Search by name, class or section...",

                              leading: const Icon(
                                Icons.search_rounded,
                                color: Color(0xFF9CA3AF),
                              ),

                              backgroundColor:
                              WidgetStateProperty.all(
                                Colors.white,
                              ),

                              elevation:
                              WidgetStateProperty.all(0),

                              side:
                              WidgetStateProperty.all(
                                BorderSide(
                                  color: const Color(0xFFE3EAFD),
                                  width: 1.2,
                                ),
                              ),

                              padding:
                              WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                              ),

                              shape:
                              WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                              ),

                              hintStyle:
                              WidgetStateProperty.all(
                                const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            height: 56,
                            width: 56,

                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F7FF),
                              borderRadius:
                              BorderRadius.circular(18),
                            ),

                            child: Icon(
                              Icons.tune_rounded,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// TEACHERS LIST

              Expanded(

                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                    shrinkWrap: true,

                    itemCount: filteredParents.length,

                    itemBuilder: (context, index) {

                      final teacher = filteredParents[index];

                      return InkWell(

                        borderRadius: BorderRadius.circular(24),

                        onTap: () {

                          HapticFeedback.lightImpact();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ParentInfoScreen(
                                accessToken: widget.accessToken,
                                parentId: teacher.id,
                              ),
                            ),
                          );
                        },

                        child: Container(

                          margin: const EdgeInsets.only(bottom: 10),

                          padding: const EdgeInsets.all(15),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                            BorderRadius.circular(24),

                            border: Border.all(
                              color: const Color(0xFFE9EEF9),
                            ),

                            boxShadow: [
                              BoxShadow(
                                color:
                                Colors.black.withOpacity(0.02),

                                blurRadius: 10,

                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Row(

                            children: [

                              /// PROFILE
                              Container(
                                height: 50,
                                width: 50,

                                decoration: const BoxDecoration(
                                  color: Color(0xFFEFF4FF),
                                  shape: BoxShape.circle,
                                ),

                                child: Icon(
                                  Icons.person_rounded,
                                  size: 30,
                                  color: AppColors.primaryBlue,
                                ),
                              ),

                              const SizedBox(width: 15),

                              /// DETAILS
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    /// NAME
                                    Text(
                                      teacher.fullName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF081B5C),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: teacher.children.map((child) {

                                        return Container(
                                          width: double.infinity,

                                          margin: const EdgeInsets.only(bottom: 8),

                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),

                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF5F7FF),
                                            borderRadius: BorderRadius.circular(14),
                                          ),

                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [

                                              /// CLASS
                                              Text(
                                                "${child.className} : ",

                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF667085),
                                                ),
                                              ),

                                              const SizedBox(width: 6),

                                              /// STUDENT NAME
                                              Expanded(
                                                child: Text(
                                                  child.fullName,

                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,

                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF344054),
                                                    height: 1.3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),

                              /// ARROW
                              const Icon(
                                Icons.chevron_right_rounded,
                                size: 30,
                                color: Color(0xFF081B5C),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
              ),

            ],
          )
      ),
    );
  }
}
