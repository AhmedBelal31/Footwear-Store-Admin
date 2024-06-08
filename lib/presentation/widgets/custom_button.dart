import 'package:flutter/material.dart';
import '../../styles.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const CustomButton({
    super.key,
    this.onPressed, required this.text,

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        backgroundColor: AppStyles.kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
