class DiaryEntryModel {

  final String id;

  final String type;

  final String title;

  final String description;

  final String academicYearId;

  final String className;

  final String sectionName;

  final String subjectId;

  final String subjectName;

  final String teacherId;

  final String teacherName;

  final String referenceId;

  final String entryDate;

  final bool isActive;

  final DateTime createdAt;

  final DateTime updatedAt;

  DiaryEntryModel({

    required this.id,

    required this.type,

    required this.title,

    required this.description,

    required this.academicYearId,

    required this.className,

    required this.sectionName,

    required this.subjectId,

    required this.subjectName,

    required this.teacherId,

    required this.teacherName,

    required this.referenceId,

    required this.entryDate,

    required this.isActive,

    required this.createdAt,

    required this.updatedAt,
  });

  factory DiaryEntryModel.fromJson(
      Map<dynamic, dynamic> json) {

    return DiaryEntryModel(

      id: json["id"] ?? "",

      type: json["type"] ?? "",

      title: json["title"] ?? "",

      description: json["description"] ?? "",

      academicYearId:
      json["academicYearId"] ?? "",

      className:
      json["className"] ?? "",

      sectionName:
      json["sectionName"] ?? "",

      subjectId:
      json["subjectId"] ?? "",

      subjectName:
      json["subjectName"] ?? "",

      teacherId:
      json["teacherId"] ?? "",

      teacherName:
      json["teacherName"] ?? "",

      referenceId:
      json["referenceId"] ?? "",

      entryDate:
      json["entryDate"] ?? "",

      isActive:
      json["isActive"] ?? true,

      createdAt: DateTime.parse(
          json["createdAt"]),

      updatedAt: DateTime.parse(
          json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "type": type,

      "title": title,

      "description": description,

      "academicYearId": academicYearId,

      "className": className,

      "sectionName": sectionName,

      "subjectId": subjectId,

      "subjectName": subjectName,

      "teacherId": teacherId,

      "teacherName": teacherName,

      "referenceId": referenceId,

      "entryDate": entryDate,

      "isActive": isActive,

      "createdAt":
      createdAt.toIso8601String(),

      "updatedAt":
      updatedAt.toIso8601String(),
    };
  }
}