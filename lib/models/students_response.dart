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

  final String id;

  final String className;

  final String sectionName;

  final String profileImage;

  final String mobileNumber;

  bool isAbsent;

  bool isPresent;

  bool isFnPresent;

  bool isAnPresent;

  String parentName;


  StudentData({
    required this.id,
    required this.fullName,
    required this.className,
    required this.sectionName,
    required this.profileImage,
    required this.isAbsent,
    required this.isPresent,
    this.isFnPresent = true,
    this.isAnPresent = true,
    required this.mobileNumber,
    required this.parentName
  });

  factory StudentData.fromJson(
      Map<String, dynamic> json,
      ) {

    return StudentData(

      id:
      json["id"] ?? "",

      fullName:
      json["full_name"] ?? "",

      className:
      json["classroom"]?["name"] ?? "",

      sectionName:
      json["section"]?["name"] ?? "",

      profileImage:
      json["profile_image"] ??
          "https://i.pravatar.cc/150?img=12",
      isAbsent:
      false,
      isPresent:
      false,
      mobileNumber:

      (json["parents"] != null &&
          json["parents"] is List &&
          json["parents"].isNotEmpty)

          ? (json["parents"][0]
      ["mobile_number"] ??
          "")

          : "",
      parentName:  (json["parents"] != null &&
          json["parents"] is List &&
          json["parents"].isNotEmpty)

          ? (json["parents"][0]
      ["full_name"] ??
          "")

          : "",
    );
  }
}