import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_app/screens/fees/collect_fee-screen.dart';
import '../../core/constants/app_colors.dart';

class StudentFeeSummaryScreen extends StatefulWidget {

  const StudentFeeSummaryScreen({
    super.key,
  });

  @override
  State<StudentFeeSummaryScreen> createState() =>
      _StudentFeeSummaryScreenState();
}

class _StudentFeeSummaryScreenState
    extends State<StudentFeeSummaryScreen> {
  List<Map<String, dynamic>> editableFees = [

    {
      "enabled": true,
      "title": "School Fee",
      "originalFee": 2500.0,
      "discount": 0.0,
      "finalFee": 2500.0,
      "icon": Icons.school_rounded,
      "color": const Color(0xFF2457FF),
    },

    {
      "enabled": true,
      "title": "Books Fee",
      "originalFee": 500.0,
      "discount": 0.0,
      "finalFee": 500.0,
      "icon": Icons.menu_book_rounded,
      "color": const Color(0xFFF97316),
    },

    {
      "enabled": true,
      "title": "Uniform Fee",
      "originalFee": 300.0,
      "discount": 0.0,
      "finalFee": 300.0,
      "icon": Icons.checkroom_rounded,
      "color": const Color(0xFF22C55E),
    },

    {
      "enabled": true,
      "title": "Admission Fee",
      "originalFee": 200.0,
      "discount": 0.0,
      "finalFee": 200.0,
      "icon": Icons.person_add_alt_rounded,
      "color": const Color(0xFFEC4899),
    },
  ];
  final List<Map<String, dynamic>> paymentHistory = [

    {
      "date": "15-Jun-2026",
      "amount": 5000,
      "mode": "UPI",
      "receiptNo": "RCPT1001",
    },

    {
      "date": "05-Apr-2026",
      "amount": 3000,
      "mode": "Cash",
      "receiptNo": "RCPT1002",
    },

    {
      "date": "15-Feb-2026",
      "amount": 2000,
      "mode": "Online",
      "receiptNo": "RCPT1003",
    },
  ];
  final List<Map<String, dynamic>> pendingDues = [

    {
      "title": "School Fee",
      "amount": 2000,
    },

    {
      "title": "Books Fee",
      "amount": 1000,
    },

    {
      "title": "Uniform Fee",
      "amount": 2000,
    },
  ];
  final List<Map<String, dynamic>> feeStructure = [

    {
      "title": "School Fee",
      "amount": 8000,
      "icon": Icons.school_outlined,
      "color": AppColors.primaryBlue,
    },

    {
      "title": "Books Fee",
      "amount": 3000,
      "icon": Icons.menu_book_outlined,
      "color": Color(0xFF22C55E),
    },

    {
      "title": "Uniform Fee",
      "amount": 2000,
      "icon": Icons.checkroom_outlined,
      "color": Color(0xFFF59E0B),
    },

    {
      "title": "Transport Fee",
      "amount": 2000,
      "icon": Icons.directions_bus_outlined,
      "color": Color(0xFF7C3AED),
    },
  ];
  double totalFee = 15000;
  double paidAmount = 10000;
  double pendingAmount = 5000;
  double collectionPercentage = 67;
  final String studentName =
      "Arjun Kumar";

  final String rollNo =
      "01";

  final String className =
      "Class 1";

  final String section =
      "A";

  final String admissionNo =
      "ADM001";

  final String mobileNo =
      "9876543210";

  final String feeStatus =
      "PARTIAL";

  Widget buildCollectFeeButton() {

    return Container(
      height: 60,
      width: 180,

      decoration: BoxDecoration(
        color: AppColors.primaryBlue,

        borderRadius:
        BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: const Row(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(
            Icons.add,
            color: Colors.white,
          ),

          SizedBox(width: 8),

          Text(
            "Collect Fee",

            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {

    return  Padding(
      padding: EdgeInsets.all(10),
      child: Row(

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
                  "Student Fee Summary",

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
      ),
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

          HapticFeedback.lightImpact();
          Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => CollectFeeScreen()
          )
          );

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

  Widget buildStudentProfileCard() {

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFDCE7FF),
        ),
      ),

      child: Column(
        children: [

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              /// PHOTO
              Container(
                width: 70,
                height: 70,

                decoration: BoxDecoration(
                  color:
                  const Color(0xFFEFF4FF),

                  borderRadius:
                  BorderRadius.circular(40),
                ),

                child: const Icon(
                  Icons.person,
                  size: 30,
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
                      studentName,

                      style:
                      const TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                        color:
                        Color(0xFF081B5C),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),

                      decoration:
                      BoxDecoration(
                        color:
                        const Color(
                            0xFFEAFBF0),

                        borderRadius:
                        BorderRadius
                            .circular(
                            20),

                        border:
                        Border.all(
                          color:
                          const Color(
                              0xFF22C55E),
                        ),
                      ),

                      child: const Row(
                        mainAxisSize:
                        MainAxisSize.min,

                        children: [

                          CircleAvatar(
                            radius: 4,
                            backgroundColor:
                            Colors.orange,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "PARTIAL",


                            style:
                            TextStyle(
                              fontSize: 12,
                              color:
                              Color(
                                  0xFF16A34A),
                              fontWeight:
                              FontWeight
                                  .w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// ROLL NUMBER
            /*  Container(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                decoration:
                BoxDecoration(
                  borderRadius:
                  BorderRadius
                      .circular(16),

                  border: Border.all(
                    color:
                    AppColors.primaryBlue,
                  ),
                ),

                child: Text(
                  rollNo,

                  style:
                  const TextStyle(
                    color:
                    AppColors.primaryBlue,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),*/
            ],
          ),

          const SizedBox(height: 10),

          const Divider(),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                child: buildInfoTile(
                  Icons.badge_outlined,
                  "Admission No.",
                  admissionNo,
                  AppColors.primaryBlue
                ),
              ),
              Expanded(
                child: buildInfoTile(
                    Icons.phone_outlined,
                    "Mobile No.",
                    mobileNo,
                    AppColors.primaryBlue
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildInfoTile(
      IconData icon,
      String title,
      String value,
      Color color
      ) {

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Icon(
          icon,
          size: 22,
          color:
          color,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style:
                const TextStyle(
                  fontSize: 13,
                  color:
                  Color(0xFF667085),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,

                style:
                const TextStyle(
                  fontSize: 13,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSummaryCards() {

    return GridView.count(
      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      crossAxisCount: 3,

      crossAxisSpacing: 12,
      mainAxisSpacing: 12,

      childAspectRatio: 0.65,

      children: [

        buildSummaryCard(
          title: "Total Fee",
          value: "₹15,000",
          icon: Icons.account_balance_wallet_outlined,
          iconColor: AppColors.primaryBlue,
          bgColor: const Color(0xFFF5F8FF),
        ),

        buildSummaryCard(
          title: "Paid",
          value: "₹10,000",
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF22C55E),
          bgColor: const Color(0xFFF1FCF5),
        ),

        buildSummaryCard(
          title: "Pending",
          value: "₹5,000",
          icon: Icons.receipt_long_outlined,
          iconColor: const Color(0xFFF97316),
          bgColor: const Color(0xFFFFF8F2),
        )
      ],
    );
  }
  Widget buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: bgColor,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: Colors.white,
        ),
      ),

      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Container(
            height: 52,
            width: 52,

            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,

            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF344054),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,

            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: iconColor,
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
    required String discount,
  }) {

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),

      child: Row(
        children: [

          Expanded(
            flex: 4,

            child: Row(
              children: [

                Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    title,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,

            child: Text(
              discount,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
          ),

          Expanded(
            flex: 2,

            child: Text(
              amount,
              textAlign: TextAlign.end,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF081B5C),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeStructureCard() {

    return InkWell(
      onTap: (){
        HapticFeedback.lightImpact();
      },
      child: Container(
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

                const Expanded(
                  child: Text(
                    "Fee Structure",

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF081B5C),
                    ),
                  ),
                ),

                OutlinedButton.icon(

                  onPressed: () {

                    HapticFeedback.lightImpact();

                    _showUpdateFeeStructureBottomSheet();

                  },

                  icon: const Icon(
                    Icons.edit_rounded,
                    size: 18,
                  ),

                  label: const Text("Update"),

                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2457FF),

                    side: const BorderSide(
                      color: Color(0xFF2457FF),
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(
                children: [

                  Expanded(
                    flex: 4,
                    child: Text(
                      "Fee Type",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      "Disc",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      "Fee",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            buildFeeRow(
              icon: Icons.school_rounded,
              iconColor: const Color(0xFF2457FF),
              title: "School Fee",
              discount: "0",
              amount: "₹2,000",
            ),

            buildFeeRow(
              icon: Icons.menu_book_rounded,
              iconColor: const Color(0xFFF97316),
              title: "Books Fee",
              discount: "0",
              amount: "₹500",
            ),

            buildFeeRow(
              icon: Icons.checkroom_rounded,
              iconColor: const Color(0xFF22C55E),
              title: "Uniform Fee",
              discount: "0",
              amount: "₹300",
            ),

            buildFeeRow(
              icon: Icons.person_add_alt_rounded,
              iconColor: const Color(0xFFEC4899),
              title: "Admission Fee",
              discount: "0",
              amount: "₹200",
            ),

            const Divider(),

            Row(
              children: [

                const Expanded(
                  child: Text(
                    "Total Fee",

                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2457FF),
                    ),
                  ),
                ),
                const Text(
                  "₹3,000",

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2457FF),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Widget buildPendingDuesCard() {

    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4E7EC),
        ),
      ),

      child: Column(
        children: [

          Row(
            children: const [

              Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFF97316),
              ),

              SizedBox(width: 10),

              Text(
                "Pending Dues",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF081B5C),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ...pendingDues.map(
                (item) => Padding(
              padding:
              const EdgeInsets.only(
                bottom: 10,
              ),

              child: Row(
                children: [

                  Expanded(
                    child: Text(
                      item["title"],

                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),

                  Text(
                    "₹${item["amount"]}",

                    style:
                    const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.w600,
                      color:
                      Color(0xFFF97316),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(),

          Row(
            children: [

              const Expanded(
                child: Text(
                  "Total Pending",

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              Text(
                "₹${pendingAmount.toInt()}",

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                  color:
                  Color(0xFFF97316),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPaymentHistoryCard() {

    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4E7EC),
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: const [

              Icon(
                Icons.receipt_long_rounded,
                color: AppColors.primaryBlue,
              ),

              SizedBox(width: 10),

              Text(
                "Payment History",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF081B5C),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ...paymentHistory.map(
                (payment) {

              return buildPaymentHistoryItem(
                date: payment["date"],
                amount: payment["amount"],
                mode: payment["mode"],
                receiptNo:
                payment["receiptNo"],
              );

            },
          ),
        ],
      ),
    );
  }
  Widget buildPaymentHistoryItem({
    required String date,
    required int amount,
    required String mode,
    required String receiptNo,
  }) {

    Color modeColor;

    switch (mode) {

      case "Cash":
        modeColor = Colors.green;
        break;

      case "UPI":
        modeColor = Colors.blue;
        break;

      default:
        modeColor = Colors.purple;
    }

    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 14,
      ),

      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          Container(
            height: 40,
            width: 40,

            decoration: BoxDecoration(
              color:
              AppColors.primaryBlue
                  .withOpacity(0.1),

              borderRadius:
              BorderRadius.circular(
                  14),
            ),

            child: const Icon(
              Icons.currency_rupee,
              color:
              AppColors.primaryBlue,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  "₹$amount",

                  style:
                  const TextStyle(
                    fontSize: 14,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Color(0xFF081B5C),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,

                  style:
                  const TextStyle(
                    color:
                    Color(0xFF667085),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  receiptNo,

                  style:
                  const TextStyle(
                    fontSize: 12,
                    color:
                    Color(0xFF98A2B3),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color:
              modeColor.withOpacity(
                  0.1),

              borderRadius:
              BorderRadius.circular(
                  20),
            ),

            child: Text(
              mode,

              style: TextStyle(
                fontSize: 13,
                color: modeColor,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateFeeStructureBottomSheet() {

    showModalBottomSheet(

      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {

        return StatefulBuilder(

          builder: (context, setBottomState) {

            return Container(

              height:
              MediaQuery.of(context)
                  .size
                  .height *
                  0.90,

              decoration: const BoxDecoration(

                color: Color(0xFFF7F9FC),

                borderRadius:
                BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),

              child: Column(

                children: [

                  _buildBottomSheetHeader(),

                  Expanded(
                    child: ListView(
                      padding:
                      const EdgeInsets.all(
                          20),

                      children: [

                        ...editableFees.map(
                              (fee) {

                            return buildEditableFeeRow(
                              fee,
                              setBottomState,
                            );

                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        _buildFeeSummary(),

                        const SizedBox(
                          height: 30,
                        ),

                        SizedBox(
                          height: 55,

                          child:
                          ElevatedButton(

                            onPressed: () {

                              Navigator.pop(
                                  context);

                              setState(() {

                                /// Update main screen
                              });
                            },

                            child: const Text(
                              "Update Fee Structure",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomSheetHeader() {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),

      child: Row(

        children: [

          const Expanded(

            child: Text(
              "Update Fee Structure",

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                FontWeight.w700,
              ),
            ),
          ),

          IconButton(

            onPressed: () {

              Navigator.pop(context);

            },

            icon: const Icon(
              Icons.close_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableFeeRow(
      Map<String, dynamic> fee,
      StateSetter setBottomState,
      ) {

    return Container(

      margin:
      const EdgeInsets.only(
        bottom: 14,
      ),

      padding:
      const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Column(

        children: [

          Row(

            children: [

              Switch(

                value: fee["enabled"],

                onChanged: (value) {

                  setBottomState(() {

                    fee["enabled"] =
                        value;

                  });
                },
              ),
              SizedBox(width: 10.0),

              Icon(
                fee["icon"],
                color: fee["color"],
              ),

              const SizedBox(
                width: 10,
              ),

              Expanded(
                child: Text(
                  fee["title"],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(

            children: [

              Expanded(

                child: TextFormField(

                  initialValue:
                  fee["discount"]
                      .toString(),

                  keyboardType:
                  TextInputType.number,

                  decoration:
                  const InputDecoration(
                    labelText:
                    "Discount",
                  ),

                  onChanged: (value) {

                    double discount =
                        double.tryParse(
                            value) ??
                            0;

                    setBottomState(() {

                      fee["discount"] =
                          discount;

                      fee["finalFee"] =
                          fee["originalFee"] -
                              discount;
                    });
                  },
                ),
              ),

              const SizedBox(width: 10),

              Expanded(

                child: TextFormField(

                  initialValue:
                  fee["finalFee"]
                      .toString(),

                  keyboardType:
                  TextInputType.number,

                  decoration:
                  const InputDecoration(
                    labelText:
                    "Final Fee",
                  ),

                  onChanged: (value) {

                    double finalFee =
                        double.tryParse(
                            value) ??
                            0;

                    setBottomState(() {

                      fee["finalFee"] =
                          finalFee;

                      fee["discount"] =
                          fee["originalFee"] -
                              finalFee;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeeSummary() {

    double totalDiscount = 0;
    double totalFee = 0;

    for (var fee in editableFees) {

      if (fee["enabled"]) {

        totalDiscount +=
        fee["discount"];

        totalFee +=
        fee["finalFee"];
      }
    }

    return Container(

      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Column(

        children: [

          Row(
            children: [

              const Expanded(
                child: Text(
                    "Total Discount"),
              ),

              Text(
                "₹${totalDiscount.toStringAsFixed(0)}",
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [

              const Expanded(
                child:
                Text("Final Fee"),
              ),

              Text(
                "₹${totalFee.toStringAsFixed(0)}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [

                      buildStudentProfileCard(),
                      const SizedBox(height: 10),
                      buildSummaryCards(),
                      const SizedBox(height: 10),
                      _buildFeeStructureCard(),
                      const SizedBox(height: 10),
                      buildCollectionProgressCard(),
                      const SizedBox(height: 10),
                      buildPendingDuesCard(),
                      const SizedBox(height: 10),
                      buildPaymentHistoryCard(),
                      const SizedBox(height: 100)
                    ],
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: _buildCollectFeeButton() ,
    );
  }
}