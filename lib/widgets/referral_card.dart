import 'package:fios/models/referral.dart';
import 'package:fios/screens/referrals/referral_details.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReferralCard extends StatelessWidget {
  final Referral referral;
  ReferralCard(this.referral);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReferralDetail(referral)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Container(
          height: 300,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      referral.name.toUpperCase(),
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      referral.lastName.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    Spacer(),
                    referral.collateralSent
                        ? Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${referral.address},'.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'City:',
                      style: kReferralCardTextStyle,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      referral.city,
                      style: kReferralCardTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Moving Date:',
                      style: kReferralCardTextStyle,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      DateFormat.yMMMEd().format(referral.moveIn),
                      style: kReferralCardTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Phone:',
                      style: kReferralCardTextStyle,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      referral.phone,
                      style: kReferralCardTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  width: 340,
                  child: referral.email != ''
                      ? Row(
                          children: <Widget>[
                            Text(
                              'Email:',
                              style: kReferralCardTextStyle,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Text(
                                referral.email,
                                style: kReferralCardTextStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3.0, 6.0),
                    blurRadius: 3.0,
                    spreadRadius: 2.0),
              ],
              color: referral.collateralSent
                  ? Colors.grey[200]
                  : Colors.grey[100]),
        ),
      ),
    );
  }
}
