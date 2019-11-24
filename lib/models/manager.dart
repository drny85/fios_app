import 'package:flutter/material.dart';

class Manager {
  String id;
  String name;
  String lastName;
  String email;
  String phone;

  Manager(
      {@required this.id,
      @required this.name,
      @required this.lastName,
      this.email,
      this.phone});

  factory Manager.fromJson(Map<String, dynamic> json) {
    return json['_id']
        ? Manager(
            id: json['_id'],
            name: json['name'],
            lastName: json['last_name'],
            email: json['email'],
            phone: json['phone'],
          )
        : null;
  }
}
