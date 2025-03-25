part of app_models;

const String supplyTable = "supply";

class SupplyFields {
  static const String pk = "pk";
  static const String family = "family";
  static const String service = "service";
  static const String amount = "amount";
  static const String note = "note";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    family,
    service,
    amount,
    note,
    createdAt,
    updatedAt,
  ];
}

class Supply {
  int? pk;
  final int family;
  final int service;
  final double amount;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Supply({
    this.pk = 0,
    required this.family,
    required this.service,
    required this.amount,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory Supply.fromJson(Map<String, dynamic> json) => Supply(
        pk: json["id"] as int,
        family: json["family"] as int,
        service: json["service"] as int,
        amount: json["amount"] as double,
        note: json["note"] as String?,
        createdAt: (json['created_at'] != null)
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": pk,
        "family": family,
        "service": service,
        "amount": amount,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
