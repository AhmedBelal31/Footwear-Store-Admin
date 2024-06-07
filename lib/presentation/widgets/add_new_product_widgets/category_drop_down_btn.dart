import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/data/models/product_model.dart';

import '../../controller/product_cubit.dart';
import 'build_drop_down_button.dart';
import 'custom_dropdown_button.dart';

class CategoryDropDownBtn extends StatelessWidget {
   CategoryDropDownBtn({
    super.key,
    required this.addProductCubit,
    this.product
  });

  final ProductCubit addProductCubit;
  ProductModel? product ;

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
          selectedItemText:product?.category ?? 'Category',
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