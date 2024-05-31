import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/screens/home_screen.dart';
import 'package:footwear_store_admin/styles.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/product_cubit.dart';
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
  late TextEditingController productPriceController;

  @override
  void initState() {
    productNameController = TextEditingController();
    productDescriptionController = TextEditingController();
    productPriceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (BuildContext context, ProductStates state) {
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
          var cubit = BlocProvider.of<ProductCubit>(context);
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
                        controller: cubit.productImageUrlController,
                        // validator : (value)
                        // {
                        //   if (value!.isEmpty && cubit.productImageFile == null) {
                        //     return 'Product Image Url Required ';
                        //   }
                        //   return null;
                        // } ,
                        validator: (value) => validateTextFieldInput(value,
                            errorMsg: 'Product Image Required '),
                        autovalidateMode: autoValidateMode,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.grey.shade100.withOpacity(.6),
                                      spreadRadius: 11,
                                      blurRadius: 1,
                                    )
                                  ]),
                              child: const Text(
                                'Upload Your Image ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppStyles.kPrimaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10)),
                              onPressed: () {
                                cubit.pickProductImage();
                              },
                              child: const Icon(Icons.upload),
                            ),
                          ],
                        ),
                      ),
                      if(state is UploadImageLoadingState)
                        const Padding(
                          padding:  EdgeInsets.all(20),
                          child:  LinearProgressIndicator(),
                        ),
                      const SizedBox(height: 10),
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
                          Flexible(
                            child: CategoryDropDownBtn(addProductCubit: cubit),
                          ),
                          Flexible(
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
                      if (state is! AddProductLoadingState)
                        AddProductButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                cubit.validateDropdownSelections()) {
                              cubit.addProduct(
                                description: productDescriptionController.text,
                                imageUrl: cubit.productImageUrlController.text,
                                name: productNameController.text,
                                price: double.tryParse(
                                        productPriceController.text) ??
                                    200,
                              );
                              resetFormFields(context );
                              cubit.fetchAllProducts();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } else {
                              autoValidateMode = AutovalidateMode.always;

                              CustomSnackBarOverlay.show(
                                context,
                                message: 'Failed',
                                messageDescription:
                                    'Please fill all fields and select category, brand, and offer.',
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

  void resetFormFields(BuildContext context ) {
    var cubit = BlocProvider.of<ProductCubit>(context);
    setState(() {
      autoValidateMode = AutovalidateMode.disabled;

      productNameController.clear();
      productDescriptionController.clear();
      cubit.productImageUrlController.clear();
      productPriceController.clear();
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
