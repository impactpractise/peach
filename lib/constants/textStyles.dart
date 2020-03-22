import 'package:flutter/material.dart';

final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
final regularTextStyle = baseTextStyle.copyWith(
    color: const Color(0xffb6b2df),
    fontSize: 12.0,
    fontWeight: FontWeight.w400);

final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
final headerTextStyleW = baseTextStyle.copyWith(
    color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);
final headerTextStyleB = baseTextStyle.copyWith(
    color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);
