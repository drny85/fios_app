import 'dart:collection';
import 'dart:convert';

import 'package:fios/models/Manager.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Managers extends ChangeNotifier {
  List<Manager> _managers = [];

  UnmodifiableListView<Manager> get managers => UnmodifiableListView(_managers);

  Future<void> getManagers() async {
    try {
      http.Response response =
          await http.get('$kUrl/manager/all', headers: kHeaders);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        List<Manager> loadedManagers = [];
        for (var man in decoded) {
          final manager = Manager.fromJson(man);

          loadedManagers.add(manager);
        }
        _managers = loadedManagers;

        notifyListeners();
      }

      if (response.statusCode >= 400) {
        throw response.body;
      }
    } catch (e) {
      print(e);
    }
  }
}
