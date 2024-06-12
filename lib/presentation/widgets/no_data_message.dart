import 'package:flutter/material.dart';

class NoDataMessage extends StatelessWidget {
  final String message ;
  const NoDataMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 7), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child:  Text(
          message ,
          style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700]
          ),
        ),
      ),
    );
  }
}