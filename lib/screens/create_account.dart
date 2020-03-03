import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peach/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  String username;

//  submit() {
//    _formKey.currentState.save();
//    Navigator.pop(context, username);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Setup your profile'),
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
                  child: TextFormField(
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
              onTap: () {
                _formKey.currentState.save();
                Navigator.pop(context, username);
              },
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
