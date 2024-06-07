import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import '../../controller/product_cubit.dart';
import 'build_drop_down_button.dart';
import 'custom_dropdown_button.dart';

class BrandDropDownBtn extends StatelessWidget {
  const BrandDropDownBtn({
    super.key,
    required this.addProductCubit,
     this.product
  });

  final ProductCubit addProductCubit;
  final  ProductModel? product ;
  @override
  Widget build(BuildContext context) {
    List<String> brandItems = ['Adidas', 'Nike', 'Crocs', 'Clarks', 'Skechers'];
    return Column(
      children: [
        CustomDropDownBtn(
          selectedItemText:product?.brand ??  'Brand',
          items: brandItems,
          onSelected: (value) {
            addProductCubit.changeDropDownButtonBrand(value);
          },
          selectedValue: addProductCubit.selectedBrand,
          onValueChanged: (value) {
            addProductCubit.changeDropDownButtonBrand(value);
          },
        ),
        // if (addProductCubit.brandError != null)
        //   buildDropDownError(addProductCubit, errorMessage: addProductCubit.brandError!),
      ],
    );
  }
}
