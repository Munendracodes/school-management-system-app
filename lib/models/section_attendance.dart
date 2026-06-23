class SectionAttendance {

  String className;

  String sectionName;

  int students;

  bool fnCaptured;

  bool anCaptured;

  double attendancePercentage;

  int presentCount;

  String teacherName;

  SectionAttendance({

    required this.className,
    required this.sectionName,
    required this.students,
    required this.fnCaptured,
    required this.anCaptured,
    required this.attendancePercentage,
    required this.presentCount,
    required this.teacherName,
  });
}