import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../models/parent_info_response.dart';
import '../../services/parents_service.dart';

class ParentInfoScreen extends StatefulWidget {
  final String accessToken;
  final String parentId;

  const ParentInfoScreen({
    super.key,
    required this.accessToken,
    required this.parentId,
  });

  @override
  State<ParentInfoScreen> createState() => _ParentInfoScreenState();
}

class _ParentInfoScreenState extends State<ParentInfoScreen> {

  bool isLoading = true;

  ParentInfoResponse? parent;

  @override
  void initState() {
    super.initState();

    loadParentInfo();
  }
  Future<void> loadParentInfo() async {

    try {

      final response =
      await ParentsService.getParentById(

        accessToken:
        widget.accessToken,

        parentId:
        widget.parentId,
      );

      setState(() {

        parent = response;

        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {

        isLoading = false;
      });
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

      backgroundColor:
      const Color(0xFFF7F9FC),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              /// HEADER
              Row(

                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  Row(
                    children: [

                      InkWell(

                        borderRadius:
                        BorderRadius.circular(18),

                        onTap: () {

                          Navigator.pop(context);
                        },

                        child: Container(

                          padding:
                          const EdgeInsets.all(10),

                          decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                            BorderRadius.circular(18),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.primaryBlue,
                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "Parent Info",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF081B5C),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [

                      _buildTopActionButton(
                        Icons.download_rounded,
                      ),

                      const SizedBox(width: 5),

                      _buildTopActionButton(
                        Icons.share_rounded,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// PROFILE CARD
              Container(

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(32),

                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2457FF),
                      Color(0xFF7A3CFF),
                    ],
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    Padding(

                      padding: const EdgeInsets.all(22),

                      child: Row(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          /// IMAGE
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://i.pravatar.cc/300?img=12",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(width: 18),

                          /// DETAILS
                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Row(

                                  mainAxisAlignment:
                                  MainAxisAlignment.start,

                                  children: [

                                    Expanded(
                                      child: Text(

                                        parent?.fullName ?? "",

                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),

                                const SizedBox(height: 10),

                                Container(
                                  width: 100,

                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.18),
                                    borderRadius:
                                    BorderRadius.circular(30),
                                  ),

                                  child: const Row(
                                    children: [

                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF7DFFA0),
                                        size: 18,
                                      ),

                                      SizedBox(width: 6),

                                      Text(
                                        "Active",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// WHITE INFO BOX
                    Container(

                      width: double.infinity,

                      padding: const EdgeInsets.all(10),

                      decoration: const BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),

                      child: Column(

                        children: [

                          Row(
                            children: [

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.call_rounded,
                                  title: "Mobile Number",
                                  value:
                                  parent?.mobileNumber ?? "",
                                  color:
                                  AppColors.primaryBlue,
                                ),
                              ),

                              Container(
                                width: 1,
                                height: 55,
                                color: const Color(0xFFE5E7EB),
                              ),

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.email_rounded,
                                  title: "Email",
                                  value:
                                  parent?.email ?? "",
                                  color:
                                  AppColors.purple,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Row(
                            children: [

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.menu_book_rounded,
                                  title: "Relationship",
                                  value: parent!.children.isNotEmpty
                                      ? parent!.children.first.relationshipType
                                      : "",
                                  color:
                                  AppColors.orange,
                                ),
                              ),

                              Container(
                                width: 1,
                                height: 55,
                                color: const Color(0xFFE5E7EB),
                              ),

                              Expanded(
                                child: _buildMiniInfo(
                                  icon: Icons.work_rounded,
                                  title: "Total Children",
                                  value:
                                  "${parent?.children.length ?? 0} Student",
                                  color:
                                  AppColors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// ACADEMIC INFO
              _buildSectionCard(

                title: "Children Information",

                icon: Icons.menu_book_rounded,

                child:  ListView.builder(

                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount:
                parent?.children.length ?? 0,

                itemBuilder: (context, index) {

                  final child =
                  parent!.children[index];

                  return Container(

                    margin:
                    const EdgeInsets.only(bottom: 10),

                    padding:
                    const EdgeInsets.all(14),

                    decoration: BoxDecoration(

                      color:
                      const Color(0xFFF8FAFF),

                      borderRadius:
                      BorderRadius.circular(20),

                      border: Border.all(
                        color:
                        const Color(0xFFE7ECF8),
                      ),
                    ),

                    child: Row(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        /// PHOTO
                        Container(

                          height: 60,
                          width: 60,

                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,

                            image: DecorationImage(
                              image: NetworkImage(
                                "https://i.pravatar.cc/300?img=10",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                child.fullName,

                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF081B5C),
                                ),
                              ),

                              const SizedBox(height: 12),

                              _buildChildRow(
                                Icons.school_rounded,
                                Colors.blue,
                                "Class",
                                child.className,
                              ),

                              const SizedBox(height: 8),

                              _buildChildRow(
                                Icons.meeting_room_rounded,
                                Colors.green,
                                "Section",
                                child.sectionName,
                              ),

                              const SizedBox(height: 8),

                              _buildChildRow(
                                Icons.calendar_month_rounded,
                                Colors.orange,
                                "Academic Year",
                                child.academicYear,
                              ),

                         /*     const SizedBox(height: 8),

                              _buildChildRow(
                                Icons.people_rounded,
                                Colors.purple,
                                "Relationship",
                                child.relationshipType,
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ),

              const SizedBox(height: 10),

              /// CONTACT
              _buildSectionCard(

                title: "Contact Information",

                icon: Icons.contacts,

                child: Column(

                  children: [

                    _buildContactTile(
                      icon: Icons.call_rounded,
                      title: "Mobile Number",
                      value:
                      parent?.mobileNumber ?? "",
                      actionText: "Call",
                    ),

                    const SizedBox(height: 10),

                    _buildContactTile(
                      icon: Icons.email_rounded,
                      title: "Email Address",
                      value:
                      parent?.email ?? "",
                      actionText: "Email",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              _buildSectionCard(

                title: "Family Summary",

                icon: Icons.family_restroom_rounded,

                child: Row(

                  children: [

                    Expanded(
                      child: _buildStatTile(
                        icon: Icons.people_alt_rounded,
                        label: "Children",
                        value:
                        "${parent?.children.length ?? 0}",
                        color: Colors.blue,
                      ),
                    ),

                    Expanded(
                      child: _buildStatTile(
                        icon: Icons.school_rounded,
                        label: "Students",
                        value:
                        "${parent?.children.length ?? 0}",
                        color: Colors.green,
                      ),
                    ),

                    Expanded(
                      child: _buildStatTile(
                        icon: Icons.calendar_month_rounded,
                        label: "Years",
                        value: "1",
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),


              /// QUICK ACTIONS
              _buildSectionCard(

                title: "Quick Actions",

                icon: Icons.flash_on_rounded,

                child: GridView.count(

                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  crossAxisCount: 4,

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  childAspectRatio: 0.9,

                  children: [

                    _buildQuickAction(
                      Icons.family_restroom_rounded,
                      "View Children",
                    ),

                    _buildQuickAction(
                      Icons.account_balance_wallet_rounded,
                      "Fee Details",
                    ),

                    _buildQuickAction(
                      Icons.calendar_month_rounded,
                      "Attendance",
                    ),

                    _buildQuickAction(
                      Icons.folder_rounded,
                      "Documents",
                    ),

                    _buildQuickAction(
                      Icons.call_rounded,
                      "Contact",
                    ),

                    _buildQuickAction(
                      Icons.email_rounded,
                      "Send Message",
                    ),

                    _buildQuickAction(
                      Icons.notifications_rounded,
                      "Notifications",
                    ),

                    _buildQuickAction(
                      Icons.edit_rounded,
                      "Edit Parent",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopActionButton(
      IconData icon,
      ) {

    return Container(

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Icon(
        icon,
        color: AppColors.primaryBlue,
      ),
    );
  }

  Widget _buildMiniInfo({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),

      child: Row(

        children: [

          /*  Container(

            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),*/

          const SizedBox(width: 12),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF667085),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildRow(
      IconData icon,
      Color color,
      String label,
      String value,
      ) {

    return Row(

      children: [

        Icon(
          icon,
          size: 18,
          color: color,
        ),

        const SizedBox(width: 10),

        SizedBox(
          width: 90,
          child: Text(
            label,

            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF667085),
            ),
          ),
        ),
        SizedBox(width: 1.0),

        Expanded(
          child: Text(
            value,

            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF081B5C),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {

    return Container(

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(28),

        border: Border.all(
          color: const Color(0xFFE9EEF9),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(

        children: [

          Row(
            children: [

              Container(

                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4FF),

                  borderRadius:
                  BorderRadius.circular(16),
                ),

                child: Icon(
                  icon,
                  color: AppColors.primaryBlue,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          child,
        ],
      ),
    );
  }

  Widget _buildStatTile(
      {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
      }) {

    return Column(

      children: [

        Container(

          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius:
            BorderRadius.circular(18),
          ),

          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF667085),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF081B5C),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceTile({
    required String title,
    required String value,
    required Color color,
  }) {

    return Container(

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius:
        BorderRadius.circular(20),
      ),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF667085),
            ),
          ),

          Text(
            value,

            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String value,
    required String actionText,
  }) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE9EEF9),
        ),
      ),

      child: Row(

        children: [



          Container(

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: const Color(0xFFF3F4FF),
              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF667085),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF081B5C),
                  ),
                ),
              ],
            ),
          ),



       /*   Container(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(16),

              border: Border.all(
                color: AppColors.primaryBlue,
              ),
            ),

            child: Text(
              actionText,

              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _buildQuickAction(
      IconData icon,
      String title,
      ) {
    Color bgColor;

    switch (title) {

      case "View Children":
        bgColor = const Color(0xFFF3F6FF);
        break;

      case "Fee Details":
        bgColor = const Color(0xFFF2FFF6);
        break;

      case "Attendance":
        bgColor = const Color(0xFFF7F4FF);
        break;

      case "Documents":
        bgColor = const Color(0xFFFFF8F0);
        break;

      case "Contact":
        bgColor = const Color(0xFFF3FFF7);
        break;

      case "Send Message":
        bgColor = const Color(0xFFF4F8FF);
        break;

      case "Notifications":
        bgColor = const Color(0xFFFFF8F0);
        break;

      default:
        bgColor = const Color(0xFFF7F4FF);
    }

    return InkWell(

      borderRadius:
      BorderRadius.circular(20),

      onTap: () {

        HapticFeedback.lightImpact();
      },

      child: Container(


        decoration: BoxDecoration(

          color: bgColor,

          borderRadius:
          BorderRadius.circular(20),

          border: Border.all(
            color: const Color(0xFFE9EEF9),
          ),
        ),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              color:

              title == "Fee Details"
                  ? Colors.green

                  : title == "Documents"
                  ? Colors.orange

                  : title == "Contact"
                  ? Colors.green

                  : title == "Notifications"
                  ? Colors.orange

                  : AppColors.primaryBlue,

              size: 26,
            ),

            const SizedBox(height: 5),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF081B5C),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

