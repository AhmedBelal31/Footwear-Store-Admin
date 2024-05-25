import 'package:flutter/material.dart';
import '../../controller/add_product_cubit.dart';

Widget buildDropDownError(AddProductCubit cubit,
    {required String errorMessage}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      errorMessage,
      style: const TextStyle(color: Colors.red, fontSize: 12),
    ),
  );
}
