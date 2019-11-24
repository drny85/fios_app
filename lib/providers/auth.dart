import 'package:fios/models/user.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String _token = '';
  User _user;

  String get token {
    return _token;
  }

  User get user {
    return _user;
  }

  bool get isAuth {
    if (token == null || token == '') {
      return false;
    }

    return true;
  }

  Future<bool> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('user_data')) {
      return false;
    }
    final userData =
        json.decode(prefs.getString('user_data')) as Map<String, Object>;
    _token = userData['token'];

    notifyListeners();
    print('Auto Login');
    return true;
  }

  Future<void> login(String email, String password) async {
    try {
      final body = json.encode({'email': email, 'password': password});
      print(body);
      http.Response response =
          await http.post('$kUrl/user/login', body: body, headers: kHeaders);
      if (response.statusCode == 200) {
        final userData = json.decode(response.body) as Map<String, dynamic>;
        final token = userData['token'];

        final user = userData['user'];

        _token = token;

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(
            'user_data', json.encode({'token': token, 'user': user}));

        notifyListeners();
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('user_data');
    //await prefs.clear();
    _token = '';
    _user = null;

    print('loging out');
    print(_token);
    notifyListeners();
  }
}
