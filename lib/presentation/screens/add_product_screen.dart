import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/styles.dart';
import '../controller/add_product_cubit.dart';
import '../widgets/add_new_product_widgets/add_product_model.dart';
import '../widgets/add_new_product_widgets/brand_drop_down_btn.dart';
import '../widgets/add_new_product_widgets/category_drop_down_btn.dart';
import '../widgets/add_new_product_widgets/custom_text_field.dart';
import '../widgets/add_new_product_widgets/offer_drop_down_btn.dart';
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
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (BuildContext context, AddProductStates state) {
          if (state is AddProductSuccessState) {
            CustomSnackBarOverlay.show(
              context,
              message: 'Success',
              messageDescription: 'Product Add Successfully !',
              msgColor: Colors.green,
            );
          }
          if (state is AddProductFailureState) {
            CustomSnackBarOverlay.show(
              context,
              message: 'Failed',
              messageDescription: 'Error , While Adding ${state.error}',
              msgColor: Colors.red,
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
                        validator: (value) => validateTextFieldInput(value,
                            errorMsg: 'Product Name Required '),
                        autovalidateMode: autoValidateMode,
                      ),
                      CustomTextField(
                        labelText: 'Product Description ',
                        hintText: 'Enter Your Product Description',
                        maxLines: 4,
                        controller: productDescriptionController,
                        validator: (value) => validateTextFieldInput(value,
                            errorMsg: 'Product Description Required '),
                        autovalidateMode: autoValidateMode,
                      ),
                      CustomTextField(
                        labelText: 'Product Image Url ',
                        hintText: 'Enter Your Image Url',
                        controller: productImageUrlController,
                        validator: (value) => validateTextFieldInput(value,
                            errorMsg: 'Product Image Url Required '),
                        autovalidateMode: autoValidateMode,
                      ),
                      CustomTextField(
                        labelText: 'Product Price ',
                        hintText: 'Enter Your Product Price',
                        controller: productPriceController,
                        keyboardType: TextInputType.number,
                        validator: (value) => validateTextFieldInput(value,
                            errorMsg: 'Product Price Required '),
                        autovalidateMode: autoValidateMode,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CategoryDropDownBtn(addProductCubit: cubit),
                          ),
                          Expanded(
                            child: BrandDropDownBtn(addProductCubit: cubit),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('Offer Product ?'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: OfferDropDownBtn(cubit: cubit),
                      ),
                      if (state is AddProductLoadingState)
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: CircularProgressIndicator(
                              color: AppStyles.kPrimaryColor),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          CustomSnackBarOverlay.show(
                            context,
                            message: 'Success',
                            messageDescription: 'Product Added Successfully!',
                            msgColor: Colors.green,

                          );
                        },
                        child:const Text('Test'),
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
                            resetFormFields(context);
                            } else {
                              autoValidateMode = AutovalidateMode.always;

                              CustomSnackBarOverlay.show(
                                context,
                                message: 'Failed',
                                messageDescription: 'Please fill all fields and select category, brand, and offer.',
                                msgColor: Colors.red,
                              );
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

  String? validateTextFieldInput(String? value, {required String errorMsg}) {
    if (value?.isEmpty ?? true) {
      return errorMsg;
    }
    return null;
  }

  void resetFormFields(BuildContext context) {
    setState(() {
      autoValidateMode = AutovalidateMode.disabled;

      productNameController.clear();
      productDescriptionController.clear();
      productImageUrlController.clear();
      productPriceController.clear();

      var cubit = BlocProvider.of<AddProductCubit>(context);
      cubit.selectedCategory = 'Category';
      cubit.selectedBrand = 'Brand';
      cubit.selectedOffer = 'Offer ?';

      Future.delayed(Duration.zero, () {
        setState(() {
          autoValidateMode = AutovalidateMode.disabled;
        });
      });
    });
  }
}
