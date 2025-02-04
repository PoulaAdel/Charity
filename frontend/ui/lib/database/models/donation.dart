part of app_models;

const String donationTable = "donation";

class DonationFields {
  static const String pk = "pk";
  static const String donor = "donor";
  static const String type = "type";
  static const String notes = "notes";
  static const String amount = "amount";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    donor,
    type,
    notes,
    amount,
    createdAt,
    updatedAt,
  ];
}

class Donation {
  int pk;
  final int donor;
  final String? notes;
  final int type;
  final double amount;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Donation({
    this.pk = 0,
    required this.donor,
    this.notes,
    required this.type,
    required this.amount,
    required this.createdAt,
    this.updatedAt,
  });

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        pk: json["id"] as int,
        donor: json["donor"] as int,
        type: json["type"] as int,
        notes: json["notes"] as String,
        amount: json["amount"] as double,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "donor": donor,
        "type": type,
        "notes": notes,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
