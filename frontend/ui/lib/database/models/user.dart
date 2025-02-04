part of app_models;

const String userTable = "user";

class UserFields {
  static const String pk = "pk";
  static const String username = "username";
  static const String email = "email";
  static const String phone = "phone";
  static const String password = "password";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    username,
    email,
    phone,
    password,
    createdAt,
    updatedAt,
  ];
}

class User {
  int pk;
  final String username;
  final String phone;
  final String? email;
  final String password;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    this.pk = 0,
    required this.username,
    required this.phone,
    this.email,
    required this.password,
    required this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["id"] as int,
        username: json["username"] as String,
        email: json["email"],
        phone: json["phone"] as String,
        password: json["password"] as String,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
