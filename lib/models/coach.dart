import 'package:flutter/material.dart';

class Coach {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String phone;

  Coach({
    @required this.id,
    this.name,
    this.lastName,
    this.email,
    this.phone,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['_id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
