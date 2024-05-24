import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/styles.dart';

import '../controller/add_product_cubit.dart';
import '../widgets/add_new_product_widgets/custom_dropdown_button.dart';
import '../widgets/add_new_product_widgets/custom_text_field.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categoryItems = ['Cate1', 'Cate2', 'Cate3'];
    List<String> brandItems = ['Brand1', 'Brand2', 'Brand3'];
    List<String> offerItems = ['true', 'false'];
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocBuilder<AddProductCubit, AddProductStates>(
        builder: (context, state) {
          var cubit = BlocProvider.of<AddProductCubit>(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Text('Add Product ',
                        style: TextStyle(
                            fontSize: 30, color: AppStyles.kPrimaryColor)),
                    const SizedBox(height: 30),
                    const CustomTextField(
                      labelText: 'Product Name ',
                      hintText: 'Enter Your Product name',
                    ),
                    const CustomTextField(
                      labelText: 'Product Description ',
                      hintText: 'Enter Your Product Description',
                      maxLines: 4,
                    ),
                    const CustomTextField(
                      labelText: 'Product Image Url ',
                      hintText: 'Enter Your Image Url',
                    ),
                    const CustomTextField(
                      labelText: 'Product Price ',
                      hintText: 'Enter Your Product Price',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDownBtn(
                            items: categoryItems,
                            selectedItemText: 'Category',
                            onSelected: (value) {
                              cubit.changeDropDownButtonCategory(value);
                            },
                            selectedValue: cubit.selectedCategory,
                          ),
                        ),
                        Expanded(
                          child: CustomDropDownBtn(
                            selectedItemText: 'Brand',
                            items: brandItems,
                            onSelected: (value) {
                              cubit.changeDropDownButtonBrand(value);
                            },
                            selectedValue: cubit.selectedBrand,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Offer Product ?'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: CustomDropDownBtn(
                        selectedItemText: 'Offer ?',
                        items: offerItems,
                        onSelected: (value) {
                          cubit.changeDropDownButtonOffer(value);
                        },
                        selectedValue: cubit.selectedOffer,
                      ),
                    ),
                    buildAddProductBtn()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ElevatedButton buildAddProductBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: AppStyles.kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      onPressed: () {},
      child: const Text('  Add Product  '),
    );
  }
}
