import 'package:flutter/material.dart';

class ReuseableTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String label;
  final String errText;
  final bool isValid;

  ReuseableTextFormField(
      {this.controller,
      @required this.title,
      @required this.label,
      this.isValid: true,
      this.errText});

  @override
  Column build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            title,
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
        TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: label, errorText: isValid ? null : errText)),
      ],
    );
  }
}
