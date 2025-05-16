import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/Login/login_model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userPoints': prefs.getString('user_total_points') ?? '0',
      'userName': prefs.getString('user_name') ?? 'User',
      'userAddress': prefs.getString('user_address') ?? 'Address',
      'userPhone': prefs.getString('user_phone') ?? 'Phone',
    };
  }

  final _storage = const FlutterSecureStorage();
  final String url = '$loginEndpoint';

  Future<LoginModel> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
      body: {'phone_number': phone, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save token in FlutterSecureStorage
      await _storage.write(key: '_token', value: data['_token']);

      final prefs = await SharedPreferences.getInstance();

      // Save user data in SharedPreferences
      await prefs.setInt('user_id', data['user']['id']);
      await prefs.setString('user_name', data['user']['name']);
      await prefs.setString('user_address', data['user']['address']);
      await prefs.setString('user_email', data['user']['email']);
      await prefs.setString('user_phone', data['user']['phone_number']);
      await prefs.setString('user_total_points', data['user']['total_points']);
      await prefs.setString('user_role', data['user']['role']);
      return LoginModel.fromJson(data['user']);
    } else {
      throw Exception('Login failed. Check your credentials.');
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: '_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: '_token'); // Check if token exists
    return token != null && token.isNotEmpty; // Return true if token exists
  }

  Future<void> logout() async {
    await _storage.delete(key: '_token');
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
