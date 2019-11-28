import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget child;

  BottomSheetWidget({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        child: child,
      ),
    );
  }
}
