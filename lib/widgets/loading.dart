import 'package:flutter/material.dart';

Container circularLoading(context) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    ),
  );
}

Container linearProgress(context) {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation(
        Theme.of(context).primaryColor,
      ),
    ),
  );
}
