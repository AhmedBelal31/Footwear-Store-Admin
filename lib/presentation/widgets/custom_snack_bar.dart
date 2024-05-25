import 'package:flutter/material.dart';

void customSnackBar(BuildContext context,
    {Color backgroundColor = Colors.grey, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(msg),
    ),
  );
}
