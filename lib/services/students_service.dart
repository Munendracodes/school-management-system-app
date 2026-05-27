import 'dart:convert';
import '../models/create_student_request.dart';

import 'package:http/http.dart' as http;

import '../models/students_response.dart';

class StudentsService {

  static Future<StudentsResponse>
  getStudents({

    required String accessToken,

  }) async {

    final response = await http.get(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/students",
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

      return StudentsResponse.fromJson(
        data,
      );

    } else {

      throw Exception(
        "Failed to load students",
      );
    }
  }
  static Future<bool> createStudent({

    required String accessToken,

    required CreateStudentRequest request,

  }) async {

    final response = await http.post(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/students",
      ),

      headers: {

        "Content-Type":
        "application/json",

        "Accept":
        "application/json",

        "Authorization":
        "Bearer $accessToken",
      },

      body: jsonEncode(
        request.toJson(),
      ),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {

      return true;

    } else {

      final data =
      jsonDecode(response.body);

      throw Exception(
        data["message"] ??
            "Failed to create student",
      );
    }
  }
}