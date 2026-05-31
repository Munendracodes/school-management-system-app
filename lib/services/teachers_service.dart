import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:school_management_app/models/teachers_response.dart';

import '../models/create_teacher_request.dart';

class TeachersService{

  static Future<TeacherResponse> getTeachers({
    required String accessToken
  }) async{
    final response = await get(
      Uri.parse("https://school-management-system-1ba9.onrender.com/teachers"),
      headers: {
        "Accept" : "application/json",
        "Authorization" : "Bearer $accessToken"
      },
    );
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);

      return TeacherResponse.fromJson(data);
    }
    else{
      throw Exception("Failded to Load Teachers");
    }
  }
  
  static Future<bool> createTeacher({
    required String accessToken,
    required CreateTeacherRequest request,
    }) async {
    final response = await post(
      Uri.parse("https://school-management-system-1ba9.onrender.com/teachers"),
       headers: {
         "Content-Type": "application/json",
         "Accept" : "application/json",
         "Authorization" : "Bearer $accessToken"
       },
      body: jsonEncode(
          request.toJson()
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
