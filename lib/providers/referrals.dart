import 'dart:collection';
import 'package:fios/models/referral.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Referrals extends ChangeNotifier {
  List<Referral> _referrals = [];
  List<Referral> _refsCopy = [];
  List<Referral> _todaySales = [];
  Referral _referral;

  UnmodifiableListView<Referral> get referrals =>
      UnmodifiableListView(_referrals);

  List<Referral> get todaySales => [..._todaySales];

  Referral get referral => _referral;

  Future<void> getReferrals() async {
    try {
      http.Response response =
          await http.get('$kUrl/referrals', headers: kHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Referral> loadedReferrals = [];
        data.forEach((ref) {
          final referral = Referral.fromJson(ref);
          loadedReferrals.add(referral);
        });
        _refsCopy = loadedReferrals;
        _referrals = loadedReferrals;

        notifyListeners();

        // } else {
        //   //check for error
        //   if (response.statusCode >= 400) {
        //     //print(response.body);
        //     throw response.body;
        //   }
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  List<Referral> refs = [];

  void searchReferral(String value) {
    if (value.isEmpty) {
      _referrals = _refsCopy;
    }
    _referrals = _referrals.where((ref) {
      return ref.name.toLowerCase().contains(value.toLowerCase())
          ? ref.name.toLowerCase().contains(value.toLowerCase())
          : ref.address.toLowerCase().contains(value.toLowerCase())
              ? ref.address.toLowerCase().contains(value.toLowerCase())
              : ref.apt.toLowerCase().contains(value.toLowerCase())
                  ? ref.apt.toLowerCase().contains(value.toLowerCase())
                  : ref.lastName.toLowerCase().contains(value.toLowerCase());
    }).toList();

    notifyListeners();
  }

  Future<List<Referral>> getTodaySales() async {
    //List<Referral> temp = [];
    referrals.forEach((ref) {
      if (ref.orderDate.isBefore(DateTime.now()) &&
          ref.orderDate.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
        print(ref.name);
      }
    });

    //notifyListeners();
    return todaySales;
  }

  Future<bool> sendEmail({String referralId, String email}) async {
    try {
      bool success;
      final body = json.encode({'id': referralId, 'email': email});
      http.Response response = await http.post('$kUrl/email/collateral',
          headers: kHeaders, body: body);

      if (response.statusCode == 200) {
        success = true;
        final refIndex = _referrals.indexWhere((ref) => ref.id == referralId);
        if (refIndex >= 0) {
          _referrals[refIndex].collateralSent = true;
          _referrals[refIndex].collateralSentOn = DateTime.now();
          notifyListeners();
        }
      }
      if (response.statusCode >= 400) {
        success = false;
        throw response.body;
      }
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getReferralById(String id) async {
    try {
      http.Response response =
          await http.get('$kUrl/detail/$id', headers: kHeaders);

      if (response.statusCode == 200) {
        final ref = json.decode(response.body);
        final referral = Referral.fromJson(ref);
        print(referral);
        _referral = referral;
        notifyListeners();
      }

      if (response.statusCode >= 400) {
        throw response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deleteReferral(String id) async {
    try {
      http.Response response =
          await http.delete('$kUrl/referral/delete/$id', headers: kHeaders);
      bool success;
      if (response.statusCode == 200) {
        success = true;
      }
      if (response.statusCode >= 400) {
        success = false;
        throw response.body;
      }
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
