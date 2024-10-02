part of app_models;

const String serviceTable = "service";

class ServiceFields {
  static const String pk = "pk";
  static const String name = "name";
  static const String description = "description";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    name,
    description,
    createdAt,
    updatedAt,
  ];
}

class Service {
  int pk;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Service({
    this.pk = 0,
    required this.name,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        pk: json["pk"] as int,
        name: json["name"] as String,
        description: json["description"] as String,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
