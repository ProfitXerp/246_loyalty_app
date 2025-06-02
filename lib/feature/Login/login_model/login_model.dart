class LoginModel {
  final int id;
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final double seasonalPoints;
  final double annualPoints;
  final double totalPoints;
  final String role;

  LoginModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.seasonalPoints,
    required this.annualPoints,
    required this.totalPoints,
    required this.role,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final seasonalRaw = json['seasonal_total_points'];
    final annualRaw = json['annual_total_points'];

    final seasonal =
        seasonalRaw == null
            ? 0.0
            : double.tryParse(seasonalRaw.toString()) ?? 0;
    final annual =
        annualRaw == null ? 0.0 : double.tryParse(annualRaw.toString()) ?? 0;

    return LoginModel(
      id: json['id'],
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      seasonalPoints: seasonal,
      annualPoints: annual,
      totalPoints: seasonal + annual,
      role: json['role'] ?? '',
    );
  }
}
