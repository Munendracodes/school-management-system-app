import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart'
as http;

import '../models/home_response.dart';

class HomeService {

  static Future<HomeResponse>
  getHomeData({

    required String accessToken,
  }) async {

    final response =
    await http.get(

      Uri.parse(
        "https://school-management-system-1ba9.onrender.com/homepage",
      ),

      headers: {

        "Authorization":
        "Bearer $accessToken",

        "accept":
        "application/json",
      },
    );

    debugPrint(
      response.body,
    );

    if (response.statusCode == 200) {

      return HomeResponse.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception(
        "Failed to load home data",
      );
    }
  }
}