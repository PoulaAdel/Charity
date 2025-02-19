part of app_models;

const String memberTable = "member";

class MemberFields {
  static const String pk = "pk";
  static const String name = "name";
  static const String family = "family";
  static const String relation = "relation";
  static const String contact = "contact";
  static const String nid = "nid";
  static const String faceImg = "face_img";
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
    faceImg,
    age,
    education,
    income,
    health,
    createdAt,
    updatedAt,
  ];
}

class Member {
  final int? pk;
  final String name;
  final int family;
  final int relation;
  final String? contact;
  final File nid;
  final NetworkImage? faceImg;
  final int age;
  final String? education;
  final double income;
  final String? health;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Member({
    this.pk,
    required this.name,
    required this.family,
    required this.relation,
    this.contact,
    required this.nid,
    this.faceImg,
    required this.age,
    this.education,
    this.health,
    required this.income,
    this.createdAt,
    this.updatedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        pk: json["id"] as int?,
        name: json["name"] as String,
        family: json["family"] as int,
        relation: json["relation"] as int,
        contact: json["contact"] as String? ?? '',
        nid: json["nid"] as File,
        faceImg: (json['face_img'] != null)
            ? NetworkImage('${json['face_img']}')
            : const NetworkImage(ImageRasterPath.avatar2),
        age: json["age"] as int,
        education: json["education"] as String? ?? '',
        health: json["health"] as String? ?? '',
        income: json["income"] as double? ?? 0.0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": pk,
        "name": name,
        "family": family,
        "relation": relation,
        "contact": contact,
        "nid": nid,
        "face_img": faceImg,
        "age": age,
        "education": education,
        "health": health,
        "income": income.toString(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
