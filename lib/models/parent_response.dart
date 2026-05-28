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

  ParentData({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
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
    );
  }
}