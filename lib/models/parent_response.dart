class ParentsResponse {

  final List<ParentData> parents;

  ParentsResponse({
    required this.parents,
  });

  factory ParentsResponse.fromJson(
      List<dynamic> json,
      ) {

    return ParentsResponse(

      parents:
      json.map(

            (e) =>
            ParentData.fromJson(e),

      ).toList(),
    );
  }
}


class ParentData {

  final String id;

  final String fullName;

  final String mobileNumber;

  final String email;

  final List<childrenData> children;

  ParentData({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.children
  });

  factory ParentData.fromJson(
      Map<String, dynamic> json,
      ) {

    return ParentData(

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
            (e) => childrenData.fromJson(e),
      )
          .toList(),

    );
  }
}

class childrenData {
  final String fullName;
  final String className;
  final String section;

  childrenData({
    required this.fullName,
    required this.className,
    required this.section,
  });

  factory childrenData.fromJson(Map<String, dynamic> json,) {
    return childrenData(

      fullName:
      json["full_name"] ?? "",

      className:
      json["classroom"]["name"] ?? "",
      section:
      json["section"]["name"] ?? "",

    );
  }
}
