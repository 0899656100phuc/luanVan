import 'dart:convert';

import 'package:booking_hotel/model/search_all_data.dart';
import 'package:booking_hotel/screen/detail_hotel.dart';
import 'package:dio/dio.dart';

import '../model/hotel_data.dart';

class DetailHotelService {
  final _dio = Dio();
  Future<DetailDataHotel> fetchSearchData(int id) async {
    try {
      final response = await _dio.get(
        'https://webnmobivinhlong.top/api/hotels/$id',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonString = json.encode(response.data['hotel']);
        print('detail hotel -----');
        print(jsonString);
        return DetailDataHotel.fromJson(json.decode(jsonString));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
