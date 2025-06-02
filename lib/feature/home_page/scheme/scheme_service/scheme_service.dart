import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/home_page/scheme/scheme_model/scheme_model.dart';

class SchemeService {
  final _storage = const FlutterSecureStorage();

  Future<List<Scheme>> fetchSchemes() async {
    final token = await _storage.read(key: '_token');
    try {
      final response = await http.get(
        Uri.parse(schemeEndPoint!),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> schemesJson = data['schemes'];
        return schemesJson.map((json) => Scheme.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load schemes');
      }
    } catch (e) {
      debugPrint('Error fetching schemes: $e');
      throw Exception('Failed to load schemes');
    }
  }
}
