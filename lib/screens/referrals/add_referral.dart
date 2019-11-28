import 'package:fios/models/referee.dart';
import 'package:fios/models/referral.dart';
import 'package:fios/providers/managers.dart';
import 'package:fios/providers/referrals.dart';
import 'package:fios/providers/referres.dart';
import 'package:fios/screens/home_screen.dart';
import 'package:fios/widgets/bottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/manager.dart';

class AddReferralScreen extends StatefulWidget {
  static final routeName = 'add_referral';
  @override
  _AddReferralScreenState createState() => _AddReferralScreenState();
}

class _AddReferralScreenState extends State<AddReferralScreen> {
  String name = '';
  String lastName = '';
  String address = '';
  String apt = '';
  int zipcode;
  DateTime moveIn;
  String status = 'new';
  String email = '';
  String city;
  String manager = '';
  String referralBy = '5c46615c8d0a3a48a081900a';
  String comment = '';
  String phone = '';

  String dropdownValue = 'One';

  DateTime _initialDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveReferral() async {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      final referral = Referral(
          name: name,
          lastName: lastName,
          email: email,
          referredBy: Referee(id: referralBy),
          moveIn: moveIn,
          address: address,
          apt: apt,
          zipcode: zipcode,
          city: city,
          status: status,
          phone: phone,
          comment: comment);

      final bool success = await Provider.of<Referrals>(context, listen: false)
          .addReferral(referral);
      if (success) {
        print("ADDED");
        _formKey.currentState.reset();
        //send it home screen
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName, (Route<dynamic> route) => false);
      } else {
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((onValue) {
      _getReferees();
    });
  }

  Future<void> _getReferees() async {
    await Provider.of<Referees>(context, listen: false).getReferees();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_getReferees();
  }

  @override
  Widget build(BuildContext context) {
    final managers = Provider.of<Managers>(context).managers;
    return Scaffold(
        appBar: AppBar(
          title: Text("Adding Referral"),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) => name = value,
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      validator: (String value) {
                        if (value.trim().length < 2) {
                          return 'name must be at least 2 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      onSaved: (value) => lastName = value,
                      textCapitalization: TextCapitalization.words,
                      validator: (String value) {
                        if (value.trim().length < 2) {
                          return 'Last name must be at least 2 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),

                    //address field
                    TextFormField(
                      onSaved: (value) => address = value,
                      textCapitalization: TextCapitalization.words,
                      validator: (String value) {
                        if (value.trim().length < 5) {
                          return 'Address must be at least 5 character long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Address',
                      ),
                    ),
                    //APT field
                    TextFormField(
                      onSaved: (value) => apt = value,
                      decoration: InputDecoration(
                        labelText: 'Apt, Unit, Suite',
                      ),
                    ),
                    //CITY field
                    TextFormField(
                      onSaved: (value) => city = value,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a city';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                    //ZIPCODE field
                    TextFormField(
                      onSaved: (value) => zipcode = int.parse(value),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a zipcode';
                        }

                        if (value.length < 5) {
                          return 'Zip code must be at least 5 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Zip code',
                      ),
                    ),
                    //PHONE field
                    TextFormField(
                      onSaved: (value) => phone = value,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a phone';
                        }

                        if (value.length < 10) {
                          return 'Phone must be at least 10 numbers';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone',
                      ),
                    ),
                    //EMAIL field
                    TextFormField(
                      onSaved: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!value.trim().contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Moving Date: '),
                            FlatButton(
                                child: Text(moveIn == null
                                    ? 'Pick a date'
                                    : DateFormat.yMMMEd().format(moveIn)),
                                onPressed: () {
                                  print('pressed');

                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return BottomSheetWidget(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text('Select a Moving Date'),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: CupertinoDatePicker(
                                                  initialDateTime: _initialDate,
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  onDateTimeChanged: (newDate) {
                                                    setState(() {
                                                      moveIn = newDate;
                                                      _initialDate = moveIn;
                                                    });
                                                  },
                                                ),
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  'OK',
                                                  style:
                                                      TextStyle(fontSize: 20.0),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text('Account Manager:'),
                  FlatButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BottomSheetWidget(
                                child: CupertinoPicker(
                              itemExtent: 30,
                              diameterRatio: 1.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  manager = managers[index].id;
                                });
                              },
                              children: <Widget>[
                                for (var manager in managers)
                                  Text(
                                    '${manager.name} ${manager.lastName}'
                                        .toUpperCase(),
                                    style: TextStyle(fontSize: 18.0),
                                  )
                              ],
                            ));
                          });
                    },
                    child: Text('Select an AM'),
                  ),
                ],
              ),
              Container(
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _saveReferral,
                ),
              ),
            ],
          ),
        ));
  }
}
