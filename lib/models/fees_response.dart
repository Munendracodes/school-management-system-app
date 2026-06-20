class FeeData {

  final String className;

  final int studentCount;

  final double schoolFee;

  final double booksFee;

  final double admissionFee;

  final double uniformFee;

  FeeData({
    required this.className,
    required this.studentCount,
    required this.schoolFee,
    required this.booksFee,
    required this.admissionFee,
    required this.uniformFee,
  });

  double get totalFee =>
      schoolFee +
          booksFee +
          admissionFee +
          uniformFee;
}