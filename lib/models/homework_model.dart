class HomeworkModel {

  final String id;

  final String subjectId;

  final String subjectName;

  final String title;

  final String description;

  final String academicYearId;

  final String academicYearName;

  final String classId;

  final String className;

  final String sectionId;

  final String sectionName;

  final String teacherId;

  final String teacherName;

  final String assignedDate;

  final String? dueDate;

  final int totalStudents;

  final int submittedStudents;

  final int pendingStudents;

  final bool isActive;

  final DateTime createdAt;

  final DateTime updatedAt;

  HomeworkModel({

    required this.id,

    required this.subjectId,

    required this.subjectName,

    required this.title,

    required this.description,

    required this.academicYearId,

    required this.academicYearName,

    required this.classId,

    required this.className,

    required this.sectionId,

    required this.sectionName,

    required this.teacherId,

    required this.teacherName,

    required this.assignedDate,

    this.dueDate,

    required this.totalStudents,

    required this.submittedStudents,

    required this.pendingStudents,

    required this.isActive,

    required this.createdAt,

    required this.updatedAt,
  });

  factory HomeworkModel.fromJson(
      Map<dynamic, dynamic> json) {

    return HomeworkModel(

      id: json["id"] ?? "",

      subjectId: json["subjectId"] ?? "",

      subjectName: json["subjectName"] ?? "",

      title: json["title"] ?? "",

      description: json["description"] ?? "",

      academicYearId:
      json["academicYearId"] ?? "",

      academicYearName:
      json["academicYearName"] ?? "",
      classId: json["classId"] ?? "",

      className: json["className"] ?? "",

      sectionId: json["sectionId"] ?? "",

      sectionName: json["sectionName"] ?? "",

      teacherId: json["teacherId"] ?? "",

      teacherName: json["teacherName"] ?? "",

      assignedDate: json["assignedDate"] ?? "",

      dueDate: json["dueDate"],

      totalStudents: json["totalStudents"] ?? 0,

      submittedStudents: json["submittedStudents"] ?? 0,

      pendingStudents: json["pendingStudents"] ?? 0,

      isActive: json["isActive"] ?? true,

      createdAt:
      DateTime.parse(json["createdAt"]),

      updatedAt:
      DateTime.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "subjectId": subjectId,

      "subjectName": subjectName,

      "title": title,

      "description": description,

      "academicYearId": academicYearId,

      "academicYearName": academicYearName,

      "classId": classId,

      "className": className,

      "sectionId": sectionId,

      "sectionName": sectionName,

      "teacherId": teacherId,

      "teacherName": teacherName,

      "assignedDate": assignedDate,

      "dueDate": dueDate,

      "totalStudents": totalStudents,

      "submittedStudents": submittedStudents,

      "pendingStudents": pendingStudents,

      "isActive": isActive,

      "createdAt":
      createdAt.toIso8601String(),

      "updatedAt":
      updatedAt.toIso8601String(),
    };
  }
}