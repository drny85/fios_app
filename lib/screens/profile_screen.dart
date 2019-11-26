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
    final user = Provider.of<Auth>(context).user;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            height: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                image: DecorationImage(
                    image: NetworkImage(user.image), fit: BoxFit.cover)),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.8),
                    ], begin: Alignment.center, end: Alignment.bottomCenter),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            user.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            user.lastName.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        user.phone,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Row(
                  children: <Widget>[
                    Text(
                      'Coach: ${user.coach.name.toUpperCase()}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${user.coach.lastName.toUpperCase()}',
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text(
                  'Company: ${user.vendor.toUpperCase()}',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('${user.email}'),
              ),
              ListTile(
                leading: user.roles.active
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.clear,
                        color: Theme.of(context).primaryColor,
                      ),
                title: Text(
                    user.roles.active ? ' Status: Active' : 'Status: Pending'),
              ),
            ],
          )),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
              width: width / 2,
              child: RaisedButton(
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                elevation: 12.0,
                color: Theme.of(context).primaryColor,
                onPressed: _logout,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
