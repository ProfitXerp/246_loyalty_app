class Redeem {
  final int id;
  final String points;
  final Scheme scheme;
  final List<Item> items;

  Redeem({
    required this.id,
    required this.points,
    required this.scheme,
    required this.items,
  });

  factory Redeem.fromJson(Map<String, dynamic> json) {
    return Redeem(
      id: json['id'],
      points: json['points'],
      scheme: Scheme.fromJson(json['scheme']),
      items:
          (json['item'] as List)
              .map((itemJson) => Item.fromJson(itemJson))
              .toList(),
    );
  }
}

class Scheme {
  final int id;
  final String name;
  final String start;
  final String? deadline;
  final String status;

  Scheme({
    required this.id,
    required this.name,
    required this.start,
    this.deadline,
    required this.status,
  });

  factory Scheme.fromJson(Map<String, dynamic> json) {
    return Scheme(
      id: json['id'],
      name: json['name'],
      start: json['start'],
      deadline: json['deadline'],
      status: json['status'],
    );
  }
}

class Item {
  final int id;
  final String item;
  final String description;
  final String image;
  final String status;

  Item({
    required this.id,
    required this.item,
    required this.description,
    required this.image,
    required this.status,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      item: json['item'],
      description: json['description'],
      image: json['image'],
      status: json['status'],
    );
  }
}
