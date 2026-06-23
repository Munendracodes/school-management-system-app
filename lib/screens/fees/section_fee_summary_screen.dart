import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/screens/fees/student_fee_summary_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../models/student_fee_model.dart';

class SectionFeeSummaryScreen extends StatefulWidget {

  final String accessToken;
  final String className;
  final String sectionName;

  const SectionFeeSummaryScreen({
    super.key,
    required this.accessToken,
    required this.className,
    required this.sectionName,
  });

  @override
  State<SectionFeeSummaryScreen> createState() =>
      _SectionFeeSummaryScreenState();
}

class _SectionFeeSummaryScreenState
    extends State<SectionFeeSummaryScreen> {

  final List<StudentFeeModel> students = [

    StudentFeeModel(
      id: "1",
      name: "Arjun Kumar",
      rollNo: "01",
      section: "A",
      totalFee: 3000,
      paid: 2500,
      pending: 500,
      status: "PARTIAL",
    ),
    StudentFeeModel(
      id: "2",
      name: "Riya Verma",
      rollNo: "02",
      section: "A",
      totalFee: 3000,
      paid: 3000,
      pending: 0,
      status: "PAID",
    ),
    StudentFeeModel(
      id: "1",
      name: "Arjun Kumar",
      rollNo: "01",
      section: "A",
      totalFee: 3000,
      paid: 2500,
      pending: 500,
      status: "PARTIAL",
    ),
    StudentFeeModel(
      id: "2",
      name: "Riya Verma",
      rollNo: "02",
      section: "A",
      totalFee: 3000,
      paid: 3000,
      pending: 0,
      status: "PAID",
    ),
    StudentFeeModel(
      id: "1",
      name: "Arjun Kumar",
      rollNo: "01",
      section: "A",
      totalFee: 3000,
      paid: 2500,
      pending: 500,
      status: "PARTIAL",
    ),
    StudentFeeModel(
      id: "2",
      name: "Riya Verma",
      rollNo: "02",
      section: "A",
      totalFee: 3000,
      paid: 3000,
      pending: 0,
      status: "PAID",
    ),
    StudentFeeModel(
      id: "1",
      name: "Arjun Kumar",
      rollNo: "01",
      section: "A",
      totalFee: 3000,
      paid: 2500,
      pending: 500,
      status: "PARTIAL",
    ),
    StudentFeeModel(
      id: "2",
      name: "Riya Verma",
      rollNo: "02",
      section: "A",
      totalFee: 3000,
      paid: 3000,
      pending: 0,
      status: "PAID",
    ),
  ];
  String selectedFilter = "ALL";
  final TextEditingController searchController =
  TextEditingController();

  List<StudentFeeModel> get filteredStudents {

    return students.where((student) {

      /// SEARCH FILTER
      bool matchesSearch =
      student.name
          .toLowerCase()
          .contains(
        searchController.text
            .toLowerCase(),
      );

      /// STATUS FILTER
      bool matchesStatus =
      selectedFilter == "ALL"
          ? true
          : student.status ==
          selectedFilter;

      return matchesSearch &&
          matchesStatus;

    }).toList();
  }

  Widget _buildHeader() {

    return  Row(

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
        const SizedBox(width: 15),

        Expanded(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(
                "Section Fee Summary",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  AppColors.darkText,
                ),
              ),
              Text(
                "Class 1 • Section A",
                style: TextStyle(
                  color:
                  AppColors.lightText,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 45,
          width: 45,

          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFE4E7EC),
            ),
          ),

          child: const Icon(
            Icons.search_rounded,
            color: AppColors.primaryBlue,
          ),
        ),
      ],
    );
  }

  Widget buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    String? percentage,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: bgColor,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: Colors.white,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(
            height: 40,
            width: 40,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(16),

              border: Border.all(
                color: iconColor.withOpacity(0.15),
              ),
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 25,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF667085),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCollectionProgressCard() {

    double collectedAmount = 140000;
    double pendingAmount = 50000;

    double percentage =
        collectedAmount /
            (collectedAmount + pendingAmount);

    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE9EEF9),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Collection Progress",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),

          const SizedBox(height: 10),

          /// PROGRESS BAR
          Row(
            children: [

              Expanded(
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(10),

                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 10,
                    backgroundColor:
                    const Color(0xFFEAECEF),

                    valueColor:
                    const AlwaysStoppedAnimation(
                      Color(0xFF22C55E),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Text(
                "${(percentage * 100).toInt()}%",

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF22C55E),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,

                          decoration:
                          const BoxDecoration(
                            color: Color(0xFF22C55E),
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "Collected",

                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "₹1,40,000",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 1,
                height: 50,
                color: const Color(0xFFE5E7EB),
              ),

              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Row(
                        children: [

                          Container(
                            width: 10,
                            height: 10,

                            decoration:
                            const BoxDecoration(
                              color: Color(0xFFEC4899),
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            "Pending",

                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF667085),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "₹50,000",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFEC4899),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearchAndFilters() {

    return Column(
      children: [

        /// SEARCH + FILTER ROW
        Row(
          children: [

            Expanded(
              child: Container(
                height: 55,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(28),

                  border: Border.all(
                    color: const Color(0xFFE4E7EC),
                  ),
                ),

                child: TextField(
                  controller: searchController,
                  onChanged: (_) {

                    setState(() {});

                  },


                  decoration:
                  const InputDecoration(
                    border: InputBorder.none,

                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xFF98A2B3),
                    ),

                    hintText:
                    "Search student by name or roll no.",

                    hintStyle: TextStyle(
                      color: Color(0xFF98A2B3),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Container(
              height: 55,
              width: 90,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(28),

                border: Border.all(
                  color: const Color(0xFFE4E7EC),
                ),
              ),

              child: InkWell(
                borderRadius:
                BorderRadius.circular(28),

                onTap: () {

                  /// TODO
                  /// Show filter bottom sheet

                },

                child: const Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.filter_alt_outlined,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),

                    SizedBox(width: 6),

                    Text(
                      "Filter",

                      style: TextStyle(
                        color:
                        AppColors.primaryBlue,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// STATUS CHIPS
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            children: [

              buildFilterChip(
                title: "All (25)",
                value: "ALL",
              ),

              buildFilterChip(
                title: "Paid (10)",
                value: "PAID",
              ),

              buildFilterChip(
                title: "Partial (8)",
                value: "PARTIAL",
              ),

              buildFilterChip(
                title: "Pending (7)",
                value: "PENDING",
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget buildFilterChip({
    required String title,
    required String value,
  }) {

    bool isSelected =
        selectedFilter == value;

    return Padding(
      padding:
      const EdgeInsets.only(right: 10),

      child: InkWell(

        borderRadius:
        BorderRadius.circular(24),

        onTap: () {

          setState(() {
            selectedFilter = value;
          });

        },

        child: Container(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),

          decoration: BoxDecoration(

            color: isSelected
                ? AppColors.primaryBlue
                : Colors.white,

            borderRadius:
            BorderRadius.circular(24),

            border: Border.all(
              color: isSelected
                  ? AppColors.primaryBlue
                  : const Color(0xFFE4E7EC),
            ),
          ),

          child: Text(
            title,

            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : const Color(0xFF344054),

              fontWeight:
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStudentCard(
      StudentFeeModel student,
      ) {

    Color statusColor;

    Color statusBgColor;

    switch (student.status) {

      case "PAID":
        statusColor = const Color(0xFF22C55E);
        statusBgColor = const Color(0xFFF1FCF5);
        break;

      case "PARTIAL":
        statusColor = const Color(0xFFF97316);
        statusBgColor = const Color(0xFFFFF8F2);
        break;

      default:
        statusColor = const Color(0xFFEC4899);
        statusBgColor = const Color(0xFFFFF3F7);
    }

    return InkWell(
      onTap: (){
        HapticFeedback.lightImpact();
        Navigator.push(context,
        MaterialPageRoute
          (builder: (_) => StudentFeeSummaryScreen(
        )
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(24),

          border: Border.all(
            color: const Color(0xFFE9EEF9),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [

            /// AVATAR
            Container(
              height: 55,
              width: 55,

              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FF),

                shape: BoxShape.circle,
              ),

              child: Center(
                child: Text(
                  getInitials(student.name),

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    student.name,

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF081B5C),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Roll No. ${student.rollNo}",

                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF667085),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Pending - 10,000",

                    style: TextStyle(
                      color: Colors.red,

                      fontSize: 12,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),

               /*   Row(
                    children: [

               /*       Expanded(
                        child: buildAmountColumn(
                          "Total Fee",
                          "₹${student.totalFee.toInt()}",
                          const Color(
                              0xFF081B5C),
                        ),
                      ),
                      SizedBox(width: 2.0),

                      Expanded(
                        child: buildAmountColumn(
                          "Paid",
                          "₹${student.paid.toInt()}",
                          const Color(
                              0xFF22C55E),
                        ),
                      ),
                      SizedBox(width: 2.0),

                      Expanded(
                        child: buildAmountColumn(
                          "Pending",
                          "₹${student.pending.toInt()}",
                          const Color(
                              0xFFEC4899),
                        ),
                      ),*/
                    ],
                  ),*/
                ],
              ),
            ),

            const SizedBox(width: 10),

            /// STATUS + ARROW
          /*  Column(
              children: [
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF98A2B3),
                ),
              ],
            ),*/
            SizedBox(height: 5.0),
            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              decoration: BoxDecoration(
                color: statusBgColor,

                borderRadius:
                BorderRadius.circular(
                    20),
              ),

              child: Text(
                student.status
                    .replaceAll("_", " "),

                style: TextStyle(
                  color: statusColor,

                  fontSize: 12,
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAmountRow(
      String title,
      String amount,
      Color color,
      ) {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.start,

      children: [

        Text(
          title,

          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF667085),
          ),
        ),

        const SizedBox(width: 4),

        Text(
          amount,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  String getInitials(
      String name,
      ) {

    List<String> names =
    name.split(" ");

    if (names.length == 1) {
      return names.first[0];
    }

    return
      names.first[0] +
          names.last[0];
  }

  Widget _buildCollectFeeButton() {

    return Container(

      height: 58,

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(30),

        gradient: const LinearGradient(
          colors: [
            AppColors.primaryBlue,
            Color(0xFF4F7BFF),
          ],
        ),

        boxShadow: [
          BoxShadow(
            color:
            AppColors.primaryBlue
                .withOpacity(0.35),

            blurRadius: 15,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: FloatingActionButton.extended(

        elevation: 0,

        backgroundColor:
        Colors.transparent,

        onPressed: () {

          /// TODO
          /// Navigate to Collect Fee Screen

        },

        icon: const Icon(
          Icons.currency_rupee_rounded,
          color: Colors.white,
        ),

        label: const Text(
          "Collect Fee",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,

              delegate: HeaderDelegate(
                child: _buildHeader(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child:  GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisCount: 2,

                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,

                  childAspectRatio: 1.2,

                  children: [

                    buildSummaryCard(
                      title: "Total Students",
                      value: "25",
                      icon: Icons.groups_rounded,
                      iconColor: const Color(0xFF2457FF),
                      bgColor: const Color(0xFFF4F6FF),
                    ),

                    buildSummaryCard(
                      title: "Total Fees",
                      value: "₹75,000",
                      icon: Icons.currency_rupee_rounded,
                      iconColor: const Color(0xFFF97316),
                      bgColor: const Color(0xFFFFF8F2),
                    ),

                    buildSummaryCard(
                      title: "Collected",
                      value: "₹60,000",
                      percentage: "80%",
                      icon: Icons.check_circle_rounded,
                      iconColor: const Color(0xFF22C55E),
                      bgColor: const Color(0xFFF2FCF5),
                    ),

                    buildSummaryCard(
                      title: "Pending",
                      value: "₹15,000",
                      percentage: "20%",
                      icon: Icons.account_balance_wallet_rounded,
                      iconColor: const Color(0xFFEC4899),
                      bgColor: const Color(0xFFFFF3F7),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),

                child:
                buildCollectionProgressCard(),
              ),
            ),

            SliverPersistentHeader(
              pinned: true,

              delegate:
              SearchHeaderDelegate(
                child:
                buildSearchAndFilters(),
              ),
            ),


            filteredStudents.isEmpty
                ? SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(40),

                child: const Column(
                  children: [

                    Icon(
                      Icons.search_off,
                      size: 60,
                      color: Color(0xFF98A2B3),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "No Students Found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {

                    return buildStudentCard(
                      filteredStudents[index],
                    );

                  },

                  childCount:
                  filteredStudents.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            ],
          ),
        )
      );

  }
}

class SearchHeaderDelegate
    extends SliverPersistentHeaderDelegate {

  final Widget child;

  SearchHeaderDelegate({
    required this.child,
  });

  @override
  double get minExtent => 140;

  @override
  double get maxExtent => 140;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {

    return Container(
      color: const Color(0xFFF7F9FC),

      padding:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),

      child: child,
    );
  }

  @override
  bool shouldRebuild(
      SearchHeaderDelegate oldDelegate) {
    return true;
  }
}

class HeaderDelegate
    extends SliverPersistentHeaderDelegate {

  final Widget child;

  HeaderDelegate({
    required this.child,
  });

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {

    return Container(
      color: const Color(0xFFF7F9FC),

      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),

      child: child,
    );
  }

  @override
  bool shouldRebuild(
      HeaderDelegate oldDelegate) {
    return false;
  }
}