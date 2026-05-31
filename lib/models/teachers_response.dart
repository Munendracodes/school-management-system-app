
class TeacherResponse{
  final List<TeacherData> teachers;

  TeacherResponse({
    required this.teachers
});
  factory TeacherResponse.fromJson(
      List<dynamic> json,
      ){
    return TeacherResponse(
        teachers:
        json.map(
            (e) => TeacherData.fromJson(e),
        ).toList()
    );
  }
}

class TeacherData{
  final String id;
  final String fullName;
  final String mobileNumber;
  final String email;

  TeacherData({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.email
});
  factory TeacherData.fromJson(
      Map<String, dynamic> json,
      ){
    return TeacherData(
        id:
          json["id"] ?? "",
        fullName:
        json["full_name"] ?? "",
      mobileNumber:
        json["mobile_number"] ?? "",
      email:
        json["email"] ?? ""

    );
  }

}