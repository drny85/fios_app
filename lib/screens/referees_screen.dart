import 'package:flutter/material.dart';

class RefereesScreen extends StatefulWidget {
  static final routeName = 'referee';
  @override
  _RefereesScreenState createState() => _RefereesScreenState();
}

class _RefereesScreenState extends State<RefereesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referees'),
      ),
      body: Center(
        child: Text('Referees Screen'),
      ),
    );
  }
}
