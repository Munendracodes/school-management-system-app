class StudentsResponse {

  final List<StudentData> students;

  StudentsResponse({
    required this.students,
  });

  factory StudentsResponse.fromJson(
      List<dynamic> json,
      ) {

    return StudentsResponse(

      students:

      json.map(

            (e) => StudentData.fromJson(e),

      ).toList(),
    );
  }
}

class StudentData {

  final String fullName;

  final String className;

  final String sectionName;

  final String profileImage;

  StudentData({
    required this.fullName,
    required this.className,
    required this.sectionName,
    required this.profileImage,
  });

  factory StudentData.fromJson(
      Map<String, dynamic> json,
      ) {

    return StudentData(

      fullName:
      json["full_name"] ?? "",

      className:
      json["classroom"]?["name"] ?? "",

      sectionName:
      json["section"]?["name"] ?? "",

      profileImage:
      json["profile_image"] ??
          "https://i.pravatar.cc/150?img=12",
    );
  }
}