import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footwear_store_admin/data/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../const.dart';

part 'product_states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(AddProductInitialState());
  TextEditingController productImageUrlController = TextEditingController();
  String? selectedCategory;
  String? selectedBrand;
  String? selectedOffer;
  String? categoryError;
  String? brandError;
  String? offerError;

  List<ProductModel> products = [];

  File? productImageFile;
  String? productImageUrl;

  void changeDropDownButtonCategory(String? value) {
    selectedCategory = value;
    validateDropdownSelections();
    emit(ChangeDropDownBtnCategoryValueState());
  }

  void changeDropDownButtonBrand(String? value) {
    selectedBrand = value;
    validateDropdownSelections();
    emit(ChangeDropDownBtnBrandValueState());
  }

  void changeDropDownButtonOffer(String? value) {
    selectedOffer = value;
    validateDropdownSelections();
    emit(ChangeDropDownBtnOfferValueState());
  }

  bool validateDropdownSelections() {
    bool isValid = true;
    if (selectedCategory == null) {
      categoryError = 'Category Required';
      isValid = false;
    } else {
      categoryError = null;
    }

    if (selectedBrand == null) {
      brandError = 'Brand Required';
      isValid = false;
    } else {
      brandError = null;
    }

    if (selectedOffer == null) {
      offerError = 'Offer Required';
      isValid = false;
    } else {
      offerError = null;
    }

    emit(AddProductValidationState());
    return isValid;
  }

  var doc = FirebaseFirestore.instance.collection(kProductsCollection).doc();

  void addProduct({
    required String description,
    String? imageUrl,
    required String name,
    required double price,
  }) {
    // if ((productImageUrlController.text.isEmpty || productImageUrl == null) &&
    //     productImageFile == null) {
    //   emit(AddProductValidationFailedState());
    //   return;
    // }
    if (!validateDropdownSelections()) {
      emit(AddProductValidationFailedState());
      return;
    }

    emit(AddProductLoadingState());

    ProductModel productModel = ProductModel(
      id: doc.id,
      dateTime: DateTime.now().toString(),
      // dateTime:"22/10",
      category: selectedCategory,
      brand: selectedBrand,
      description: description,
      imageUrl: imageUrl ?? (productImageUrl != null ? productImageUrl! : ""),
      name: name,
      price: price,
      offer: selectedOffer == 'true' ? true : false,
    );

    doc.set(productModel.toJson()).then((value) {
      emit(AddProductSuccessState());
    }).catchError((error) {
      emit(AddProductFailureState(error: error.toString()));
    });
  }

  void fetchAllProducts() {
    emit(GetProductLoadingState());
    FirebaseFirestore.instance
        .collection(kProductsCollection)
        .orderBy('dateTime')
        .get()
        .then((values) {
      products.clear(); // Clear the list before adding new products
      for (var element in values.docs) {
        products.add(ProductModel.fromJson(element.data()));
      }
      emit(GetProductSuccessState());
    }).catchError((error) {
      emit(GetProductFailureState(error: error.toString()));
    });
  }

  void deleteProduct({required String productId}) {
    emit(DeleteProductLoadingState());
    FirebaseFirestore.instance
        .collection(kProductsCollection)
        .doc(productId)
        .delete()
        .then((_) {
      emit(DeleteProductSuccessState());
      fetchAllProducts();
    }).catchError((error) {
      emit(DeleteProductFailureState(error: error));
    });
  }

  void pickProductImage() {
    emit(PickImageLoadingState());
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    picker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        productImageFile = File(value.path);
        print(value.path);
        emit(PickImageSuccessState());
      }
    }).catchError((error) {
      emit(PickImageFailureState(error: error));
    });
  }

  void uploadProductImage() {
    emit(UploadImageLoadingState());
    if(productImageFile!=null)
      {
        FirebaseStorage.instance
            .ref()
            .child('products/${Uri.file(productImageFile!.path).pathSegments.last}')
            .putFile(productImageFile!)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            productImageUrl = value;
            emit(UploadImageSuccessState());
          }).catchError((error) {
            emit(UploadImageFailureState(error: error));
          });
        }).catchError((error) {
          emit(UploadImageFailureState(error: error));
        });
      }

  }
}