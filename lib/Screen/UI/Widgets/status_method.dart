import 'package:flutter/material.dart';
import '../../../Style/color_style.dart';

Widget statusMethod( child) {
  return Container(
    child:child,
    alignment: Alignment.center,
    width: 100,
    height: 30,
    decoration: BoxDecoration(
        color: colorBlue,
        borderRadius: BorderRadius.circular(50)),
  );
}