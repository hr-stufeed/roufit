import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: kBorderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(style: BorderStyle.none),
        ),
        labelText: '운동,태그...',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        fillColor: Colors.grey[300],
        filled: true,
      ),
    );
  }
}
