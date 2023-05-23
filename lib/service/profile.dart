import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style/const/env.dart';

class ProfileUser {
  final Dio _dio = Dio(BaseOptions(baseUrl: StringURLRequest.baseURL));

  // Login user with username and password
  Future<Map<String, dynamic>> fetchProfileUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('check_token');
    print(token);
    final response = await _dio.get(
      'https://webnmobivinhlong.top/api/user/profile',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    if (response.statusCode == 200) {
      var data = response.data;
      print('user----');
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }
}
