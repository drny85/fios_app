import 'package:flutter/material.dart';

class User {
  String id;
  String name;

  String email;
  String phone;
  Roles roles;

  User({
    @required this.id,
    this.name,
    this.email,
    this.phone,
    this.roles,
  });

  factory User.fromJson(Map<String, Object> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        roles: Roles.fromJson(json['roles']));
  }
}

class Roles {
  bool isAdmin;
  bool active;
  bool coach;

  Roles({this.active, this.coach, this.isAdmin});

  factory Roles.fromJson(Map<String, bool> json) {
    return Roles(
      active: json['active'],
      isAdmin: json['isAdmin'],
      coach: json['coach'],
    );
  }
}
