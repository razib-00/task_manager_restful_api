import 'package:flutter/material.dart';

import 'color_style.dart';

//Elevated Button Style
ButtonStyle elevatedButton() {
  return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      backgroundColor: colorAmber,
      foregroundColor: colorWhite,
      alignment: Alignment.center,
      textStyle: const TextStyle(fontSize: 18, color: colorWhite));
}
ButtonStyle elevatedButtonEditDelete(Color color) {
  return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      backgroundColor: colorAmber,
      foregroundColor: color,
      alignment: Alignment.center,
      textStyle: const TextStyle(fontSize: 18));
}

// Text Style
TextStyle buttonTextStyle(Color color) {
  return TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      color: color);
}

//Success Button Style
Widget successButton(String buttonText) {
  return Ink(
    decoration: BoxDecoration(
        color: colorGreen, borderRadius: BorderRadius.circular(20)),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: buttonTextStyle(colorGreen),
      ),
    ),
  );
}

//custom Icon Button
Widget customIconButton() {
  return const Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Next'),
      SizedBox(
        width: 5,
      ),
      Icon(Icons.arrow_forward_ios)
    ],
  );
}
