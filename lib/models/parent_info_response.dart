class ParentInfoResponse {

  final String id;
  final String fullName;
  final String mobileNumber;
  final String email;
  final List<ChildrenData> children;

  ParentInfoResponse({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.children,
  });

  factory ParentInfoResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return ParentInfoResponse(

      id:
      json["id"] ?? "",

      fullName:
      json["full_name"] ?? "",

      mobileNumber:
      json["mobile_number"] ?? "",

      email:
      json["email"] ?? "",

      children:
      (json["children"] as List? ?? [])

          .map(
            (e) => ChildrenData.fromJson(e),
      )

          .toList(),
    );
  }
}

class ChildrenData {

  final String id;

  final String fullName;

  final String relationshipType;

  final String className;

  final String sectionName;

  final String academicYear;

  ChildrenData({
    required this.id,
    required this.fullName,
    required this.relationshipType,
    required this.className,
    required this.sectionName,
    required this.academicYear,
  });

  factory ChildrenData.fromJson(
      Map<String, dynamic> json,
      ) {

    return ChildrenData(

      id:
      json["id"] ?? "",

      fullName:
      json["full_name"] ?? "",

      relationshipType:
      json["relationship_type"] ?? "",

      className:
      json["classroom"]?["name"] ?? "",

      sectionName:
      json["section"]?["name"] ?? "",

      academicYear:
      json["academic_year"]?["name"] ?? "",
    );
  }
}