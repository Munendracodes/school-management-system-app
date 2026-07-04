import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../models/homework_model.dart';
import '../models/student_homework_review_model.dart';

class HomeworkService {

  final DatabaseReference _db =
  FirebaseDatabase.instance.ref();

  ///------------------------------------------
  /// Homework Reference
  ///------------------------------------------
  DatabaseReference _getHomeworkReference({

    required String academicYearId,

    required String classId,

    required String sectionId,

    required DateTime date,

  }) {

    return _db
        .child("homeworks")
        .child(academicYearId)
        .child(classId)
        .child(sectionId)
        .child(date.year.toString())
        .child(date.month.toString().padLeft(2, '0'))
        .child(date.day.toString().padLeft(2, '0'));
  }

  ///------------------------------------------
  /// Create Homework
  ///------------------------------------------
  Future<void> createHomework({

    required HomeworkModel homework,

  }) async {

    final assignedDate =
    DateFormat("dd-MM-yyyy")
        .parse(homework.assignedDate);

    await _getHomeworkReference(

      academicYearId: homework.academicYearId,

      classId: homework.className,

      sectionId: homework.sectionName,

      date: assignedDate,

    ).child(homework.id).set(

      homework.toJson(),
    );
  }

  ///------------------------------------------
  /// Get Homeworks
  ///------------------------------------------
  Future<List<HomeworkModel>> getHomeworks({

    required String academicYearId,

    required String classId,

    required String sectionId,

    required DateTime date,

  }) async {

    final snapshot =
    await _getHomeworkReference(

      academicYearId: academicYearId,

      classId: classId,

      sectionId: sectionId,

      date: date,

    ).get();

    if (!snapshot.exists) {

      return [];
    }

    final Map<dynamic, dynamic> map =
    Map<dynamic, dynamic>.from(
      snapshot.value as Map,
    );

    final homeworks = map.values

        .map(

          (e) => HomeworkModel.fromJson(

        Map<dynamic, dynamic>.from(e),
      ),
    )

        .toList();

    homeworks.sort(

          (a, b) =>

          b.createdAt.compareTo(
              a.createdAt),
    );

    return homeworks;
  }

  ///------------------------------------------
  /// Save Homework Review
  ///------------------------------------------
  Future<void> saveHomeworkReview({

    required String academicYearId,

    required String className,

    required String sectionName,

    required DateTime assignedDate,

    required String homeworkId,

    required String reviewedBy,

    required List<StudentHomeworkReviewModel> students,

  }) async {

    final ref = _getHomeworkReference(

      academicYearId: academicYearId,

      classId: className,

      sectionId: sectionName,

      date: assignedDate,

    ).child(homeworkId);

    int submittedStudents =

        students.where(

              (e) => e.isSubmitted,

        ).length;

    int pendingStudents =

        students.length - submittedStudents;

    final Map<String, dynamic> reviewStudents = {};

    for (final student in students) {

      reviewStudents[student.studentId] =

          student.toJson();
    }

    await ref.child("review").set({

      "isCompleted": true,

      "reviewedBy": reviewedBy,

      "reviewedAt":
      DateTime.now().toIso8601String(),

      "students": reviewStudents,
    });

    await ref.update({

      "submittedStudents": submittedStudents,

      "pendingStudents": pendingStudents,

      "totalStudents": students.length,

    });
  }

  ///------------------------------------------
  /// Get Homework Review
  ///------------------------------------------
  Future<List<StudentHomeworkReviewModel>>
  getHomeworkReview({

    required String academicYearId,

    required String className,

    required String sectionName,

    required DateTime assignedDate,

    required String homeworkId,

  }) async {

    final snapshot =

    await _getHomeworkReference(

      academicYearId: academicYearId,

      classId: className,

      sectionId: sectionName,

      date: assignedDate,

    ).child(homeworkId)

        .child("review")

        .child("students")

        .get();

    if (!snapshot.exists) {

      return [];
    }

    final map = Map<dynamic, dynamic>.from(

      snapshot.value as Map,

    );

    return map.values

        .map(

          (e) => StudentHomeworkReviewModel.fromJson(

        Map<dynamic, dynamic>.from(e),
      ),
    )

        .toList();
  }
}