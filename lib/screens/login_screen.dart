import 'dart:io';

import 'package:fios/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  Future<void> _login() async {
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_email.trim().toLowerCase(), _password.trim());
    } catch (e) {
      final error = json.decode(e) as Map<String, dynamic>;

      final message = error['msg'];
      _showErrorMessage(msg: message);
    }
  }

  void _showErrorMessage({String msg}) {
    showDialog(
        context: context,
        builder: (context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Text('Error'),
                  content: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(msg),
                  ),
                  actions: <Widget>[
                    CupertinoButton(
                      child: Text(
                        'OK',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              : AlertDialog(
                  title: Text('Error'),
                  content: Text(msg),
                  elevation: 10.0,
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Container(
                height: 200.0,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 24.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 600,
                width: width,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _password = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      FlatButton(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                          onPressed: _login),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
