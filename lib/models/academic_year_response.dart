

class AcademicYearResponse {
  final List<AcademicYearData> academicYears;

  AcademicYearResponse({
    required this.academicYears
});
  factory AcademicYearResponse.fromJson(
      List<dynamic> json,
      ){
    return AcademicYearResponse(
        academicYears:
        json.map(
            (e) => AcademicYearData.fromJson(e)
        ).toList()
    );
  }
}

class AcademicYearData{


  final String name;
  final String startdate;
  final String enddate;
  final bool isActive;
  final String id;


  AcademicYearData({
    required this.name,
    required this.startdate,
    required this.enddate,
    required this.isActive,
    required this.id
  });

  factory AcademicYearData.fromJson(
      Map<String, dynamic> json
      ){
    return AcademicYearData(
        name : json["name"] ?? "",
        startdate : json["start_date"] ?? "",
        enddate : json["end_date"] ?? "",
        isActive : json["is_active"] ?? "",
      id : json["id"] ?? ""
    );
  }

}

