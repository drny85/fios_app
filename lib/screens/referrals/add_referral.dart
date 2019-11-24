import 'package:flutter/material.dart';

class AddReferralScreen extends StatefulWidget {
  static final routeName = 'add_referral';
  @override
  _AddReferralScreenState createState() => _AddReferralScreenState();
}

class _AddReferralScreenState extends State<AddReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding Referral"),
      ),
      body: Center(
        child: Text('Add REferral'),
      ),
    );
  }
}
