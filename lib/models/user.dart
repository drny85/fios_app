import 'package:fios/models/coach.dart';
import 'package:flutter/material.dart';

class User {
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
  Coach coach;

  User({
    @required this.id,
    this.name,
    this.email,
    this.phone,
    this.roles,
    this.lastName,
    this.profileCompleted,
    this.title = '',
    this.vendor = '',
    this.image = '',
    this.coach,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      image: json['image'],
      profileCompleted: json['profileCompleted'],
      coach: Coach.fromJson(json['coach']),
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
