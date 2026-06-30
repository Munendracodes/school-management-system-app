import 'package:firebase_database/firebase_database.dart';

import 'package:uuid/uuid.dart';

import '../models/diary_entry_model.dart';

import 'package:intl/intl.dart';

class DiaryService {

  final DatabaseReference _db =
  FirebaseDatabase.instance.ref();

  ///------------------------------------------------
  /// Diary Reference
  ///------------------------------------------------
  DatabaseReference _getDiaryReference({

    required String academicYearId,

    required String className,

    required String sectionName,

    required DateTime date,

  }) {

    return _db
        .child("diary")
        .child(academicYearId)
        .child(className)
        .child(sectionName)
        .child(date.year.toString())
        .child(date.month.toString().padLeft(2, '0'))
        .child(date.day.toString().padLeft(2, '0'));
  }

  Future<List<DiaryEntryModel>> _loadEntries({

    required String academicYearId,

    required String className,

    required String sectionName,

    required DateTime date,

  }) async {

    final snapshot = await _getDiaryReference(

      academicYearId: academicYearId,

      className: className,

      sectionName: sectionName,

      date: date,

    ).get();

    if (!snapshot.exists) {

      return [];
    }

    final Map<dynamic, dynamic> map =

    Map<dynamic, dynamic>.from(

      snapshot.value as Map,
    );

    return map.values

        .map(

          (e) => DiaryEntryModel.fromJson(

        Map<dynamic, dynamic>.from(e),
      ),
    )

        .toList();
  }

  ///------------------------------------------------
  /// Create Diary Entry
  ///------------------------------------------------
  Future<void> createDiaryEntry({

    required DiaryEntryModel diary,

  }) async {

    final entryDate =

    DateFormat("dd-MM-yyyy")

        .parse(diary.entryDate);

    await _getDiaryReference(

      academicYearId: diary.academicYearId,

      className: diary.className,

      sectionName: diary.sectionName,

      date: entryDate,

    ).child(diary.id).set(

      diary.toJson(),
    );
  }

  ///------------------------------------------------
  /// Get Diary Entries
  ///------------------------------------------------
  Future<List<DiaryEntryModel>> getDiaryEntries({

    required String academicYearId,

    required String className,

    required String sectionName,

    required DateTime date,

  }) async {

    final sectionEntries =

    await _loadEntries(

      academicYearId: academicYearId,

      className: className,

      sectionName: sectionName,

      date: date,
    );

    final allEntries =

    await _loadEntries(

      academicYearId: academicYearId,

      className: className,

      sectionName: "ALL",

      date: date,
    );

    final diaryEntries = [

      ...sectionEntries,

      ...allEntries,
    ];

    diaryEntries.sort(

          (a, b) =>

          b.createdAt.compareTo(

            a.createdAt,
          ),
    );

    return diaryEntries;
  }

  ///------------------------------------------------
  /// Create Teacher Note
  ///------------------------------------------------
  Future<void> createTeacherNote({

    required String academicYearId,

    required String className,

    required String sectionName,

    required String title,

    required String description,

    required String teacherId,

    required String teacherName,

    required String entryDate,

  }) async {

    final diary = DiaryEntryModel(

      id: const Uuid().v4(),

      type: "teacherNote",

      title: title,

      description: description,

      academicYearId: academicYearId,

      className: className,

      sectionName: sectionName,

      subjectId: "",

      subjectName: "",

      teacherId: teacherId,

      teacherName: teacherName,

      referenceId: "",

      entryDate: entryDate,

      isActive: true,

      createdAt: DateTime.now(),

      updatedAt: DateTime.now(),
    );

    await createDiaryEntry(

      diary: diary,
    );
  }

  ///------------------------------------------------
  /// Create Circular
  ///------------------------------------------------
  Future<void> createSchoolCircular({

    required String academicYearId,

    required String className,

    required String sectionName,

    required String title,

    required String description,

    required String teacherId,

    required String teacherName,

    required String entryDate,

  }) async {

    final diary = DiaryEntryModel(

      id: const Uuid().v4(),

      type: "circular",

      title: title,

      description: description,

      academicYearId: academicYearId,

      className: className,

      sectionName: sectionName,

      subjectId: "",

      subjectName: "",

      teacherId: teacherId,

      teacherName: teacherName,

      referenceId: "",

      entryDate: entryDate,

      isActive: true,

      createdAt: DateTime.now(),

      updatedAt: DateTime.now(),
    );

    await createDiaryEntry(

      diary: diary,
    );
  }
}