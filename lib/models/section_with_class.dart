import 'active_academic_year_response.dart';

class SectionWithClass {

  final String className;

  final SectionData section;

  bool fnCaptured;

  bool anCaptured;

  int presentCount;

  int totalStudents;

  int partialCount;

  int absentCount;

  SectionWithClass({
    required this.className,
    required this.section,

    this.fnCaptured = false,
    this.anCaptured = false,

    this.presentCount = 0,
    this.totalStudents = 0,
    this.partialCount = 0,
    this.absentCount = 0,
  });

  double get attendancePercentage {

    if (totalStudents == 0) {
      return 0;
    }

    return ((presentCount +
        (partialCount * 0.5)) /
        totalStudents) *
        100;
  }
}