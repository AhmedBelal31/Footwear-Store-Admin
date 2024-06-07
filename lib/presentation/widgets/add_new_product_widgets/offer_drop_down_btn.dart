import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import '../../controller/product_cubit.dart';
import 'custom_dropdown_button.dart';

class OfferDropDownBtn extends StatelessWidget {
   OfferDropDownBtn({
    super.key,
    required this.cubit,
    this.product,
  });

   ProductCubit cubit;
  ProductModel? product;

  @override
  Widget build(BuildContext context) {
    List<String> offerItems = ['true', 'false'];
    return Column(
      children: [
        CustomDropDownBtn(
          selectedItemText: product?.offer==null  ?  'Offer ?' : product!.offer == true ? 'True': 'False',
          items: offerItems,
          onSelected: (value) {
            cubit.changeDropDownButtonOffer(value);
          },
          selectedValue: cubit.selectedOffer,
          onValueChanged: (value) {
            cubit.changeDropDownButtonOffer(value);
          },
        ),
        // if (cubit.offerError != null)
        //   buildDropDownError(cubit,
        //       errorMessage: cubit.offerError!),
      ],
    );
  }
}
