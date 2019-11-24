import 'package:fios/models/referral.dart';
import 'package:fios/providers/referrals.dart';
import 'package:fios/screens/home_screen.dart';
import 'package:fios/screens/referrals/edit_referral.dart';

import 'package:fios/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReferralDetail extends StatefulWidget {
  static final routeName = 'referral_detail';
  final Referral referral;
  ReferralDetail(this.referral);
  @override
  _ReferralDetailState createState() => _ReferralDetailState();
}

class _ReferralDetailState extends State<ReferralDetail> {
  void _sendEmail({BuildContext context, String id, String email}) async {
    await Provider.of<Referrals>(context)
        .sendEmail(email: email, referralId: id);
  }

  bool _animate = false;
  bool _showComment = false;

  @override
  Widget build(BuildContext context) {
    bool hasEmail = widget.referral.email != '';
    bool emailSent = widget.referral.collateralSent;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width - 80.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0))),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0)),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _animate = !_animate;
                  });
                },
                child: Image.asset(
                  'assets/images/nyc.jpg',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              bottom: _animate ? 20 : 80,
              curve: Curves.easeOutQuart,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        widget.referral.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        widget.referral.lastName.toUpperCase(),
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    widget.referral.phone,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  widget.referral.status == 'closed'
                      ? Text(
                          widget.referral.mon.toUpperCase(),
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0),
                        )
                      : Container(),
                ],
              ),
            ),
            Positioned(
              top: 60,
              right: 40,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName, (Route<dynamic> route) => false);
                },
                child: Material(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.black12,
                  elevation: 10.0,
                  child: Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          height: 2.0,
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await Provider.of<Referrals>(context)
                                .deleteReferral(widget.referral.id)
                                .then((success) {
                              if (success) {
                                Navigator.pushNamed(
                                    context, HomeScreen.routeName);
                              } else {
                                return;
                              }
                            });
                            print('deleted');
                          },
                        ),
                        IconButton(
                          tooltip: 'Edit',
                          icon: Icon(
                            Icons.edit,
                            size: 28,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditReferralScreen(widget.referral)));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.referral.address.toUpperCase(),
                          style: kTextStyleDetails,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.referral.apt.toUpperCase(),
                          style: kTextStyleDetails,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.referral.city.toUpperCase(),
                          style: kTextStyleDetails,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.referral.zipcode.toString(),
                          style: kTextStyleDetails,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Contact Info',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.referral.phone,
                              style: TextStyle(fontSize: 22.0),
                            ),
                            hasEmail
                                ? RaisedButton(
                                    child: Text(
                                      emailSent ? "Email Sent" : 'Send Email',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    onPressed: emailSent
                                        ? null
                                        : () => _sendEmail(
                                            context: context,
                                            email: widget.referral.email,
                                            id: widget.referral.id),
                                    color: Theme.of(context).accentColor,
                                  )
                                : Container(),
                          ],
                        ),
                        hasEmail
                            ? Text(
                                widget.referral.email,
                                style: kTextStyleDetails,
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //information only if the order was closed
                    Text(
                      'Additional Info',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    widget.referral.status == 'closed'
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Package: ${widget.referral.package}',
                                  style: kTextStyleDetails,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Due Date: ${DateFormat.yMMMEd().format(widget.referral.dueDate)}',
                                  style: kTextStyleDetails,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Order Placed On: ${DateFormat.yMMMEd().format(widget.referral.orderDate)}',
                                  style: kTextStyleDetails,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Moving Date: ${DateFormat.yMMMEd().format(widget.referral.moveIn)}',
                      style: kTextStyleDetails,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    widget.referral.collateralSent
                        ? Text(
                            'Collaterral Sent: ${DateFormat.yMMMEd().format(widget.referral.collateralSentOn)}',
                            style: kTextStyleDetails,
                          )
                        : Container(),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Status: ${widget.referral.status.toUpperCase()}',
                      style: kTextStyleDetails,
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Comments or Notes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.arrow_downward),
                              tooltip: 'Show/Hide',
                              onPressed: () {
                                setState(() {
                                  _showComment = !_showComment;
                                });
                              },
                            )
                          ],
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInCubic,
                          height: _showComment ? 300 : 1.0,
                          child: Text(
                            widget.referral.comment,
                            style: TextStyle(
                                fontSize: 16.0, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
