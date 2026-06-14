class StudentAttendanceModel {

  final String id;

  final String name;

  bool isPresent;

  bool isAbsent;

  StudentAttendanceModel({
    required this.id,
    required this.name,
    this.isPresent = false,
    this.isAbsent = false,
  });
}