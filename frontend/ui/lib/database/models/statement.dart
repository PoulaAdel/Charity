part of app_models;

const String statementTable = "statement";

class StatementFields {
  static const String pk = "pk";
  static const String family = "family";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    family,
    createdAt,
    updatedAt,
  ];
}

class Statement {
  int pk;
  final String family;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Statement({
    this.pk = 0,
    required this.family,
    required this.createdAt,
    this.updatedAt,
  });

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
        pk: json["id"] as int,
        family: json["family"] as String,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "family": family,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
