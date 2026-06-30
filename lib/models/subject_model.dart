import 'package:school_management_app/models/teacher_model.dart';

class SubjectModel {

  final String id;

  final String name;

  final bool isActive;

  final int displayOrder;

  final DateTime createdAt;

  final DateTime updatedAt;

  final Map<String, TeacherModel> teachers;

  SubjectModel({

    required this.id,

    required this.name,

    required this.isActive,

    required this.displayOrder,

    required this.createdAt,

    required this.updatedAt,

    required this.teachers,
  });

  factory SubjectModel.fromJson(
      Map<dynamic, dynamic> json) {

    return SubjectModel(

      id: json["id"] ?? "",

      name: json["name"] ?? "",

      isActive: json["isActive"] ?? true,

      displayOrder:
      json["displayOrder"] ?? 0,

      createdAt:
      DateTime.parse(json["createdAt"]),

      updatedAt:
      DateTime.parse(json["updatedAt"]),

      teachers: (json["teachers"] != null)

          ? Map<String, dynamic>.from(json["teachers"]).map(

            (key, value) => MapEntry(

          key,

          TeacherModel.fromJson(

            Map<String, dynamic>.from(value),
          ),
        ),
      )

          : <String, TeacherModel>{},
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "name": name,

      "isActive": isActive,

      "displayOrder": displayOrder,

      "createdAt":
      createdAt.toIso8601String(),

      "updatedAt":
      updatedAt.toIso8601String(),

      "teachers":

      teachers.map(

            (key, value) =>

            MapEntry(

                key,

                value.toJson()),
      ),
    };
  }
}