import 'package:flutter/material.dart';

class Coach {
  String id;
  String name;
  String lastName;
  String email;
  String phone;
  bool profileCompleted;
  String title;
  String vendor;
  Roles roles;
  String image;

  Coach({
    @required this.id,
    this.name,
    this.email,
    this.phone,
    this.roles,
    this.lastName,
    this.profileCompleted,
    this.title = '',
    this.vendor = '',
  });

  factory Coach.fromJson(Map<String, Object> json) {
    return Coach(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      roles: Roles.fromJson(
        json['roles'],
      ),
      lastName: json['last_name'],
      vendor: json['vendor'],
      title: json['title'],
    );
  }

  @override
  String toString() {
    return super.toString();
  }
}

class Roles {
  bool isAdmin;
  bool active;
  bool coach;

  Roles({this.active, this.coach, this.isAdmin});

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
      active: json['active'],
      isAdmin: json['isAdmin'],
      coach: json['coach'],
    );
  }
}
