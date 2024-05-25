import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/styles.dart';
import '../controller/add_product_cubit.dart';
import '../widgets/add_new_product_widgets/add_product_model.dart';
import '../widgets/add_new_product_widgets/build_drop_down_button.dart';
import '../widgets/add_new_product_widgets/custom_dropdown_button.dart';
import '../widgets/add_new_product_widgets/custom_text_field.dart';
import '../widgets/custom_snack_bar.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late TextEditingController productNameController;
  late TextEditingController productDescriptionController;
  late TextEditingController productImageUrlController;
  late TextEditingController productPriceController;

  @override
  void initState() {
    productNameController = TextEditingController();
    productDescriptionController = TextEditingController();
    productImageUrlController = TextEditingController();
    productPriceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productImageUrlController.dispose();
    productPriceController.dispose();
    super.dispose();
  }

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
    List<String> brandItems = ['Adidas', 'Nike', 'Crocs', 'Clarks', 'Skechers'];
    List<String> offerItems = ['true', 'false'];

    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (BuildContext context, AddProductStates state) {
          if (state is AddProductSuccessState) {
            customSnackBar(
              context,
              msg: 'Product Add Successfully !',
              backgroundColor: Colors.green,
            );
          }
          if (state is AddProductFailureState) {
            customSnackBar(
              context,
              msg: 'Error , While Adding ${state.error}',
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AddProductCubit>(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      const Text('Add Product ',
                          style: TextStyle(
                              fontSize: 30, color: AppStyles.kPrimaryColor)),
                      const SizedBox(height: 30),
                      CustomTextField(
                        labelText: 'Product Name ',
                        hintText: 'Enter Your Product name',
                        controller: productNameController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Product Name Required ';
                          }
                          return null;
                        },
                        autovalidateMode: autoValidateMode,
                      ),
                      CustomTextField(
                        labelText: 'Product Description ',
                        hintText: 'Enter Your Product Description',
                        maxLines: 4,
                        controller: productDescriptionController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Product Description Required ';
                          }
                          return null;
                        },
                        autovalidateMode: autoValidateMode,
                      ),
                      CustomTextField(
                        labelText: 'Product Image Url ',
                        hintText: 'Enter Your Image Url',
                        controller: productImageUrlController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Product Image Url Required ';
                          }
                          return null;
                        },
                        autovalidateMode: autoValidateMode,
                      ),
                      CustomTextField(
                        labelText: 'Product Price ',
                        hintText: 'Enter Your Product Price',
                        controller: productPriceController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Product Price Required ';
                          }
                          return null;
                        },
                        autovalidateMode: autoValidateMode,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CustomDropDownBtn(
                                  items: categoryItems,
                                  selectedItemText: 'Category',
                                  onSelected: (value) {
                                    cubit.changeDropDownButtonCategory(value);
                                  },
                                  selectedValue: cubit.selectedCategory,
                                  onValueChanged: (value) {
                                    cubit.changeDropDownButtonCategory(value);
                                  },
                                ),
                                if (cubit.categoryError != null)
                                  buildDropDownError(cubit,
                                      errorMessage: cubit.categoryError!),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CustomDropDownBtn(
                                  selectedItemText: 'Brand',
                                  items: brandItems,
                                  onSelected: (value) {
                                    cubit.changeDropDownButtonBrand(value);
                                  },
                                  selectedValue: cubit.selectedBrand,
                                  onValueChanged: (value) {
                                    cubit.changeDropDownButtonBrand(value);
                                  },
                                ),
                                if (cubit.brandError != null)
                                  buildDropDownError(cubit,
                                      errorMessage: cubit.brandError!),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('Offer Product ?'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: Column(
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
                        ),
                      ),
                      if (state is AddProductLoadingState)
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: CircularProgressIndicator(
                              color: AppStyles.kPrimaryColor),
                        ),
                      if (state is! AddProductLoadingState)
                        AddProductButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                cubit.validateDropdownSelections()) {
                              cubit.addProduct(
                                description: productDescriptionController.text,
                                imageUrl: productImageUrlController.text,
                                name: productNameController.text,
                                price: double.tryParse(
                                    productPriceController.text)!,
                              );
                            } else {
                              autoValidateMode = AutovalidateMode.always;
                              customSnackBar(context,
                                  backgroundColor: Colors.red,
                                  msg:
                                      'Please fill all fields and select category, brand, and offer.');
                              setState(() {});
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
