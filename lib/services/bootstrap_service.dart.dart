import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/bootstrap_response.dart';

class BootstrapService {

  static Future<BootstrapResponse>
  getBootstrapData() async {

    final response = await http.get(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/settings/bootstrap",
      ),

      headers: {
        "accept": "application/json",
      },
    );

    if (response.statusCode == 200) {

      return BootstrapResponse.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception(
        "Failed to load bootstrap data",
      );
    }
  }
}