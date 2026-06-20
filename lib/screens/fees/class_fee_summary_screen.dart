import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/screens/fees/section_fee_summary_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../models/fees_response.dart';
import '../../models/section_summary.dart';

class ClassFeeSummaryScreen extends StatefulWidget {

  final String accessToken;
  final String className;

  const ClassFeeSummaryScreen({
    super.key,
    required this.accessToken,
    required this.className,
  });

  @override
  State<ClassFeeSummaryScreen> createState() =>
      _ClassFeeSummaryScreenState();
}

class _ClassFeeSummaryScreenState
    extends State<ClassFeeSummaryScreen> {

  List<FeeData> fees = [
    FeeData(
      className: "Class 1",
      studentCount: 60,
      schoolFee: 120000,
      booksFee: 30000,
      admissionFee: 20000,
      uniformFee: 20000,
    ),
    FeeData(
      className: "Class 2",
      studentCount: 55,
      schoolFee: 110000,
      booksFee: 25000,
      admissionFee: 18000,
      uniformFee: 17000,
    ),
  ];

  final List<SectionSummary> sections = [

    SectionSummary(
      sectionName: "A",
      studentCount: 25,
      collectedAmount: 60000,
      pendingAmount: 15000,
    ),

    SectionSummary(
      sectionName: "B",
      studentCount: 35,
      collectedAmount: 80000,
      pendingAmount: 35000,
    ),
  ];

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

            children: const [

              Text(
                "Class Fee Summary",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  AppColors.darkText,
                ),
              ),
              Text(
                "Class 1 • Academic Year 2026-2027",
                style: TextStyle(
                  color:
                  AppColors.lightText,
                  fontSize: 14,
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

  Widget buildFeeRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String amount,
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),

      child: Row(
        children: [

          Icon(
            icon,
            size: 22,
            color: iconColor,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              title,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF344054),
              ),
            ),
          ),

          Text(
            amount,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF081B5C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeStructureCard() {

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
          /// HEADER
          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FF),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: Color(0xFF2457FF),
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                "Fee Structure",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF081B5C),
                ),
              ),

              const Text(
                " (Per Student)",

                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF667085),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          buildFeeRow(
            icon: Icons.school_rounded,
            iconColor: const Color(0xFF2457FF),
            title: "School Fee",
            amount: "₹2,000",
          ),

          buildFeeRow(
            icon: Icons.menu_book_rounded,
            iconColor: const Color(0xFFF97316),
            title: "Books Fee",
            amount: "₹500",
          ),

          buildFeeRow(
            icon: Icons.checkroom_rounded,
            iconColor: const Color(0xFF22C55E),
            title: "Uniform Fee",
            amount: "₹300",
          ),

          buildFeeRow(
            icon: Icons.person_add_alt_rounded,
            iconColor: const Color(0xFFEC4899),
            title: "Admission Fee",
            amount: "₹200",
          ),

          const Divider(),

          Row(
            children: [

              const Expanded(
                child: Text(
                  "Total Fee (Per Student)",

                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2457FF),
                  ),
                ),
              ),

              const Text(
                "₹3,000",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2457FF),
                ),
              ),
            ],
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
      padding: const EdgeInsets.all(10),

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

  Widget buildSectionCard(
      SectionSummary section,
      ) {

    return InkWell(
      onTap: (){
        HapticFeedback.lightImpact();
        Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => SectionFeeSummaryScreen(
                  accessToken: widget.accessToken,
                  className: widget.className,
                  sectionName: section.sectionName)
          )

        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(20),

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

        child: Column(
          children: [

            /// TOP ROW
            Row(
              children: [

                Container(
                  height: 45,
                  width: 45,

                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius:
                    BorderRadius.circular(14),
                  ),

                  child: Center(
                    child: Text(
                      section.sectionName,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Section ${section.sectionName}",

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF081B5C),
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "${section.studentCount} Students",

                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF667085),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.primaryBlue,
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF1FCF5),

                      borderRadius:
                      BorderRadius.circular(16),
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Collected",

                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF667085),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "₹${section.collectedAmount.toInt()}",

                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3F8),

                      borderRadius:
                      BorderRadius.circular(16),
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Pending",

                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF667085),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "₹${section.pendingAmount.toInt()}",

                          style: const TextStyle(
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
      ),
    );
  }
  Widget buildSectionSummary() {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        const Text(
          "Section Summary",

          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF081B5C),
          ),
        ),

        const SizedBox(height: 10),

        ListView.builder(
          shrinkWrap: true,

          physics:
          const NeverScrollableScrollPhysics(),

          itemCount: sections.length,

          itemBuilder: (context, index) {

            return buildSectionCard(
              sections[index],
            );
          },
        ),
      ],
    );
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
      backgroundColor: const Color(0xFFF7F9FC),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 15.0),
                GridView.count(
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
                SizedBox(height: 10.0),
                _buildFeeStructureCard(),
                const SizedBox(height: 10),
                buildSectionSummary(),
                const SizedBox(height: 5),
                buildCollectionProgressCard(),
                const SizedBox(height: 10),


              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildCollectFeeButton() ,
    );
  }
}