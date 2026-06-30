import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:school_management_app/screens/fees/student_fee_summary_screen.dart';
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
import '../../widgets/profile_photo_widget.dart';


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
  Widget _buildStudentIdCard() {

    return Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(26),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.08),

            blurRadius: 20,

            offset: const Offset(0,8),
          )
        ],
      ),

      child: Column(

        children: [

          _buildIdCardHeader(),

          _buildStudentSection(),
        SizedBox(height: 10)

        // _buildAddressSection(),
        ],
      ),
    );
  }
  Widget _buildIdCardHeader() {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: const BoxDecoration(

        gradient: LinearGradient(

          colors: [

            Color(0xFF081B5C),

            Color(0xFF2457FF),
          ],
        ),

        borderRadius: BorderRadius.only(

          topLeft: Radius.circular(26),

          topRight: Radius.circular(26),
        ),
      ),

      child: Column(

        children: [

          Row(

            children: [

              Container(

                height: 50,

                width: 50,

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Image.asset(
                  "assets/images/logo.png",

                  width: 100,

                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Text(

                      "SUNSHINE PUBLIC SCHOOL",

                      style: TextStyle(

                        color: Colors.white,

                        fontWeight: FontWeight.w800,

                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(

                      "Learn • Grow • Excel",

                      style: TextStyle(

                        color: Colors.white70,

                        fontSize: 12,
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
  Widget _buildStudentSection() {

    return Padding(

      padding: const EdgeInsets.all(18),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          ///==========================
          /// LEFT SIDE
          ///==========================

          SizedBox(

            width: 110,

            child: Column(

              children: [

                ProfilePhotoWidget.student(
                  studentId: widget.studentId,
                  radius: 38,
                ),

                const SizedBox(height: 10),

                Text(

                  student?.fullName ?? "",

                  textAlign: TextAlign.center,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(

                    fontSize: 15,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF081B5C),
                  ),
                ),

                const SizedBox(height: 6),

                Container(

                  padding: const EdgeInsets.symmetric(

                    horizontal: 10,

                    vertical: 5,
                  ),

                  decoration: BoxDecoration(

                    color: const Color(0xFFEAF1FF),

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(

                    "${student?.classroom.name} • ${student?.section.name}",

                    style: const TextStyle(

                      color: Color(0xFF2457FF),

                      fontWeight: FontWeight.bold,

                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          ///==========================
          /// RIGHT SIDE
          ///==========================

          Expanded(

            child: Column(

              children: [

                _buildProfileInfo(

                  "Parent Name",

                  student!.parents.isNotEmpty

                      ? student!.parents.first.fullName

                      : "-",

                  Icons.person_outline,
                ),

                const SizedBox(height: 12),

                _buildProfileInfo(

                  "Phone Number",

                  student!.parents.isNotEmpty

                      ? student!.parents.first.mobileNumber

                      : "-",

                  Icons.phone,
                ),

                const SizedBox(height: 12),

                _buildProfileInfo(

                  "Academic Year",

                  student!.academicYear.name,

                  Icons.calendar_today,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStudentInfoTile(

      IconData icon,

      String title,

      String value) {

    return Row(

      children: [

        Container(

          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(

            color: const Color(0xFFEAF1FF),

            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(

            icon,

            color: const Color(0xFF2457FF),

            size: 18,
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

                  color: Color(0xFF667085),

                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 2),

              Text(

                value,

                style: const TextStyle(

                  color: Color(0xFF081B5C),

                  fontWeight: FontWeight.w700,

                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(

      String title,

      String value,

      IconData icon) {

    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(

          padding: const EdgeInsets.all(8),

          decoration: BoxDecoration(

            color: const Color(0xFFEAF1FF),

            borderRadius: BorderRadius.circular(10),
          ),

          child: Icon(

            icon,

            size: 18,

            color: const Color(0xFF2457FF),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(

                title,

                style: const TextStyle(

                  fontSize: 12,

                  color: Color(0xFF667085),
                ),
              ),

              const SizedBox(height: 2),

              Text(

                value,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: const TextStyle(

                  fontWeight: FontWeight.w700,

                  fontSize: 14,

                  color: Color(0xFF081B5C),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {

    return Padding(

      padding: const EdgeInsets.fromLTRB(
        18,
        0,
        18,
        16,
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Divider(height: 8),

          const SizedBox(height: 8),

          Row(

            children: const [

              Icon(

                Icons.location_on_rounded,

                color: Color(0xFF2457FF),

                size: 18,
              ),

              SizedBox(width: 6),

              Text(

                "Address",

                style: TextStyle(

                  fontWeight: FontWeight.w700,

                  color: Color(0xFF081B5C),

                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Padding(

            padding: const EdgeInsets.only(left: 24),

            child: Text(

              "ANR Apartments, NGO Colony, Rayachoty",

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

              style: const TextStyle(

                fontSize: 13,

                height: 1.3,

                color: Color(0xFF667085),
              ),
            ),
          ),
        ],
      ),
    );
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

    Widget _buildFeeCard(int totalFee, int paidFee) {
      int pendingFee=0;
      double paidpercentage = (paidFee/totalFee)*100;
      pendingFee = totalFee - paidFee;

      return InkWell(
        onTap: (){
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StudentFeeSummaryScreen()
            )
          );
        },
        child: Container(

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
                  if(pendingFee >0)
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

                    child: Text(
                      "PENDING",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                  if(pendingFee <=0)
                    Container(

                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                        BorderRadius.circular(30),
                      ),

                      child: Text(
                        "PAID",
                        style: TextStyle(
                            color: Colors.white,
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

                        value: paidpercentage/100,

                        strokeWidth: 10,

                        backgroundColor:
                        const Color(0xFFE5E7EB),

                        valueColor:
                        const AlwaysStoppedAnimation<Color>(
                         AppColors.primaryBlue,
                        ),
                      ),
                    ),

                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Text(
                          "$paidpercentage%",

                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryBlue,
                          ),
                        ),

                        const SizedBox(height: 2),

                        const Text(
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

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Total Fees : ₹ $totalFee",
                          style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF081B5C)),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Paid : ₹ $paidFee",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Pending : ₹ $pendingFee",
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

              child: _buildStudentIdCard(),
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
            _buildFeeCard(student!.feeInformation.totalFee, student!.feeInformation.paidFee),

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