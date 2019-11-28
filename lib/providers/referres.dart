import 'dart:collection';
import 'dart:convert';

import 'package:fios/models/referee.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Referees extends ChangeNotifier {
  List<Referee> _referees = [];

  UnmodifiableListView<Referee> get referees => UnmodifiableListView(_referees);

  List<Referee> get sortedReferees {
    return _referees
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  Future<void> getReferees() async {
    try {
      http.Response response =
          await http.get('$kUrl/referee/all', headers: kHeaders);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        List<Referee> loadedReferees = [];
        for (var ref in decoded) {
          final referee = Referee.fromJson(ref);
          loadedReferees.add(referee);
        }
        _referees = loadedReferees;

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
