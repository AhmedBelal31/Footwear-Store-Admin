import 'package:flutter/material.dart';
import '../../controller/product_cubit.dart';

Widget buildDropDownError(ProductCubit cubit,
    {required String errorMessage}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: Text(
      errorMessage,
      style: const TextStyle(color: Colors.red, fontSize: 12),
    ),
  );
}
