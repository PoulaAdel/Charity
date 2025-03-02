part of app_models;

const String judgementTable = "judgement";

class JudgementFields {
  static const String pk = "pk";
  static const String sponsor = "sponsor";
  static const String statement = "statement";
  static const String content = "content";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    sponsor,
    statement,
    content,
    createdAt,
    updatedAt,
  ];
}

class Judgement {
  int? pk;
  final int statement;
  final int sponsor;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Judgement({
    this.pk = 0,
    required this.sponsor,
    required this.statement,
    required this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory Judgement.fromJson(Map<String, dynamic> json) => Judgement(
        pk: json["id"] as int,
        statement: json["statement"] as int,
        sponsor: json["sponsor"] as int,
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
        "sponsor": sponsor,
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
