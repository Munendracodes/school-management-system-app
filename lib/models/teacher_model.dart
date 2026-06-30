class TeacherModel {

  final String teacherId;

  final String teacherName;

  TeacherModel({

    required this.teacherId,

    required this.teacherName,
  });

  factory TeacherModel.fromJson(
      Map<dynamic, dynamic> json) {

    return TeacherModel(

      teacherId:
      json["teacherId"] ?? "",

      teacherName:
      json["teacherName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "teacherId": teacherId,

      "teacherName": teacherName,
    };
  }
}