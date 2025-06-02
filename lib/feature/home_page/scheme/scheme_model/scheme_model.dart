class Scheme {
  final int id;
  final String name;
  final String start;
  final String deadline;
  final String status;
  final String type;
  final int fiscalId;
  final String createdAt;
  final String updatedAt;
  final int totalPoints;
  final Rule? rule;

  Scheme({
    required this.id,
    required this.name,
    required this.start,
    required this.deadline,
    required this.status,
    required this.type,
    required this.fiscalId,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPoints,
    this.rule,
  });

  factory Scheme.fromJson(Map<String, dynamic> json) {
    int parsedPoints = 0;
    if (json['total_points'] is String) {
      parsedPoints = int.tryParse(json['total_points'].split('.').first) ?? 0;
    } else if (json['total_points'] is num) {
      parsedPoints = (json['total_points'] as num).toInt();
    }

    return Scheme(
      id: json['id'],
      name: json['name'],
      start: json['start'],
      deadline: json['deadline'],
      status: json['status'],
      type: json['type'],
      fiscalId: json['fiscal_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      totalPoints: parsedPoints,
      rule: json['rule'] != null ? Rule.fromJson(json['rule']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start': start,
      'deadline': deadline,
      'status': status,
      'type': type,
      'fiscal_id': fiscalId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'total_points': totalPoints,
      'rule': rule?.toJson(),
    };
  }
}

class Rule {
  final int id;
  final int schemeId;
  final int subUserId; // changed from userId to subUserId
  final String? credit;
  final String limit;
  final String status;
  final String createdAt;
  final String updatedAt;

  Rule({
    required this.id,
    required this.schemeId,
    required this.subUserId,
    this.credit,
    required this.limit,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      id: json['id'],
      schemeId: json['scheme_id'],
      subUserId: json['sub_user_id'], // changed here
      credit: json['credit'],
      limit: json['limit'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheme_id': schemeId,
      'sub_user_id': subUserId, // changed here
      'credit': credit,
      'limit': limit,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
