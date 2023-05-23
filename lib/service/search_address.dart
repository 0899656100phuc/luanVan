import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/search_data.dart';
import '../style/const/env.dart';

class SearchCity {
  final _dio = Dio();
  Future<List<SearchData>> fetchSearchData(String text) async {
    try {
      final response = await _dio.get(
        'https://webnmobivinhlong.top/api/hotels/searchAddress',
        queryParameters: {'address': text},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonString = json.encode(response.data['data']);
        final List<dynamic> responseData = response.data['data'];
        print(jsonString);

        return responseData.map((e) => SearchData.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
