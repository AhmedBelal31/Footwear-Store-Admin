import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/styles.dart';
import '../controller/add_product_cubit.dart';
import '../widgets/add_new_product_widgets/custom_dropdown_button.dart';
import '../widgets/add_new_product_widgets/custom_text_field.dart';

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

  String? categoryError;
  String? brandError;
  String? offerError;

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

  bool validateDropdownSelections(AddProductCubit cubit) {
    bool isValid = true;
    if (cubit.selectedCategory == null) {
      setState(() {
        categoryError = 'Category Required';
      });
      isValid = false;
    } else {
      setState(() {
        categoryError = null;
      });
    }

    if (cubit.selectedBrand == null) {
      setState(() {
        brandError = 'Brand Required';
      });
      isValid = false;
    } else {
      setState(() {
        brandError = null;
      });
    }

    if (cubit.selectedOffer == null) {
      setState(() {
        offerError = 'Offer Required';
      });
      isValid = false;
    } else {
      setState(() {
        offerError = null;
      });
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryItems = ['Cate1', 'Cate2', 'Cate3'];
    List<String> brandItems = ['Brand1', 'Brand2', 'Brand3'];
    List<String> offerItems = ['true', 'false'];

    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (BuildContext context, AddProductStates state) {
          if (state is AddProductSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Product Add Successfully !'),
              ),
            );
          }
          if (state is AddProductFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error , While Adding ${state.error}'),
              ),
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
                                    if (value != null) {
                                      setState(() {
                                        categoryError = null;
                                      });
                                    }
                                  },
                                  selectedValue: cubit.selectedCategory,
                                  onValueChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        categoryError = null;
                                      });
                                    }
                                  },
                                ),
                                if (categoryError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      categoryError!,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
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
                                    if (value != null) {
                                      setState(() {
                                        brandError = null;
                                      });
                                    }
                                  },
                                  selectedValue: cubit.selectedBrand,
                                  onValueChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        brandError = null;
                                      });
                                    }
                                  },
                                ),
                                if (brandError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      brandError!,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
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
                                if (value != null) {
                                  setState(() {
                                    offerError = null;
                                  });
                                }
                              },
                              selectedValue: cubit.selectedOffer,
                              onValueChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    offerError = null;
                                  });
                                }
                              },
                            ),
                            if (offerError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  offerError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor: AppStyles.kPrimaryColor,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                validateDropdownSelections(cubit)) {
                              cubit.addProduct(
                                description: productDescriptionController.text,
                                imageUrl: productImageUrlController.text,
                                name: productNameController.text,
                                price:
                                    double.parse(productPriceController.text),
                              );

                              // productDescriptionController.clear();
                              // productPriceController.clear();
                              // productNameController.clear();
                              // productImageUrlController.clear();
                            } else {
                              autoValidateMode = AutovalidateMode.always;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'Please fill all fields and select category, brand, and offer.'),
                                ),
                              );
                              setState(() {});
                            }
                          },
                          child: const Text('  Add Product  '),
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
