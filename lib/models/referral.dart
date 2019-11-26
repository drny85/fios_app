//import 'package:fios/models/referee.dart';
//import 'package:fios/models/user.dart';
import 'package:fios/models/manager.dart';
import 'package:fios/models/referee.dart';
import 'package:flutter/foundation.dart';

class Referral {
  String id;
  String name;
  String lastName;
  String address;
  String apt;
  String city;
  int zipcode;
  String phone;
  String email;
  String status;
  String comment;
  DateTime moveIn;
  DateTime dueDate;
  DateTime orderDate;
  String package;
  String mon;
  Referee referredBy;
  Manager manager;
  String userId;
  bool emailSent;
  //User updatedBy;
  String updated;
  bool collateralSent;
  DateTime collateralSentOn;

  Referral({
    this.id,
    @required this.name,
    @required this.lastName,
    @required this.address,
    this.apt,
    @required this.city,
    this.zipcode,
    @required this.phone,
    this.email,
    this.emailSent,
    this.userId,
    this.collateralSent,
    this.collateralSentOn,
    this.comment,
    this.dueDate,
    this.manager,
    this.mon,
    @required this.moveIn,
    this.orderDate,
    this.package,
    this.referredBy,
    @required this.status,
    this.updated,
    //this.updatedBy
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['_id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      address: json['address'],
      apt: json['apt'],
      city: json['city'],
      zipcode: json['zipcode'] as int,
      phone: json['phone'],
      package: json['package'],
      moveIn: DateTime.tryParse(json['moveIn']),
      mon: json['mon'],
      collateralSentOn: json['collateral_sent_on'] != null &&
              json['collateral_sent_on'] != 'undefined'
          ? DateTime.tryParse(json['collateral_sent_on'])
          : null,
      collateralSent: json['collateral_sent'],
      status: json['status'],
      comment: json['comment'],
      emailSent: json['email_sent'],
      dueDate: json['due_date'] != null && json['due_date'] != 'undefined'
          ? DateTime.tryParse(json['due_date'])
          : null,
      orderDate: json['order_date'] != null && json['order_date'] != 'undefined'
          ? DateTime.tryParse(json['order_date'])
          : null,
      manager:
          json['manager'] != null ? Manager.fromJson(json['manager']) : null,
      referredBy: json['referralBy'] != null
          ? Referee.fromJson(json['referralBy'])
          : null,
      updated: json['update'],
      userId: json['userId'],
      //updatedBy: User.fromJson(json['updatedBy']),
    );
  }
}
