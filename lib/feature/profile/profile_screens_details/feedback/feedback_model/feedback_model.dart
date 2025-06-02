class FeedbackModel {
  final bool success;
  final String message;

  FeedbackModel({required this.success, required this.message});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(success: json['success'], message: json['message']);
  }
}
