import 'package:flutter/material.dart';

class Manager {
  String id;
  String name;
  String lastName;
  String email;
  String phone;
  String userId;

  Manager(
      {this.id,
      @required this.name,
      @required this.lastName,
      this.email,
      this.userId,
      this.phone});

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['_id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      userId: json['userid'],
    );
  }
}
