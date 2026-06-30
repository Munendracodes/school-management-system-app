import 'dart:convert';

import 'package:http/http.dart' as http;

class SectionService {

  static Future<void> createSection({

    required String accessToken,

    required String sectionName,

    required String classroomId,

  }) async {

    final response = await http.post(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/sections",
      ),

      headers: {

        "Authorization": "Bearer $accessToken",

        "Accept": "application/json",

        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "name": sectionName,

        "classroom_id": classroomId,
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {

      throw Exception(

        jsonDecode(response.body)["detail"] ??

            "Failed to create section",
      );
    }
  }
}