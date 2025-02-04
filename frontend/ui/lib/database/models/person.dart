part of app_models;

const String personTable = "person";

class PersonFields {
  static const String pk = "pk";
  static const String name = "name";
  static const String family = "family";
  static const String relation = "relation";
  static const String contact = "contact";
  static const String nid = "nid";
  static const String img = "face_img";
  static const String age = "age";
  static const String education = "education";
  static const String income = "income";
  static const String health = "health";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    name,
    family,
    relation,
    contact,
    nid,
    img,
    age,
    education,
    income,
    health,
    createdAt,
    updatedAt,
  ];
}

class Person {
  int pk;
  final String name;
  final int family;
  final int relation;
  final String? contact;
  final String nid;
  final String? img;
  final int age;
  final String? education;
  final double? income;
  final String? health;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Person({
    this.pk = 0,
    required this.name,
    required this.family,
    required this.relation,
    this.contact,
    required this.nid,
    this.img,
    required this.age,
    this.education,
    this.health,
    this.income,
    required this.createdAt,
    this.updatedAt,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        pk: json["id"] as int,
        name: json["name"] as String,
        family: json["family"] as int,
        relation: json["relation"] as int,
        contact: json["contact"] as String,
        nid: json["nid"] as String,
        img: json["img"] as String,
        age: json["age"] as int,
        education: json["education"] as String,
        health: json["health"] as String,
        income: json["income"] as double,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "name": name,
        "family": family,
        "relation": relation,
        "contact": contact,
        "nid": nid,
        "img": img,
        "age": age,
        "education": education,
        "health": health,
        "income": income,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
