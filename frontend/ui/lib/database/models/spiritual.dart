part of app_models;

const String spiritualTable = "spiritual";

class SpiritualFields {
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

class Spiritual {
  int pk;
  final int statement;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Spiritual({
    this.pk = 0,
    required this.statement,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });

  factory Spiritual.fromJson(Map<String, dynamic> json) => Spiritual(
        pk: json["pk"] as int,
        statement: json["statement"] as int,
        content: json["content"] as String,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "statement": statement,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
