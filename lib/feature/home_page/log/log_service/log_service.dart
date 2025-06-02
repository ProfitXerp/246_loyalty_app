import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/home_page/log/log_model/log_model.dart';

class LogService {
  final _storage = const FlutterSecureStorage();

  Future<List<LogModel>> fetchLogs() async {
    final token = await _storage.read(key: '_token');

    try {
      final response = await http.get(
        Uri.parse('$logEndPoint'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> logsData = data['userPointLogs'];
        final logs = logsData.map((json) => LogModel.fromJson(json)).toList();
        print('Fetched Log data : $logs');
        return logs;
      } else {
        throw Exception('Failed to load logs');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load data $e');
    }
  }
}
