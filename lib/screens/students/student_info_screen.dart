import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../models/student_info_response.dart';
import '../../services/student_info_service.dart';
import '../parents/add_parent_screen.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:url_launcher/url_launcher.dart';


class StudentInfoScreen extends StatefulWidget {

  final String accessToken;
  final String studentId;

  const StudentInfoScreen({
    super.key,
    required this.accessToken,
    required this.studentId,
  });

  @override
  State<StudentInfoScreen> createState() =>
      _StudentInfoScreenState();
}

class _StudentInfoScreenState
    extends State<StudentInfoScreen> {
  final ScreenshotController screenshotController =
  ScreenshotController();

  bool isLoading = true;

  StudentInfoResponse? student;

  @override
  void initState() {

    super.initState();

    getStudentInfo();
  }

  Future<void> downloadIdCard() async {

    try {

      final image =
      await screenshotController.capture();

      if (image == null) return;

      final directory =
      await getTemporaryDirectory();

      final imagePath =
          '${directory.path}/student_id_card.png';

      final file = File(imagePath);

      await file.writeAsBytes(image);

      final result =
      await GallerySaver.saveImage(
        file.path,
        albumName: "School Management App",
      );

      print("SAVE RESULT => $result");
      print("IMAGE PATH => ${file.path}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "ID Card downloaded successfully",
          ),
        ),
      );

    } catch (e) {

      print("DOWNLOAD ERROR => $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Download failed: $e",
          ),
        ),
      );
    }
  }
  Future<void> shareIdCard() async {

    try {

      final image =
      await screenshotController.capture(
        pixelRatio: 3,
      );

      if (image == null) return;

      final directory =
      await getTemporaryDirectory();

      final imagePath =
          "${directory.path}/student_id_card.png";

      final file =
      await File(imagePath).writeAsBytes(image);

      await Share.shareXFiles(

        [XFile(file.path)],

        text: "Student ID Card",
      );

    } catch (e) {

      print("SHARE ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(
            "Share failed: $e",
          ),
        ),
      );
    }
  }


  Future<void> getStudentInfo() async {

    try {

      final response =
      await StudentInfoService.getStudentById(

        accessToken:
        widget.accessToken,

        studentId:
        widget.studentId,
      );

      setState(() {

        student = response;

        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> refreshStudentInfo() async {

    setState(() {
      isLoading = true;
    });

    await getStudentInfo();
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    Widget _buildTopInfo({

      required String title,
      required String value,
      required IconData icon,
      required Color iconColor

    }) {

      return Expanded(

        child: Column(

          children: [

            Icon(
              icon,
              color: iconColor,
              size: 22,
            ),

            const SizedBox(height: 4),

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
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF081B5C),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildInfoCard({

      required String title,
      required List<Widget> children,

    }) {

      return Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(24),

          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
        ),

        child: Column(

          children: [

            Align(

              alignment: Alignment.centerLeft,

              child: Text(

                title,

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF081B5C),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ...children,
          ],
        ),
      );
    }
    Widget _buildMiniInfo({

      required String title,

      required String value,

      required IconData icon,

    }) {

      return Column(

        children: [

          Icon(
            icon,
            size: 22,
            color: const Color(0xFF2457FF),
          ),

          const SizedBox(height: 8),

          Text(

            title,

            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF667085),
            ),
          ),

          const SizedBox(height: 4),

          Text(

            value,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ],
      );
    }

    Widget _buildInfoRow(
        Color iconColor,
        String title,
        String value,
        IconData icon,
        ) {

      return Padding(

        padding:
        const EdgeInsets.only(bottom: 18),

        child: Row(

          children: [

            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),

            const SizedBox(width: 12),

            Expanded(

              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667085),
                ),
              ),
            ),

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
      );
    }

    Widget _buildFeeCard() {

      return Container(

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(

          color: const Color(0xFFF5F7FF),

          borderRadius:
          BorderRadius.circular(24),

          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
        ),

        child: Column(

          children: [

            Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                const Text(

                  "Fee Information",

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081B5C),
                  ),
                ),

                Container(

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E5),
                    borderRadius:
                    BorderRadius.circular(30),
                  ),

                  child: const Text(
                    "PENDING",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(

              children: [

            Expanded(

            child: Column(

            children: [

              SizedBox(
              height: 110,
              width: 110,

              child: Stack(
                alignment: Alignment.center,

                children: [

                  SizedBox(
                    height: 100,
                    width: 100,

                    child: CircularProgressIndicator(

                      value: 0.71,

                      strokeWidth: 10,

                      backgroundColor:
                      const Color(0xFFE5E7EB),

                      valueColor:
                      const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2457FF),
                      ),
                    ),
                  ),

                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: const [

                      Text(
                        "71%",

                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2457FF),
                        ),
                      ),

                      SizedBox(height: 2),

                      Text(
                        "Paid",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF667085),
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

                Container(
                  width: 1,
                  height: 100,
                  color: Color(0xFFE5E7EB),
                ),

                const SizedBox(width: 20),

                const Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Total Fees : ₹45,000",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Paid : ₹32,000",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Pending : ₹13,000",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildQuickAction(
        IconData icon,
        String title,
        ) {

      return Container(

        width: 78,

        padding:
        const EdgeInsets.symmetric(
          vertical: 18,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(18),

          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
        ),

        child: Column(

          children: [

            Icon(
              icon,
              color: const Color(0xFF2457FF),
              size: 20,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF081B5C),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildIdRow(
        IconData icon,
        Color iconColor,
        String title,
        String value,
        ) {

      return Row(

        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [

        /*  Container(

            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.12),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              size: 18,
              color: iconColor,
            ),
          ),

          const SizedBox(width: 10),*/
          Expanded(

            child: RichText(

              text: TextSpan(

                children: [

                  TextSpan(
                    text: "$title :  ",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
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

      backgroundColor: Colors.white,

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

          "Student Profile",

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

          children: [

            Row(


              children: [
                SizedBox(width: 10),
                Text("Identity Card",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF081B5C),
                      fontSize: 20
                  ),),
                Spacer(),

                /// DOWNLOAD
                GestureDetector(

                  onTap: downloadIdCard,

                  child: Container(

                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(

                      color: Color(0xFFF4F7FF),

                      borderRadius:
                      BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white70,
                      ),
                    ),

                    child: const Icon(
                      Icons.download_rounded,
                      color: AppColors.primaryBlue,
                      size: 25,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// SHARE
                GestureDetector(

                  onTap: shareIdCard,

                  child: Container(

                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(

                      color: Color(0xFFF4F7FF),

                      borderRadius:
                      BorderRadius.circular(14),

                      border: Border.all(
                        color: Colors.white24,
                      ),
                    ),

                    child: const Icon(
                      Icons.share_rounded,
                      color: AppColors.primaryBlue,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),

            /// PROFILE CARD
            Screenshot(

              controller: screenshotController,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0F2C8C),
                      const Color(0xFF2457FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius: BorderRadius.circular(26),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(

                  children: [
                    /// WHITE BODY
                    Container(

                      width: double.infinity,

                      child: Padding(

                        padding: const EdgeInsets.all(18),

                        child: Column(

                          children: [

                        /// ACTION BUTTONS
                       /* Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sunshine Public School",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20
                            ),),

                          ],
                        ),
                        SizedBox(height: 10.0),*/

                  /// WHITE BODY

                            /// TOP CONTENT
                            Row(

                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                /// PHOTO
                                Column(

                                  children: [

                                    Container(

                                      height: 80,
                                      width: 80,

                                      decoration: BoxDecoration(

                                        borderRadius:
                                        BorderRadius.circular(18),

                                        border: Border.all(
                                          color: const Color(0xFF2457FF),
                                          width: 2,
                                        ),
                                      ),

                                      child: ClipRRect(

                                        borderRadius:
                                        BorderRadius.circular(16),

                                        child: Image.network(

                                          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",

                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(

                                      student?.classroom.name ?? "",

                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      student?.academicYear.name ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                   /* Container(

                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 7,
                                      ),

                                      decoration: BoxDecoration(

                                        color: const Color(0xFF2457FF),

                                        borderRadius:
                                        BorderRadius.circular(30),
                                      ),

                                      child: Text(

                                        student?.classroom.name ?? "",

                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),*/

                                  ],
                                ),

                                const SizedBox(width: 18),

                                /// DETAILS
                                Expanded(

                                  child: Column(

                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                    children: [

                                      Text(

                                        student?.fullName ?? "",

                                        maxLines: 2,

                                        overflow: TextOverflow.ellipsis,

                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          height: 1.1,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      _buildIdRow(
                                        Icons.family_restroom_rounded,
                                        Colors.white,
                                       student!.gender.toLowerCase() == "male"?"S/O":"D/O",
                                        student?.parents.isNotEmpty == true
                                            ? student!.parents.first.fullName
                                            : "-",
                                      ),

                                      const SizedBox(height: 12),

                                      _buildIdRow(
                                        Icons.bloodtype_rounded,
                                        Colors.red,
                                        "Blood Group",
                                        "B+ve",
                                      ),

                                      const SizedBox(height: 12),

                                      _buildIdRow(
                                        Icons.calendar_month_rounded,
                                        Colors.white,
                                        "Mobile No ",
                                        student?.parents.isNotEmpty == true
                                            ? student!.parents.first.mobileNumber
                                            : "-",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            /// ADDRESS
                            Container(

                              width: double.infinity,

                              padding: const EdgeInsets.all(14),

                              decoration: BoxDecoration(

                                color: const Color(0xFFF4F7FF),

                                borderRadius:
                                BorderRadius.circular(18),
                              ),

                              child: Row(

                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Container(

                                    padding: const EdgeInsets.all(10),

                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF1FF),
                                      borderRadius:
                                      BorderRadius.circular(14),
                                    ),

                                    child: const Icon(
                                      Icons.location_on_rounded,
                                      color: Color(0xFF2457FF),
                                      size: 22,
                                    ),
                                  ),

                                  const SizedBox(width: 5),

                                  const Expanded(

                                    child: Column(

                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [

                                        Text(

                                          "Address",

                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF2457FF),
                                          ),
                                        ),

                                        SizedBox(height: 4),

                                        Text(

                                          "#37/15, Kothapeta, Rayachoty,\nAnnamayya District, Andhra Pradesh",

                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1.5,
                                            color: Color(0xFF475467),
                                            fontWeight: FontWeight.normal,
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
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// ACADEMIC INFORMATION
            _buildInfoCard(

              title: "Academic Information",

              children: [
                _buildInfoRow(
                  AppColors.primaryBlue,
                  "Admission Number",
                  student?.admissionNumber ?? "",
                  Icons.person_outline,
                ),
                _buildInfoRow(
                  AppColors.primaryBlue,
                  "Academic Year",
                  student?.academicYear.name ?? "",
                  Icons.calendar_today_rounded,
                ),
                _buildInfoRow(
                  AppColors.primaryBlue,
                  "Classroom",
                  student?.classroom.name ?? "",
                  Icons.school_outlined,
                ),

                _buildInfoRow(
                  AppColors.primaryBlue,
                  "Section",
                  student?.section.name ?? "",
                  Icons.groups_rounded,
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// PARENT DETAILS
            Container(

              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(24),

                border: Border.all(
                  color: const Color(0xFFE8ECF4),
                ),
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(

                        "Parent Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF081B5C),
                        ),
                      ),

                      InkWell(

                        borderRadius: BorderRadius.circular(14),

                        onTap: () async {

                          await Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) => AddParentScreen(

                                accessToken: widget.accessToken,

                                studentId: widget.studentId,

                                studentName:
                                student?.fullName ?? "",

                                className:
                                student?.classroom.name ?? "",

                                sectionName:
                                student?.section.name ?? "",

                                academicYear:
                                student?.academicYear.name ?? "",
                              ),
                            ),
                          );

                          refreshStudentInfo();
                        },

                        child: Container(

                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(

                            color:
                            const Color(0xFFF2F5FF),

                            borderRadius:
                            BorderRadius.circular(14),
                          ),

                          child: const Row(

                            children: [

                              Icon(
                                Icons.add,
                                size: 18,
                                color: Color(0xFF2457FF),
                              ),

                              SizedBox(width: 4),

                              Text(
                                "Add Parent",
                                style: TextStyle(
                                  color: Color(0xFF2457FF),
                                  fontWeight:
                                  FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  ...student!.parents.map(

                        (parent) {

                      return Container(

                        margin:
                        const EdgeInsets.only(
                          bottom: 12,
                        ),

                        padding:
                        const EdgeInsets.all(14),

                        decoration: BoxDecoration(

                          color:
                          const Color(0xFFF8FAFF),

                          borderRadius:
                          BorderRadius.circular(18),

                          border: Border.all(
                            color:
                            const Color(0xFFE8ECF4),
                          ),
                        ),

                        child: Row(

                          children: [

                            CircleAvatar(

                              radius: 28,

                              backgroundColor:
                              Colors.white,

                              child: const Icon(
                                Icons.person,
                                color:
                                Color(0xFF2457FF),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Text(

                                    parent.fullName,

                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                      Color(0xFF081B5C),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    parent.relationshipType,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color:
                                      Color(0xFF667085),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                        InkWell(

                          borderRadius: BorderRadius.circular(20),

                          onTap: () async {

                            final phoneNumber =
                                parent.mobileNumber;

                            final Uri uri =
                            Uri.parse("tel:$phoneNumber");

                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          },

                          child: CircleAvatar(
                            radius: 20,

                            backgroundColor:
                            const Color(0xFFF2F5FF),

                            child: const Icon(
                              Icons.call,
                              size: 18,
                              color: Color(0xFF2457FF),
                            ),
                          ),
                        ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// FEE INFORMATION
            _buildFeeCard(),

            const SizedBox(height: 10),

            /// QUICK ACTIONS
            Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const Align(

                  alignment: Alignment.centerLeft,

                  child: Text(

                    "Quick Actions",

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF081B5C),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    _buildQuickAction(
                      Icons.event_available,
                      "Attendance",
                    ),

                    _buildQuickAction(
                      Icons.receipt_long,
                      "Fees",
                    ),

                    _buildQuickAction(
                      Icons.call,
                      "Contact",
                    ),

                    _buildQuickAction(
                      Icons.edit,
                      "Edit",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}