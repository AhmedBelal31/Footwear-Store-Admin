import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

AwesomeDialog buildAwesomeDialogWarning(
  BuildContext context, {
  required String title,
  required String message,
  Function()? btnOkOnPress,
  Function()? btnCancelOnPress,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.rightSlide,
    customHeader: CircleAvatar(
      radius: 50, // Adjust the radius as needed
      backgroundColor: Colors.transparent,
      child: Lottie.asset(
        'assets/images/warning.json',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    ),
    title: title,
    desc: message,
    btnCancelOnPress: btnCancelOnPress,
    btnOkOnPress:btnOkOnPress,
  )..show();
}
