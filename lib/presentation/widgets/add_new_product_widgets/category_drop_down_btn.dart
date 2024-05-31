import 'package:flutter/material.dart';

import '../../controller/product_cubit.dart';
import 'build_drop_down_button.dart';
import 'custom_dropdown_button.dart';

class CategoryDropDownBtn extends StatelessWidget {
  const CategoryDropDownBtn({
    super.key,
    required this.addProductCubit,
  });

  final ProductCubit addProductCubit;

  @override
  Widget build(BuildContext context) {
    List<String> categoryItems = [
      'Boots',
      'Flats',
      'Sandal',
      'Shoes',
      'Heals',
      'Slippers'
    ];
    return Column(
      children: [
        CustomDropDownBtn(
          items: categoryItems,
          selectedItemText: 'Category',
          onSelected: (value) {
            addProductCubit.changeDropDownButtonCategory(value);
          },
          selectedValue: addProductCubit.selectedCategory,
          onValueChanged: (value) {
            addProductCubit.changeDropDownButtonCategory(value);
          },
        ),
        // if (addProductCubit.categoryError != null)
        //   buildDropDownError(addProductCubit, errorMessage: addProductCubit.categoryError!),
      ],
    );
  }
}