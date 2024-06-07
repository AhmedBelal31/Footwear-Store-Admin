import 'package:flutter/material.dart';
import '../../../styles.dart';

class AddProductButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const AddProductButton({
    super.key,
    this.onPressed, required this.text,

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: AppStyles.kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
