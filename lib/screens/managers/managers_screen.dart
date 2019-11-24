import 'package:flutter/material.dart';

class ManagersScreen extends StatefulWidget {
  static final routeName = 'managers';

  @override
  _ManagersScreenState createState() => _ManagersScreenState();
}

class _ManagersScreenState extends State<ManagersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Managers'),
      ),
      body: Center(
        child: Text('Managers Screen'),
      ),
    );
  }
}
