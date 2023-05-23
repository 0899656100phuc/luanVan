import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/search_all_data.dart';
import '../model/search_data.dart';

class SearchAllData {
  final _dio = Dio();
  Future<List<Hotel>> searchAllData(
    String address,
    checkinDate,
    checkoutDate,
    int numberPeople,
    numberRooms,
  ) async {
    try {
      final response = await _dio.get(
        'https://webnmobivinhlong.top/api/hotels/search',
        queryParameters: {
          'address': address,
          'numberPeople': numberPeople,
          'numberRooms': numberRooms,
          'checkin_date': checkinDate,
          'checkout_date': checkoutDate,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Keep-Alive':
                'timeout=5, max=1000', // Thêm tiêu đề Keep-Alive vào yêu cầu
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonString = json.encode(response.data['data']);
        final List<dynamic> responseData = response.data['data'];
        print(jsonString);

        return responseData.map((e) => Hotel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
