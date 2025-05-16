class LoginModel {
  final int id;
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final String totalPoints;
  final String role;

  LoginModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.totalPoints,
    required this.role,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      totalPoints: json['total_points'],
      role: json['role'],
    );
  }
}
