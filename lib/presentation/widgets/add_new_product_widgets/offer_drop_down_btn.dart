import 'package:flutter/material.dart';

import '../../controller/add_product_cubit.dart';
import 'build_drop_down_button.dart';
import 'custom_dropdown_button.dart';

class OfferDropDownBtn extends StatelessWidget {
  const OfferDropDownBtn({
    super.key,
    required this.cubit,
  });


  final AddProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    List<String> offerItems = ['true', 'false'];
    return Column(
      children: [
        CustomDropDownBtn(
          selectedItemText: 'Offer ?',
          items: offerItems,
          onSelected: (value) {
            cubit.changeDropDownButtonOffer(value);
          },
          selectedValue: cubit.selectedOffer,
          onValueChanged: (value) {
            cubit.changeDropDownButtonOffer(value);
          },
        ),
        if (cubit.offerError != null)
          buildDropDownError(cubit,
              errorMessage: cubit.offerError!),
      ],
    );
  }
}