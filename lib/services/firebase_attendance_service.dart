import 'package:firebase_database/firebase_database.dart';

import '../models/firebase_attendance.dart';
import '../models/students_response.dart';

class FirebaseAttendanceService {

  final _db = FirebaseDatabase.instance.ref();

  Future<FirebaseAttendance?>
  getAttendance({

    required String className,

    required String sectionName,

    required DateTime date,
  }) async {

    final year =
    date.year.toString();

    final month =
    date.month
        .toString()
        .padLeft(2, '0');

    final day =
    date.day
        .toString()
        .padLeft(2, '0');

    final snapshot = await _db
        .child("attendance")
        .child(year)
        .child(month)
        .child(day)
        .child(className)
        .child(sectionName)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    return FirebaseAttendance
        .fromJson(
      Map<dynamic, dynamic>.from(
        snapshot.value as Map,
      ),
    );
  }



  Future<void> saveAttendance({

    required String className,
    required String sectionName,
    required DateTime attendanceDate,
    required String session,
    required List<StudentData> students,

  }) async {

    final year =
    attendanceDate.year.toString();

    final month =
    attendanceDate.month
        .toString()
        .padLeft(2, '0');

    final day =
    attendanceDate.day
        .toString()
        .padLeft(2, '0');

    final ref =
    FirebaseDatabase.instance

        .ref()

        .child("attendance")

        .child(year)

        .child(month)

        .child(day)

        .child(className)

        .child(sectionName);

    final snapshot = await ref.get();

    Map<String, dynamic> existingData = {};

    if (snapshot.exists) {

      existingData =
      Map<String, dynamic>.from(
        snapshot.value as Map,
      );
    }

    bool fnCaptured =
        existingData["fnCaptured"] ??
            false;

    bool anCaptured =
        existingData["anCaptured"] ??
            false;

    if (session == "FN") {

      fnCaptured = true;
    }

    if (session == "AN") {

      anCaptured = true;
    }

    Map<String, dynamic> studentsData =

    existingData["students"] != null

        ? Map<String, dynamic>.from(
      existingData["students"],
    )

        : {};

    for (final student in students) {

      studentsData[student.id] ??= {

        "studentId":
        student.id,

        "studentName":
        student.fullName,

        "className":
        student.className,

        "sectionName":
        student.sectionName,

        "parentNotified":
        false,

        "fnPresent":
        false,

        "anPresent":
        false,
        "mobileNumber":
            student.mobileNumber,
        "parentName":
            student.parentName
      };

      if (session == "FN") {

        studentsData[student.id]
        ["fnPresent"] =

            student.isFnPresent;
      }

      if (session == "AN") {

        studentsData[student.id]
        ["anPresent"] =

            student.isAnPresent;
      }
    }

    int presentCount = 0;

    int partialCount = 0;

    int absentCount = 0;

    studentsData.forEach(
          (key, value) {

        final fn =
            value["fnPresent"] ?? false;

        final an =
            value["anPresent"] ?? false;

        if (fn && an) {

          presentCount++;
        }

        else if (fn || an) {

          partialCount++;
        }

        else {

          absentCount++;
        }
      },
    );

    await ref.set({

      "fnCaptured":
      fnCaptured,

      "anCaptured":
      anCaptured,

      "totalStudents":
      studentsData.length,

      "presentCount":
      presentCount,

      "partialCount":
      partialCount,

      "absentCount":
      absentCount,

      "lastUpdated":
      DateTime.now()
          .toIso8601String(),

      "students":
      studentsData,
    });
  }

  Future<Map<String, dynamic>?>
  getAttendanceStudents({

    required String className,

    required String sectionName,

    required DateTime attendanceDate,

  }) async {

    try {

      final year =
      attendanceDate.year.toString();

      final month =
      attendanceDate.month
          .toString()
          .padLeft(2, '0');

      final day =
      attendanceDate.day
          .toString()
          .padLeft(2, '0');

      final snapshot =

      await FirebaseDatabase.instance

          .ref()

          .child("attendance")

          .child(year)

          .child(month)

          .child(day)

          .child(className)

          .child(sectionName)

          .child("students")

          .get();

      if (!snapshot.exists) {

        return null;
      }

      return Map<String, dynamic>.from(

        snapshot.value as Map,
      );

    } catch (e) {

      print(
        "Error loading attendance students: $e",
      );

      return null;
    }
  }
}