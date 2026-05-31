class CreateTeacherRequest {

  final String fullName;
  final String emailid;
  final String mobilenumber;

  CreateTeacherRequest({

    required this.fullName,
    required this.emailid,
    required this.mobilenumber
  });

  Map<String, dynamic> toJson() {

    return {

      "full_name":
      fullName,

      "mobile_number":
      mobilenumber,

      "email":
      emailid
    };
  }
}