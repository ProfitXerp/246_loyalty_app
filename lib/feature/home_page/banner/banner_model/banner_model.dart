class BannerModel {
  final int id;
  final String image;
  final String description;

  BannerModel({
    required this.id,
    required this.image,
    required this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
      description: json['description'],
    );
  }
}
