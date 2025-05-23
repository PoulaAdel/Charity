part of app_models;

const String economicalTable = "economical";

class EconomicalFields {
  static const String pk = "pk";
  static const String statement = "statement";
  static const String content = "content";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    statement,
    content,
    createdAt,
    updatedAt,
  ];
}

class Economical {
  int? pk;
  final int statement;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Economical({
    this.pk = 0,
    required this.statement,
    required this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory Economical.fromJson(Map<String, dynamic> json) => Economical(
        pk: json["id"] as int,
        statement: json["statement"] as int,
        content: json["content"] as String,
        createdAt: (json['created_at'] != null)
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": pk,
        "statement": statement,
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
