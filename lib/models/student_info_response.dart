class StudentInfoResponse {

  final String id;
  final String admissionNumber;
  final String fullName;
  final String gender;
  final String dateOfBirth;

  final Classroom classroom;
  final Section section;
  final AcademicYear academicYear;

  final List<ParentData> parents;

  StudentInfoResponse({
    required this.id,
    required this.admissionNumber,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    required this.classroom,
    required this.section,
    required this.academicYear,
    required this.parents,
  });

  factory StudentInfoResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return StudentInfoResponse(

      id: json["id"] ?? "",

      admissionNumber:
      json["admission_number"] ?? "",

      fullName:
      json["full_name"] ?? "",

      gender:
      json["gender"] ?? "",

      dateOfBirth:
      json["date_of_birth"] ?? "",

      classroom:
      Classroom.fromJson(
        json["classroom"] ?? {},
      ),

      section:
      Section.fromJson(
        json["section"] ?? {},
      ),

      academicYear:
      AcademicYear.fromJson(
        json["academic_year"] ?? {},
      ),

      parents:
      (json["parents"] as List? ?? [])
          .map(
            (e) => ParentData.fromJson(e),
      )
          .toList(),
    );
  }
}

class Classroom {

  final String id;
  final String name;

  Classroom({
    required this.id,
    required this.name,
  });

  factory Classroom.fromJson(
      Map<String, dynamic> json,
      ) {

    return Classroom(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}

class Section {

  final String id;
  final String name;

  Section({
    required this.id,
    required this.name,
  });

  factory Section.fromJson(
      Map<String, dynamic> json,
      ) {

    return Section(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}

class AcademicYear {

  final String id;
  final String name;

  AcademicYear({
    required this.id,
    required this.name,
  });

  factory AcademicYear.fromJson(
      Map<String, dynamic> json,
      ) {

    return AcademicYear(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}

class ParentData {

  final String id;
  final String fullName;
  final String relationshipType;

  ParentData({
    required this.id,
    required this.fullName,
    required this.relationshipType,
  });

  factory ParentData.fromJson(
      Map<String, dynamic> json,
      ) {

    return ParentData(

      id: json["id"] ?? "",

      fullName:
      json["full_name"] ?? "",

      relationshipType:
      json["relationship_type"] ?? "",
    );
  }
}