
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;

  final String hintText;

  final int maxLines;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          label: Text(labelText),
          hintText: hintText,
        ),
      ),
    );
  }
}