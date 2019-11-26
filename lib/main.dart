import 'package:fios/providers/auth.dart';
import 'package:fios/providers/managers.dart';
import 'package:fios/providers/notes.dart';
import 'package:fios/providers/referrals.dart';
import 'package:fios/providers/referres.dart';
import 'package:fios/screens/home_screen.dart';
import 'package:fios/screens/login_screen.dart';
import 'package:fios/screens/managers/managers_screen.dart';
import 'package:fios/screens/notes/notes_screen.dart';

import 'package:fios/screens/profile_screen.dart';
import 'package:fios/screens/referees_screen.dart';
import 'package:fios/screens/referrals/add_referral.dart';
import 'package:fios/screens/referrals/referrals_screen.dart';

import 'package:fios/screens/splah_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Referrals(),
        ),
        ChangeNotifierProvider.value(
          value: Notes(),
        ),
        ChangeNotifierProvider.value(
          value: Referees(),
        ),
        ChangeNotifierProvider.value(
          value: Managers(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Fios',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            primaryColor: Colors.red,
            accentColor: Colors.white,
            fontFamily: 'Montserrat',

            primarySwatch: Colors.red,
          ),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            ReferralsScreen.routeName: (context) => ReferralsScreen(),
            RefereesScreen.routeName: (context) => RefereesScreen(),
            ManagersScreen.routeName: (context) => ManagersScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            NotesScreen.routeName: (context) => NotesScreen(),
            AddReferralScreen.routeName: (context) => AddReferralScreen(),
            //EditReferralScreen.routeName: (context) => EditReferralScreen(),
          },
        ),
      ),
    );
  }
}
