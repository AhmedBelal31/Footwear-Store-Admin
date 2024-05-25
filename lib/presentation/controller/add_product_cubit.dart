import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footwear_store_admin/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  String? selectedCategory;
  String? selectedBrand;
  String? selectedOffer;

  void changeDropDownButtonCategory(String? value) {
    selectedCategory = value;
    emit(ChangeDropDownBtnCategoryValueState());
  }

  void changeDropDownButtonBrand(String? value) {
    selectedBrand = value;
    emit(ChangeDropDownBtnBrandValueState());
  }

  void changeDropDownButtonOffer(String? value) {
    selectedOffer = value;
    emit(ChangeDropDownBtnOfferValueState());
  }

  void addProduct({required ProductModel productModel}) {
    emit(AddProductLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .doc()
        .set(productModel.toJson())
        .then((value) {
      emit(AddProductSuccessState());
    }).catchError((error) {
      debugPrint('Error Is $error');
      emit(AddProductFailureState(error: error.toString()));
    });
  }
}
