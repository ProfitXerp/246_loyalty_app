import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/Login/login_model/login_model.dart';
import 'package:redeem/feature/Login/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userPoints': prefs.getString('user_total_points') ?? '0',
      'userName': prefs.getString('user_name') ?? 'User',
      'userAddress': prefs.getString('user_address') ?? 'Address',
      'userPhone': prefs.getString('user_phone') ?? 'Phone',
      'userEmail': prefs.getString('user_email') ?? 'Email',
      'userRole': prefs.getString('user_role') ?? 'Role',
      'seasonalPoint': prefs.getString('seasonal_point') ?? '0',
      'annualPoints': (prefs.getDouble('user_annual_points') ?? 0)
          .toStringAsFixed(2),
    };
  }

  Future<LoginModel> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse(loginEndpoint!),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'phone_number': phone, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: '_token', value: data['_token']);
      final prefs = await SharedPreferences.getInstance();
      final user = data['user'];

      final seasonalPoints =
          user['seasonal_total_points'] == null
              ? 0.0
              : double.tryParse(user['seasonal_total_points'].toString()) ?? 0;
      final annualPoints =
          user['annual_total_points'] == null
              ? 0.0
              : double.tryParse(user['annual_total_points'].toString()) ?? 0;

      await prefs.setDouble('user_seasonal_points', seasonalPoints);
      await prefs.setDouble('user_annual_points', annualPoints);
      await prefs.setInt('user_id', user['id']);
      await prefs.setString('user_name', user['name'] ?? '');
      await prefs.setString('user_address', user['address'] ?? '');
      await prefs.setString('user_email', user['email'] ?? '');
      await prefs.setString('user_phone', user['phone_number'] ?? '');
      await prefs.setString(
        'user_total_points',
        (seasonalPoints + annualPoints).toStringAsFixed(2),
      );
      await prefs.setString('user_role', user['role'] ?? '');

      return LoginModel.fromJson(user);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(
        error['message'] ?? 'Login failed. Check your credentials.',
      );
    }
  }

  Future<void> handleAuthError(int statusCode, context) async {
    if (statusCode == 401) {
      await _storage.delete(key: '_token');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session expired. Please log in again.')),
      );
      // Delay to allow the SnackBar to show before navigation
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false,
      );
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: '_token');
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.delete(key: '_token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
