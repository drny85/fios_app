import 'package:fios/models/referral.dart';
import 'package:fios/screens/referrals/referral_details.dart';
import 'package:flutter/material.dart';

class EditReferralScreen extends StatefulWidget {
  static final routeName = 'edit_referral';
  final Referral referral;
  EditReferralScreen(this.referral);
  @override
  _EditReferralScreenState createState() => _EditReferralScreenState();
}

class _EditReferralScreenState extends State<EditReferralScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24.0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReferralDetail(widget.referral)));
              },
            ),
            trailing: Icon(Icons.save),
            title: Text('Edit'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              animationDuration: Duration(milliseconds: 600),
              elevation: 12.0,
              child: Form(
                autovalidate: true,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return '';
                      },
                      onChanged: (String value) =>
                          setState(() => widget.referral.name = value),
                      initialValue: widget.referral.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
