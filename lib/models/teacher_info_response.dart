class TeacherInfoResponse {

  final String id;

  final String fullName;

  final String mobileNumber;

  final String email;

  TeacherInfoResponse({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
  });

  factory TeacherInfoResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return TeacherInfoResponse(

      id:
      json["id"] ?? "",

      fullName:
      json["full_name"] ?? "",

      mobileNumber:
      json["mobile_number"] ?? "",

      email:
      json["email"] ?? "",
    );
  }
}