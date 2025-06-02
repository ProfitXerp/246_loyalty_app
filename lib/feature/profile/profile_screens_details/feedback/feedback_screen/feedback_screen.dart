import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/feature/profile/profile_screens_details/feedback/feedback_service/feedback_service.dart';
import 'package:redeem/widgets/mytext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FeedbackService _feedbackService = FeedbackService();
  bool _isSubmitting = false;
  bool _isInputNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _isInputNotEmpty = _messageController.text.trim().isNotEmpty;
      });
    });
  }

  Future<void> _submitFeedback() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isSubmitting = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id') ?? 0;

      final response = await _feedbackService.sendFeedback(
        userId: userId,
        message: _messageController.text.trim(),
      );

      _messageController
          .clear(); // This will also trigger listener to update state

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send feedback.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Mytext(
              text: 'We would love your feedback!',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Share your thoughts, suggestions.',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            _isSubmitting
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _isInputNotEmpty ? _submitFeedback : null,
                  child: const Text('Submit Feedback'),
                ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
