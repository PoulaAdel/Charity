part of app_models;

const String familyTable = "family";

class FamilyFields {
  static const String pk = "pk";
  static const String name = "name";
  static const String count = "count";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    name,
    count,
    createdAt,
    updatedAt,
  ];
}

class Family {
  int pk;
  final String name;
  final int count;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Family({
    this.pk = 0,
    required this.name,
    required this.count,
    required this.createdAt,
    this.updatedAt,
  });

  factory Family.fromJson(Map<String, dynamic> json) => Family(
        pk: json["pk"] as int,
        name: json["name"] as String,
        count: json["count"] as int,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "name": name,
        "count": count,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
