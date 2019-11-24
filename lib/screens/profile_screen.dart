import 'package:fios/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static final routeName = 'me';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _logout() async {
    await Provider.of<Auth>(context).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Me'),
      ),
      body: Center(
        child: FlatButton(
          child: Text(
            'Logout',
          ),
          onPressed: _logout,
        ),
      ),
    );
  }
}
