import 'package:flutter/material.dart';

class ManagersScreen extends StatefulWidget {
  static final routeName = 'managers';

  @override
  _ManagersScreenState createState() => _ManagersScreenState();
}

class _ManagersScreenState extends State<ManagersScreen> {
  bool _anamite = false;
  bool _anamiteShow = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      setState(() {
        _anamite = true;
      });
    });

    Future.delayed(Duration(milliseconds: 600)).then((_) {
      setState(() {
        _anamiteShow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: _anamite ? MediaQuery.of(context).size.height * 0.7 : 0.0,
            width: _anamite ? MediaQuery.of(context).size.width * 0.95 : 0.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor.withOpacity(0.6),
                    Theme.of(context).accentColor.withOpacity(0.7),
                    Theme.of(context).accentColor.withOpacity(0.8),
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                )),
            padding: const EdgeInsets.all(20.0),
            child: _anamiteShow
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      makeRoundedButton(
                          child: Text(
                        'See Managers',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                      SizedBox(
                        height: 30.0,
                      ),
                      makeRoundedButton(
                          child: Text(
                        'See Referees',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )),
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  Widget makeRoundedButton({Widget child}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 60.0,
      child: Center(
          child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: child,
      )),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                offset: Offset(2.0, 3.0))
          ]),
    );
  }
}
