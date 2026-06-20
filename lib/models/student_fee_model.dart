class StudentFeeModel {

  final String id;
  final String name;
  final String rollNo;
  final String section;
  final double totalFee;
  final double paid;
  final double pending;
  final String status;

  StudentFeeModel({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.section,
    required this.totalFee,
    required this.paid,
    required this.pending,
    required this.status,
  });
}