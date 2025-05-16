import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/home_page/banner/banner_model/banner_model.dart';

class BannerService {
  final _storage = FlutterSecureStorage();
  Future<List<BannerModel>> fetchBannerData() async {
    final token = await _storage.read(key: '_token');
    try {
      final response = await http.get(
        Uri.parse('$bannerEndPoint'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print(data);
        List<dynamic> bannerdata = data['banners'];
        return bannerdata.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        throw Exception('failed to load banner');
      }
    } catch (e) {
      print(e);
      throw Exception('failed to load data $e');
    }
  }
}
