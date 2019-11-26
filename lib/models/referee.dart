//import 'package:flutter/material.dart';

class Referee {
  String id;
  String name;
  String lastName;
  String email;
  String phone;
  String userId;

  Referee({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.userId,
  });

  factory Referee.fromJson(Map<String, dynamic> json) {
    return Referee(
      id: json['_id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      userId: json['userId'] != null ? json['userId'] : null,
    );
  }
}
