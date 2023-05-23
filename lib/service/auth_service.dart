import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style/const/env.dart';

class AuthService {
  late SharedPreferences _pre;

  final Dio _dio = Dio(BaseOptions(baseUrl: StringURLRequest.baseURL));

  // Login user with username and password
  Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio.post(
        StringURLRequest.loginURL,
        data: jsonEncode({"email": email, "password": password}),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final responseBody = response.data;
      if (response.statusCode == 200) {
        final token = responseBody['access_token'];
        _pre = await SharedPreferences.getInstance();
        await _pre.setString('check_token', token);
        print(token);
        return token;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('check_token');
    final rememberMe = prefs.getBool('remember_me') ?? false;
    print(rememberMe);
    print(token);

    if (token != null && rememberMe) {
      return true;
    } else {
      return false;
    }
  }

  //logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('check_token');
  }
}
