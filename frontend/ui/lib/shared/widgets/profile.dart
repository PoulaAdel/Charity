import 'package:charity/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class Profile {
  final int id;
  final ImageProvider? photo;
  final String username;
  final String email;
  final int role;

  const Profile({
    required this.id,
    this.photo,
    required this.username,
    required this.email,
    required this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      photo: (json['photo'] != null)
          ? NetworkImage('${json['photo']}')
          : const NetworkImage(ImageRasterPath.avatar2),
      username: json['username'],
      email: json['email'] ?? '',
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo.toString(),
      'username': username,
      'email': email,
      'role': role,
    };
  }
}
