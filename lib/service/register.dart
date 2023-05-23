import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style/const/env.dart';

class Register {
  final Dio _dio = Dio(BaseOptions(baseUrl: StringURLRequest.baseURL));

  // Login user with username and password
  Future<dynamic> register(String username, email, phone, password) async {
    final response = await _dio.post(
      'https://webnmobivinhlong.top/api/user/register',
      data: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
      }),
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    final responseBody = response.data;
    if (response.statusCode == 200) {
      print('success');
    } else {
      final errorResponse = json.decode(response.data);
      throw Exception(errorResponse);
    }
    // Hiển thị thông báo lỗi
  }
}
