import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_management_app/models/academic_year_response.dart';

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

  static Future<AcademicYearResponse>
  getAcademicYears({

    required String accessToken,

  }) async {

    final response = await http.get(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/academic-years",
      ),

      headers: {

        "Accept": "application/json",

        "Authorization":
        "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {

      return AcademicYearResponse.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception(
        "Failed to load academic year",
      );
    }
  }

  static Future<void> createAcademicYear({

    required String accessToken,

    required String name,

    required String startDate,

    required String endDate,

    required bool isActive,

  }) async {

    final response = await http.post(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/academic-years",
      ),

      headers: {

        "Accept": "application/json",

        "Content-Type": "application/json",

        "Authorization": "Bearer $accessToken",
      },

      body: jsonEncode({

        "name": name,

        "start_date": startDate,

        "end_date": endDate,

        "is_active": isActive,
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {

      throw Exception(
        jsonDecode(response.body)["detail"] ??
            "Failed to create academic year",
      );
    }
  }
}