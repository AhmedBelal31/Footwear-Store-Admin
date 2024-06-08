import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footwear_store_admin/data/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../const.dart';
import '../../data/models/order_product_model.dart';
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
      category: selectedCategory!,
      brand: selectedBrand!,
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

  void fetchAllProducts()  {
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
      emit(DeleteProductFailureState(error: error.toString()));
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
        // emit(PickImageSuccessState());
        uploadProductImage(); // Upload the image after picking it
      } else {
        emit(PickImageFailureState(error: 'No image selected.'));
      }
    }).catchError((error) {
      emit(PickImageFailureState(error: error.toString()));
    });
  }

  void uploadProductImage() {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(productImageFile!.path).pathSegments.last}')
        .putFile(productImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((downloadUrl) {
        productImageUrl = downloadUrl;
        productImageUrlController.text = downloadUrl; // Update the controller
        emit(UploadImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadImageFailureState(error: error.toString()));
    });
  }

  List<OrderProductModel> orders = [];

  void getOrders() {
    emit(GetOrdersLoadingState());
    FirebaseFirestore.instance
        .collection(kOrdersCollection)
        .get()
        .then((values) {
      orders.clear();
      orders.addAll(
        values.docs
            .map((element) => OrderProductModel.fromJson(element.data()))
            .toList(),
      );

      emit(GetOrdersSuccessState());
    }).catchError((error) {
      emit(GetProductFailureState(error: error.toString()));
    });
  }

  void updateOrderStatusValue(
      {required String orderID, required bool isShipped}) {
    emit(ChangeOrderStatusLoadingState());
    FirebaseFirestore.instance
        .collection(kOrdersCollection)
        .doc(orderID)
        .update({'isShipped': isShipped}).then((_) {
      emit(ChangeOrderStatusSuccessState());
    }).catchError((error) {
      emit(ChangeOrderStatusFailureState(error: error.toString()));
    });
  }

  void updateProduct({
    required String productID,
    required ProductModel originalProduct,
    required ProductModel updatedProduct,
  })  async{
    emit(UpdateProductsLoadingState());

    // To only Send The Changed Field
    Map<String, dynamic> updatedFields = {};
    if (updatedProduct.name != originalProduct.name) {
      updatedFields['name'] = updatedProduct.name;
    }
    if (updatedProduct.description != originalProduct.description) {
      updatedFields['description'] = updatedProduct.description;
    }
    if (updatedProduct.price != originalProduct.price) {
      updatedFields['price'] = updatedProduct.price;
    }
    if (updatedProduct.imageUrl != originalProduct.imageUrl) {
      updatedFields['imageUrl'] = updatedProduct.imageUrl;
    }
    if (updatedProduct.category != originalProduct.category) {
      updatedFields['category'] = updatedProduct.category;
    }
    if (updatedProduct.brand != originalProduct.brand) {
      updatedFields['brand'] = updatedProduct.brand;
    }
    if (updatedProduct.offer != originalProduct.offer) {
      updatedFields['offer'] = updatedProduct.offer;
    }
    if (updatedFields.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(kProductsCollection)
          .doc(productID)
          .update(updatedFields)
          .then((_) {
        var index = products.indexWhere((element) => element.id == productID);
        if (index != -1) {
          products[index] = updatedProduct;
          emit(UpdateProductsSuccessState(products: products));
        }
      }).catchError((error) {
        emit(UpdateProductsFailureState(error: error.toString()));
      });
    }
  }
}
