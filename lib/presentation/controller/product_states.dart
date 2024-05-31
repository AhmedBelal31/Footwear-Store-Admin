part of 'product_cubit.dart';

@immutable
sealed class ProductStates {}

class AddProductInitialState extends ProductStates {}

class ChangeDropDownBtnCategoryValueState extends ProductStates {}

class ChangeDropDownBtnBrandValueState extends ProductStates {}

class ChangeDropDownBtnOfferValueState extends ProductStates {}

/// Add Product States
class AddProductLoadingState extends ProductStates {}
class AddProductSuccessState extends ProductStates {}
class AddProductFailureState extends ProductStates {
  final String error;

  AddProductFailureState({required this.error});
}


///DropDownButtons Product Validation States
class AddProductValidationState extends ProductStates {}
class AddProductValidationFailedState extends ProductStates {}


//Get Products
class GetProductLoadingState extends ProductStates {}
class GetProductSuccessState extends ProductStates {}
class GetProductFailureState extends ProductStates {
  final String error;

  GetProductFailureState({required this.error});
}

///Delete Products
class DeleteProductLoadingState extends ProductStates {}
class DeleteProductSuccessState extends ProductStates {}
class DeleteProductFailureState extends ProductStates {
  final String error;

  DeleteProductFailureState({required this.error});
}

///Pick Product Image
class PickImageLoadingState extends ProductStates {}
class PickImageSuccessState extends ProductStates {}
class PickImageFailureState extends ProductStates
{
 final String error ;
  PickImageFailureState({required this.error});
}

///Upload Product Image
class UploadImageLoadingState extends ProductStates {}
class UploadImageSuccessState extends ProductStates {}
class UploadImageFailureState extends ProductStates
{
  final String error ;
  UploadImageFailureState({required this.error});
}