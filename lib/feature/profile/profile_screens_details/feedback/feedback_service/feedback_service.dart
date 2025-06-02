import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/profile/profile_screens_details/feedback/feedback_model/feedback_model.dart';

class FeedbackService {
  final _storage = FlutterSecureStorage();

  Future<FeedbackModel> sendFeedback({
    required int userId,
    required String message,
  }) async {
    final token = await _storage.read(key: '_token');
    try {
      final response = await http.post(
        Uri.parse(feedbackEndPoint!),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"user_id": userId, "message": message}),
      );
      print(
        'Posted data: ${jsonEncode({"user_id": userId, "message": message})}',
      );
      print('Feedback response: ${response.body}');
      print('Feedback response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return FeedbackModel.fromJson(data);
      } else {
        throw Exception('Failed to send feedback');
      }
    } catch (e) {
      print('Feedback error: $e');
      throw Exception('Failed to send feedback: $e');
    }
  }
}
