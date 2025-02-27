part of app_models;

const String userTable = "user";

class UserFields {
  static const String pk = "pk";
  static const String username = "username";
  static const String email = "email";
  static const String phone = "phone";
  static const String password = "password";
  static const String role = "role";
  static const String profileImage = "profile_image";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    username,
    email,
    phone,
    password,
    role,
    profileImage,
    createdAt,
    updatedAt,
  ];
}

class User {
  int pk;
  final String username;
  final String? phone;
  final String? email;
  final String password;
  final int role;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.pk = 0,
    required this.username,
    this.phone,
    this.email,
    required this.password,
    required this.role,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["id"] as int,
        username: json["username"] as String,
        email: json["email"] as String?,
        phone: json["phone"] as String?,
        password: json["password"] as String,
        role: json["role"] as int,
        profileImage: json["profile_image"] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
        "role": role,
        "profile_image": profileImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
