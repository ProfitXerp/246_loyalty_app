import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/redeem/redeemModel/redeem_model.dart';

class RedeemService {
  final _storage = const FlutterSecureStorage();

  Future<List<RedeemModel>> fetchRedemptionData() async {
    final token = await _storage.read(key: '_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$redeemListEndpoint'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return decoded.map((json) => RedeemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }
}
