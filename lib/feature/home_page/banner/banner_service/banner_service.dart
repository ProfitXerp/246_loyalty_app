import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/feature/Login/service/auth_service.dart';
import 'package:redeem/feature/home_page/banner/banner_model/banner_model.dart';

class BannerService {
  final _storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();

  Future<List<BannerModel>> fetchBannerData(BuildContext context) async {
    final token = await _storage.read(key: '_token');

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.get(
        Uri.parse('https://246.techfinancenepal.com/api/banners'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> bannerdata = data['banners'];
        return bannerdata.map((json) => BannerModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        await _authService.handleAuthError(401, context);
        throw Exception('Session expired. Please log in again.');
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching banners: $e');
      throw Exception('Failed to load banners: $e');
    }
  }
}
