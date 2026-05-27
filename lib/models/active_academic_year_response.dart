class ActiveAcademicYearResponse {

  final String id;
  final String name;

  final List<ClassroomData> classrooms;

  ActiveAcademicYearResponse({
    required this.id,
    required this.name,
    required this.classrooms,
  });

  factory ActiveAcademicYearResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return ActiveAcademicYearResponse(

      id: json["id"] ?? "",

      name: json["name"] ?? "",

      classrooms:
      (json["classrooms"] as List? ?? [])

          .map(
            (e) => ClassroomData.fromJson(e),
      )

          .toList(),
    );
  }
}

class ClassroomData {

  final String id;

  final String name;

  final List<SectionData> sections;

  ClassroomData({
    required this.id,
    required this.name,
    required this.sections,
  });

  factory ClassroomData.fromJson(
      Map<String, dynamic> json,
      ) {

    return ClassroomData(

      id: json["id"] ?? "",

      name: json["name"] ?? "",

      sections:
      (json["sections"] as List? ?? [])

          .map(
            (e) => SectionData.fromJson(e),
      )

          .toList(),
    );
  }
}

class SectionData {

  final String id;

  final String name;

  SectionData({
    required this.id,
    required this.name,
  });

  factory SectionData.fromJson(
      Map<String, dynamic> json,
      ) {

    return SectionData(

      id: json["id"] ?? "",

      name: json["name"] ?? "",
    );
  }
}