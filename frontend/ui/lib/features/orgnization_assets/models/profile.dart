import 'package:flutter/material.dart';

class Profile {
  final ImageProvider photo;
  final String name;
  final String email;

  const Profile({
    required this.photo,
    required this.name,
    required this.email,
  });
}
