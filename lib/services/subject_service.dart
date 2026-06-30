import 'package:firebase_database/firebase_database.dart';

import '../models/subject_model.dart';

class SubjectService {

  static final DatabaseReference _subjectRef =

  FirebaseDatabase.instance.ref("subjects");

  static Future<void> createSubject({

    required String name,

    required bool isActive,

  }) async {

    final newSubject =
    _subjectRef.push();

    final now = DateTime.now();

    final snapshot =
    await _subjectRef.get();

    int displayOrder = 1;

    if (snapshot.exists) {

      displayOrder =
          snapshot.children.length + 1;
    }

    final subject = SubjectModel(

      id: newSubject.key!,

      name: _toTitleCase(name),

      isActive: isActive,

      displayOrder: displayOrder,

      createdAt: now,

      updatedAt: now,

      teachers: {},
    );

    await newSubject.set(
        subject.toJson());
  }

  static Future<List<SubjectModel>> getSubjects() async {

    final snapshot = await _subjectRef.get();

    if (!snapshot.exists) {
      return [];
    }

    List<SubjectModel> subjects = [];

    for (final child in snapshot.children) {

      subjects.add(

        SubjectModel.fromJson(

          Map<String, dynamic>.from(
            child.value as Map,
          ),
        ),
      );
    }

    /// Sort by display order
    subjects.sort(

          (a, b) =>

          a.displayOrder.compareTo(
            b.displayOrder,
          ),
    );

    return subjects;
  }

  static String _toTitleCase(
      String text) {

    return text

        .trim()

        .split(" ")

        .where((e) => e.isNotEmpty)

        .map((word) {

      return

        word[0].toUpperCase() +

            word.substring(1)
                .toLowerCase();

    })

        .join(" ");
  }


}