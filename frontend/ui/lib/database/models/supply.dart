part of app_models;

const String supplyTable = "supply";

class SupplyFields {
  static const String pk = "pk";
  static const String family = "family";
  static const String service = "service";
  static const String amount = "amount";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    family,
    service,
    amount,
    createdAt,
    updatedAt,
  ];
}

class Supply {
  int pk;
  final int family;
  final int service;
  final double amount;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Supply({
    this.pk = 0,
    required this.family,
    required this.service,
    required this.amount,
    required this.createdAt,
    this.updatedAt,
  });

  factory Supply.fromJson(Map<String, dynamic> json) => Supply(
        pk: json["pk"] as int,
        family: json["family"] as int,
        service: json["service"] as int,
        amount: json["amount"] as double,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "family": family,
        "service": service,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
