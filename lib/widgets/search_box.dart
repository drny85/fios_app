import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final Function onChanged;

  SearchBox({this.hintText, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: Icon(Icons.search)),
        onChanged: onChanged,
      ),
    );
  }
}
