class FirebaseAttendance {

  final bool fnCaptured;

  final bool anCaptured;

  final int totalStudents;

  final int presentCount;

  final int partialCount;

  final int absentCount;

  FirebaseAttendance({

    required this.fnCaptured,

    required this.anCaptured,

    required this.totalStudents,

    required this.presentCount,

    required this.partialCount,

    required this.absentCount,
  });

  factory FirebaseAttendance.fromJson(
      Map<dynamic, dynamic> json) {

    return FirebaseAttendance(

      fnCaptured:
      json["fnCaptured"] ?? false,

      anCaptured:
      json["anCaptured"] ?? false,

      totalStudents:
      json["totalStudents"] ?? 0,

      presentCount:
      json["presentCount"] ?? 0,

      partialCount:
      json["partialCount"] ?? 0,

      absentCount:
      json["absentCount"] ?? 0,
    );
  }
}