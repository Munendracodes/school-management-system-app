import 'dart:convert';

import 'package:gallery_saver_plus/files.dart';
import 'package:http/http.dart' as http;

class ClassroomService {

  static Future<void> createClassroom({

    required String accessToken,

    required String name,

    required String academicYearId,

  }) async {

    final response = await http.post(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/classrooms",
      ),

      headers: {

        "Authorization":
        "Bearer $accessToken",

        "Content-Type":
        "application/json",
      },

      body: jsonEncode({

        "name": name,

        "academic_year_id":
        academicYearId,
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {

      throw Exception("Failed to create classroom");
    }
  }
}