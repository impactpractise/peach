import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peach/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;

  submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(content: Text("Welcome $username!"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context,
          titleText: 'Setup your profile', removeBackButton: true),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: ListView(children: <Widget>[
          Container(
            child: SvgPicture.asset(
              'assets/images/create_account.svg',
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  autovalidate: true,
                  child: TextFormField(
                    validator: (userInput) {
                      if (userInput.trim().length < 3 || userInput.isEmpty) {
                        return 'Username too short';
                      } else if (userInput.trim().length > 15) {
                        return 'Username too long';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (userInput) => username = userInput,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFFF2660), width: 2.5),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelText: 'Username',
                        labelStyle:
                            TextStyle(fontSize: 15.0, color: Color(0xFFFF2660)),
                        hintText: 'Minimum 3 characters'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: GestureDetector(
              onTap: submit,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFF2660), width: 2.5),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Color(0xFFFF2660),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
