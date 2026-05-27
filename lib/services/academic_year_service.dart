import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/active_academic_year_response.dart';

class AcademicYearService {

  static Future<ActiveAcademicYearResponse>
  getActiveAcademicYear({

    required String accessToken,

  }) async {

    final response = await http.get(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/academic-years/active",
      ),

      headers: {

        "Accept": "application/json",

        "Authorization":
        "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {

      return ActiveAcademicYearResponse.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception(
        "Failed to load academic year",
      );
    }
  }
}