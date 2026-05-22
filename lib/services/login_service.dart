import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/login_request.dart';
import '../models/login_response.dart';

class LoginService {

  static Future<LoginResponse> login({

    required LoginRequest request,
  }) async {

    final response = await http.post(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/auth/login",
      ),

      headers: {

        "Content-Type":
        "application/json",

        "accept":
        "application/json",
      },

      body: jsonEncode(
        request.toJson(),
      ),
    );

    final responseBody =
    jsonDecode(response.body);

    /// SUCCESS
    if (response.statusCode == 200) {

      return LoginResponse.fromJson(
        responseBody,
      );
    }

    /// ERROR
    else {

      throw Exception(
        parseError(responseBody),
      );
    }
  }

  static String parseError(
      dynamic responseBody,
      ) {

    /// SIMPLE ERROR
    if (responseBody["detail"] is String) {

      return responseBody["detail"];
    }

    /// VALIDATION ERROR
    if (responseBody["detail"] is List) {

      final error =
      responseBody["detail"][0];

      final field =
      error["loc"][1];

      if (field == "mobile_number") {

        return
          "Mobile number must be 10 digits";
      }

      if (field == "password") {

        return
          "MPIN must be at least 4 digits";
      }

      return error["msg"];
    }

    return "Something went wrong";
  }
}