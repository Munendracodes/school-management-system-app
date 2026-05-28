import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/student_info_response.dart';

class StudentInfoService {

  static Future<StudentInfoResponse>
  getStudentById({

    required String accessToken,
    required String studentId,

  }) async {

    final response = await http.get(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/students/$studentId",
      ),

      headers: {

        "Accept": "application/json",

        "Authorization":
        "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {

      final data =
      jsonDecode(response.body);

      return StudentInfoResponse.fromJson(
        data,
      );

    } else {

      throw Exception(
        "Failed to load student info",
      );
    }
  }
}