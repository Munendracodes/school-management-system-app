import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/parent_response.dart';

class ParentsService {

  static Future<ParentsResponse>
  getParents({

    required String accessToken,

  }) async {

    final response = await http.get(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/parents",
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

      return ParentsResponse.fromJson(data);

    } else {

      throw Exception(
        "Failed to load parents",
      );
    }
  }

  static Future<String>
  createParent({

    required String accessToken,

    required String fullName,

    required String mobileNumber,

    required String email,

  }) async {

    final response = await http.post(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/parents",
      ),

      headers: {

        "Content-Type":
        "application/json",

        "Accept":
        "application/json",

        "Authorization":
        "Bearer $accessToken",
      },

      body: jsonEncode({

        "full_name":
        fullName,

        "mobile_number":
        mobileNumber,

        "email":
        email,
      }),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {

      final data =
      jsonDecode(response.body);

      return data["id"];

    } else {

      throw Exception(
        "Failed to create parent",
      );
    }
  }

  static Future<void>
  mapParent({

    required String accessToken,

    required String studentId,

    required String parentId,

    required String relation,

  }) async {

    final response = await http.post(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/student-parent-mappings",
      ),

      headers: {

        "Content-Type":
        "application/json",

        "Accept":
        "application/json",

        "Authorization":
        "Bearer $accessToken",
      },

      body: jsonEncode({

        "student_id":
        studentId,

        "parent_id":
        parentId,

        "relationship_type":
        relation,
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {

      throw Exception(
        "Failed to map parent",
      );
    }
  }


}