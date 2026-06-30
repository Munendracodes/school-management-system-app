import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum ProfileType {
  student,
  teacher,
  parent,
  admin,
}

class FirebaseFileService {

  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  final DatabaseReference _database =
  FirebaseDatabase.instance.ref();

  String _folder(ProfileType type) {

    switch (type) {

      case ProfileType.student:
        return "students";

      case ProfileType.teacher:
        return "teachers";

      case ProfileType.parent:
        return "parents";

      case ProfileType.admin:
        return "admins";
    }
  }

  Future<String> uploadProfilePhoto({

    required ProfileType type,

    required String id,

    required File image,

  }) async {

    final folder = _folder(type);

    final storageRef = _storage

        .ref()

        .child("profile-images")

        .child(folder)

        .child("$id.jpg");

    await storageRef.putFile(image);

    final downloadUrl =
    await storageRef.getDownloadURL();

    await _database

        .child("profilePhotos")

        .child(folder)

        .child(id)

        .set({

      "photoUrl": downloadUrl,

      "updatedOn":
      DateTime.now().toIso8601String(),
    });

    return downloadUrl;
  }

  Future<String?> getProfilePhoto({

    required ProfileType type,

    required String id,

  }) async {

    final folder = _folder(type);

    final snapshot = await _database

        .child("profilePhotos")

        .child(folder)

        .child(id)

        .get();

    if (!snapshot.exists) {

      return null;
    }

    final data =
    Map<String, dynamic>.from(

      snapshot.value as Map,
    );

    return data["photoUrl"];
  }

  Future<void> deleteProfilePhoto({

    required ProfileType type,

    required String id,

  }) async {

    final folder = _folder(type);

    try {

      await _storage

          .ref()

          .child("profile-images")

          .child(folder)

          .child("$id.jpg")

          .delete();

    } catch (_) {}

    await _database

        .child("profilePhotos")

        .child(folder)

        .child(id)

        .remove();
  }
}