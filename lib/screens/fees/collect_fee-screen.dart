import 'package:flutter/material.dart';

import '../../models/fee_item.dart';

class CollectFeeScreen extends StatefulWidget {

  const CollectFeeScreen({
    super.key
  });

  @override
  State<CollectFeeScreen> createState() => _CollectFeeScreenState();
}

class _CollectFeeScreenState extends State<CollectFeeScreen> {


  String selectedPaymentMethod = "Cash";

  final List<String> feeTypes = [

    "School Fee",
    "Books Fee",
    "Uniform Fee",
    "Admission Fee",
    "Transport Fee",
    "Exam Fee",
  ];
  String studentName = "Arjun Kumar";

  String className = "5 - A";

  String rollNo = "12";

  String admissionNo = "ADM20250012";
  List<FeeItem> feeItems = [
    FeeItem(
      feeType: "School Fee",
      amount: 0,
    ),
  ];


  final remarksController =
  TextEditingController();

  String receiptNo =
      "RCP2506200001";

  double get totalAmount {

    double total = 0;

    for (var item in feeItems) {

      total += item.amount;
    }

    return total;
  }

  Widget _buildHeader() {

    return Row(

      children: [

        IconButton(

          onPressed: () {

            Navigator.pop(context);

          },

          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),

        const Expanded(

          child: Text(

            "Collect Fee",

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ),

        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildReceiptCard() {

    return Container(

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Row(

        children: [

          Container(

            height: 40,
            width: 40,

            decoration: BoxDecoration(

              color:
              const Color(0xFF2457FF),

              borderRadius:
              BorderRadius.circular(
                  16),
            ),

            child: const Icon(
              Icons.receipt_long,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const Text(
                  "Receipt No.",
                ),

                Text(
                  receiptNo,

                  style:
                  const TextStyle(
                    fontSize: 14,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const Column(

            children: [

              Icon(Icons.calendar_today,
              size: 15),

              SizedBox(height: 6),

              Text(
                "20 Jun 2026",
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudentDetailsCard() {

    return Container(

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [


          Row(

            children: [

              /// PHOTO
              Container(

                height: 70,
                width: 70,

                decoration: BoxDecoration(

                  color:
                  const Color(0xFFF4F6FF),

                  borderRadius:
                  BorderRadius.circular(
                      40),
                ),

                child: const Icon(
                  Icons.person,
                  size: 40,
                  color:
                  Color(0xFF2457FF),
                ),
              ),

              const SizedBox(width: 20),

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
                        FontWeight.w700,
                        color:
                        Color(
                            0xFF081B5C),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Row(

                      children: [

                        Expanded(
                          child:
                          _buildStudentInfo(
                            "Class",
                            className,
                          ),
                        ),

                        Expanded(
                          child:
                          _buildStudentInfo(
                            "Roll No.",
                            rollNo,
                          ),
                        ),

                      /*  Expanded(
                          child:
                          _buildStudentInfo(
                            "Adm No.",
                            admissionNo,
                          ),
                        ),*/
                      ],
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

  Widget _buildStudentInfo(
      String title,
      String value,
      ) {

    return Column(

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
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF081B5C),
          ),
        ),
      ],
    );
  }

  Widget _buildFeeItemsHeader() {

    return Row(

      children: [

        const Expanded(

          child: Text(

            "Fee Items",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),
        ),

        InkWell(

          onTap: () {

            setState(() {

              feeItems.add(
                FeeItem(
                  feeType: feeTypes.first,
                  amount: 0,
                ),
              );
            });
          },

          child: const Row(

            children: [

              Icon(
                Icons.add_circle_outline,
                color: Color(0xFF2457FF),
              ),

              SizedBox(width: 6),

              Text(

                "Add Item",

                style: TextStyle(
                  color: Color(0xFF2457FF),
                  fontWeight:
                  FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildFeeItems() {

    return Column(

      children: List.generate(

        feeItems.length,

            (index) {

          return _buildFeeItemCard(
            index,
            feeItems[index],
          );
        },
      ),
    );
  }
  Widget _buildFeeItemCard(
      int index,
      FeeItem item,
      ) {

    return Container(

      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Column(


        children: [



          Row(

            children: [

              const Expanded(
                flex: 5,
                child: Text(
                  "Fee Type",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF667085),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                flex: 4,
                child: Text(
                  "Amount",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF667085),
                  ),
                ),
              ),
              /// DELETE BUTTON
              Container(

                height: 36,
                width: 36,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F2),
                  borderRadius:
                  BorderRadius.circular(18),
                ),

                child: InkWell(

                  borderRadius:
                  BorderRadius.circular(18),

                  onTap: () {

                    if (feeItems.length == 1) {
                      return;
                    }

                    setState(() {

                      feeItems.removeAt(index);
                    });
                  },

                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
              ),

            ],
          ),





          const SizedBox(height: 8),

          /// INPUT ROW
          Row(
            children: [

              /// FEE TYPE
              Expanded(
                flex: 5,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: item.feeType,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),

                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  items: feeTypes
                      .where((type) {

                    final alreadySelected =
                    feeItems.any((fee) {

                      return fee != item &&
                          fee.feeType == type;
                    });

                    return !alreadySelected ||
                        type == item.feeType;
                  })
                      .map((type) {

                    return DropdownMenuItem(
                      value: type,
                      child: Text(
                        type,
                        overflow:
                        TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {

                    setState(() {

                      item.feeType = value!;
                    });
                  },
                ),
              ),

              const SizedBox(width: 12),

              /// AMOUNT
              Expanded(
                flex: 5,
                child: TextFormField(

                  textAlign: TextAlign.right,

                  initialValue:
                  item.amount == 0
                      ? ""
                      : item.amount.toString(),

                  keyboardType:
                  TextInputType.number,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),

                  decoration: InputDecoration(

                    prefixText: "₹ ",

                    filled: true,

                    fillColor:
                    const Color(0xFFF8FAFC),

                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  onChanged: (value) {

                    setState(() {

                      item.amount =
                          double.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),

              const SizedBox(width: 8),


            ],
          )
        ],
      ),
    );
  }
  Widget _buildTotalAmountCard() {

    return Container(

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Row(

        children: [

          const Expanded(

            child: Text(

              "Total Amount",

              style: TextStyle(
                fontSize: 15,
                fontWeight:
                FontWeight.w700,
                color: Color(0xFF081B5C),
              ),
            ),
          ),

          Text(

            "₹${totalAmount.toStringAsFixed(0)}",

            style: const TextStyle(
              fontSize: 18,
              fontWeight:
              FontWeight.bold,
              color: Color(0xFF2457FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {

    final methods = [
      "Cash",
      "UPI",
      "Card",
      "Bank"
    ];

    return Container(

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Text(

            "Payment Method",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),

          const SizedBox(height: 15),

          Row(

            children: methods.map((method) {

              final selected =
                  selectedPaymentMethod ==
                      method;

              return Expanded(

                child: Padding(

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),

                  child: InkWell(

                    onTap: () {

                      setState(() {

                        selectedPaymentMethod =
                            method;
                      });
                    },

                    child: Container(

                      height: 48,

                      decoration: BoxDecoration(

                        color: selected
                            ? const Color(
                            0xFF2457FF)
                            : Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                            12),

                        border: Border.all(

                          color: selected
                              ? const Color(
                              0xFF2457FF)
                              : const Color(
                              0xFFE4EAF7),
                        ),
                      ),

                      child: Center(

                        child: Text(

                          method,

                          style: TextStyle(

                            color: selected
                                ? Colors.white
                                : const Color(
                                0xFF667085),

                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildRemarksCard() {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE4EAF7),
        ),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Text(

            "Remarks",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081B5C),
            ),
          ),

          const SizedBox(height: 15),

          TextField(

            controller:
            remarksController,

            maxLines: 3,

            decoration:
            InputDecoration(

              hintText:
              "Enter remarks (optional)",

              filled: true,

              fillColor:
              const Color(
                  0xFFF8FAFC),

              border:
              OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(
                    12),

                borderSide:
                BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionSummaryCard() {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: const Color(0xFFF4F8FF),

        borderRadius:
        BorderRadius.circular(20),
      ),

      child: Column(

        children: [

          _buildSummaryRow(
            "Receipt No",
            receiptNo,
          ),

          _buildSummaryRow(
            "Items",
            feeItems.length.toString(),
          ),

          _buildSummaryRow(
            "Payment",
            selectedPaymentMethod,
          ),

          _buildSummaryRow(
            "Amount",
            "₹${totalAmount.toStringAsFixed(0)}",
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
      String title,
      String value,
      ) {

    return Padding(

      padding:
      const EdgeInsets.symmetric(
        vertical: 6,
      ),

      child: Row(

        children: [

          Expanded(
            child: Text(title),
          ),

          Text(

            value,

            style: const TextStyle(

              fontWeight:
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCollectFeeButton() {

    return SizedBox(

      width: double.infinity,
      height: 56,

      child: ElevatedButton(

        onPressed: () {

          _collectFee();
        },

        style: ElevatedButton.styleFrom(

          backgroundColor:
          const Color(0xFF2457FF),

          shape:
          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(
                16),
          ),
        ),

        child: const Text(

          "Collect Fee",

          style: TextStyle(
            fontSize: 18,
            fontWeight:
            FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  void _collectFee() {

    if (totalAmount <= 0) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Please enter amount",
          ),
        ),
      );

      return;
    }

    /// Save Collection

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F9FC),

      body: SafeArea(

        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [

                    _buildReceiptCard(),

                    const SizedBox(height: 10),

                    _buildStudentDetailsCard(),

                    const SizedBox(height: 20),

                    _buildFeeItemsHeader(),

                    const SizedBox(height: 10),

                    _buildFeeItems(),



                    _buildTotalAmountCard(),

                    const SizedBox(height: 10),

                    _buildPaymentMethodCard(),

                    const SizedBox(height: 10),

                    _buildRemarksCard(),

                    _buildCollectionSummaryCard(),

                    _buildCollectFeeButton(),

                    const SizedBox(height: 10),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  }

