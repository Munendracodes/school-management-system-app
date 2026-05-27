class CreateStudentRequest {

  final String admissionNumber;

  final String fullName;

  final String gender;

  final String dateOfBirth;

  final String sectionId;

  CreateStudentRequest({
    required this.admissionNumber,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    required this.sectionId,
  });

  Map<String, dynamic> toJson() {

    return {

      "admission_number":
      admissionNumber,

      "full_name":
      fullName,

      "gender":
      gender,

      "date_of_birth":
      dateOfBirth,

      "section_id":
      sectionId,
    };
  }
}