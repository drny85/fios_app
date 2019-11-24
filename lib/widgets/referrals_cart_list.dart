import 'package:fios/models/referral.dart';
import 'package:fios/widgets/referral_card.dart';
import 'package:flutter/material.dart';

class ReferralsCardListView extends StatelessWidget {
  final List<Referral> referrals;
  final String referralStatus;
  ReferralsCardListView({this.referrals, this.referralStatus});

  @override
  Widget build(BuildContext context) {
    return referrals.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 10.0),
                child: Text(
                  '$referralStatus (${referrals.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 2.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              Container(
                height: 275,
                padding: const EdgeInsets.all(4),
                //margin: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: referrals.length, //DUMMY_DATA.length,
                  itemBuilder: (ctx, index) {
                    final referral = referrals[index];
                    return referrals.length > 0 ? ReferralCard(referral) : null;
                  },
                ),
              ),
              Divider(
                color: Colors.redAccent,
                height: 2.0,
              )
            ],
          )
        : Container();
  }
}
