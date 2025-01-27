import 'package:flutter/material.dart';

import 'color_style.dart';

//InputDecoration
InputDecoration inputDecoration(labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: colorBlack,
        fontFamily: 'Poppins'),
    filled: true,
    fillColor: colorWhite,
    focusColor: colorYellow,
    enabledBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: colorGreen)),
    disabledBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: colorGrey)),
    border: const OutlineInputBorder(borderSide: BorderSide(color: colorBlack)),
  );
}

//Code Input
InputDecoration inputDecorationCode() {
  return const InputDecoration(
    /* labelStyle:  const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: colorBlack,
        fontFamily: 'Poppins'
    ),*/

    filled: true,
    fillColor: colorWhite,
    focusColor: colorYellow,
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorGreen)),
    disabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorGrey)),
    border: OutlineInputBorder(borderSide: BorderSide(color: colorBlack)),
  );
}

// Icon Input Decoration
InputDecoration inputDecorationIcon(String labelText, Icon suffixIcon) {
  return InputDecoration(
    labelText: labelText,
    suffixIcon: suffixIcon,
    labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: colorBlack,
        fontFamily: 'Poppins'),
    filled: true,
    fillColor: colorWhite,
    focusColor: colorYellow,
    enabledBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: colorGreen)),
    disabledBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: colorGrey)),
    border: const OutlineInputBorder(borderSide: BorderSide(color: colorBlack)),
  );
}
