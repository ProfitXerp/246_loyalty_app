class LogModel {
  final int id;
  final int subUserId;
  final int schemeId;
  final String pointCategory;
  final String pointStatus;
  final bool addedToAnnual; // converted to bool
  final String logType;
  final String? billNo; // nullable
  final String voucherSeries;
  final String amount;
  final String points;
  final String createdAt;
  final String updatedAt;
  final SubUser subuser;
  final LogScheme scheme;

  LogModel({
    required this.id,
    required this.subUserId,
    required this.schemeId,
    required this.pointCategory,
    required this.pointStatus,
    required this.addedToAnnual,
    required this.logType,
    required this.billNo,
    required this.voucherSeries,
    required this.amount,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.subuser,
    required this.scheme,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'],
      subUserId: json['sub_user_id'],
      schemeId: json['scheme_id'],
      pointCategory: json['point_category'],
      pointStatus: json['point_status'],
      addedToAnnual: json['added_to_annual'] == 'true',
      logType: json['log_type'],
      billNo: json['bill_no'], // can be null
      voucherSeries: json['voucher_series'],
      amount: json['amount'],
      points: json['points'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      subuser: SubUser.fromJson(json['subuser']),
      scheme: LogScheme.fromJson(json['scheme']),
    );
  }
}

class SubUser {
  final int id;
  final int userId;
  final String name;
  final String slug;
  final String createdAt;
  final String updatedAt;

  SubUser({
    required this.id,
    required this.userId,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubUser.fromJson(Map<String, dynamic> json) {
    return SubUser(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class LogScheme {
  final int id;
  final String name;
  final String start;
  final String deadline;
  final String status;
  final String type;
  final int fiscalId;
  final String createdAt;
  final String updatedAt;

  LogScheme({
    required this.id,
    required this.name,
    required this.start,
    required this.deadline,
    required this.status,
    required this.type,
    required this.fiscalId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LogScheme.fromJson(Map<String, dynamic> json) {
    return LogScheme(
      id: json['id'],
      name: json['name'],
      start: json['start'],
      deadline: json['deadline'],
      status: json['status'],
      type: json['type'],
      fiscalId: json['fiscal_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class LogResponse {
  final List<LogModel> userPointLogs;
  final String fiscalYear;

  LogResponse({required this.userPointLogs, required this.fiscalYear});

  factory LogResponse.fromJson(Map<String, dynamic> json) {
    var logs =
        (json['userPointLogs'] as List)
            .map((log) => LogModel.fromJson(log))
            .toList();

    return LogResponse(userPointLogs: logs, fiscalYear: json['fiscalyear']);
  }
}
