part of app_models;

const String donorTable = "donor";

class DonorFields {
  static const String pk = "pk";
  static const String name = "name";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    name,
    createdAt,
    updatedAt,
  ];
}

class Donor {
  int pk;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Donor({
    this.pk = 0,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        pk: json["id"] as int,
        name: json["name"] as String,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
