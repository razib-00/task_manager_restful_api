
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'color_style.dart';



//Success Toast Message
successToast(msg){
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: colorGreen,
      textColor: colorWhite,
      fontSize: 16.0
  );
}



//Toast message Error msg

errorToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: colorRed,
      textColor: colorWhite,
      fontSize: 16.0
  );
}
// H1 Style
TextStyle head1Text(Color head1Color){
  return TextStyle(
      color: head1Color,
      fontWeight: FontWeight.w800,
      fontSize: 24,
      fontFamily:'Poppins'
  );
}

//H5 style
TextStyle head5Text(textColor){
  return TextStyle(
      color: textColor,
      fontSize: 20,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400
  );
}//H4 style
TextStyle head4Text(){
  return TextStyle(
      fontSize: 20,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400
  );
}

//H6 style
TextStyle head6Text(textColor){
  return TextStyle(
      color: textColor,
      fontSize: 16,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400
  );
}

//H7 style
TextStyle head7Text(textColor){
  return TextStyle(
      color: textColor,
      fontSize: 14,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400
  );
}
