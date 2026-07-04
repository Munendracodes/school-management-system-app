class StudentHomeworkReviewModel {

  final String studentId;

  final String studentName;

  final bool isSubmitted;

  final int rating;

  final String remarks;

  final String submittedAt;

  const StudentHomeworkReviewModel({

    required this.studentId,

    required this.studentName,

    required this.isSubmitted,

    required this.rating,

    required this.remarks,

    required this.submittedAt,
  });

  factory StudentHomeworkReviewModel.fromJson(
      Map<dynamic, dynamic> json) {

    return StudentHomeworkReviewModel(

      studentId: json["studentId"] ?? "",

      studentName: json["studentName"] ?? "",

      isSubmitted: json["isSubmitted"] ?? false,

      rating: json["rating"] ?? 0,

      remarks: json["remarks"] ?? "",

      submittedAt: json["submittedAt"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "studentId": studentId,

      "studentName": studentName,

      "isSubmitted": isSubmitted,

      "rating": rating,

      "remarks": remarks,

      "submittedAt": submittedAt,
    };
  }

  StudentHomeworkReviewModel copyWith({

    String? studentId,

    String? studentName,

    bool? isSubmitted,

    int? rating,

    String? remarks,

    String? submittedAt,

  }) {

    return StudentHomeworkReviewModel(

      studentId: studentId ?? this.studentId,

      studentName: studentName ?? this.studentName,

      isSubmitted: isSubmitted ?? this.isSubmitted,

      rating: rating ?? this.rating,

      remarks: remarks ?? this.remarks,

      submittedAt: submittedAt ?? this.submittedAt,
    );
  }
}