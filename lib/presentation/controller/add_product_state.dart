part of 'add_product_cubit.dart';

@immutable
sealed class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class ChangeDropDownBtnCategoryValueState extends AddProductStates {}

class ChangeDropDownBtnBrandValueState extends AddProductStates {}

class ChangeDropDownBtnOfferValueState extends AddProductStates {}

/// Add Product States
class AddProductLoadingState extends AddProductStates {}
class AddProductSuccessState extends AddProductStates {}
class AddProductFailureState extends AddProductStates {
  final String error;

  AddProductFailureState({required this.error});
}


///DropDownButtons Product Validation States
class AddProductValidationState extends AddProductStates {}
class AddProductValidationFailedState extends AddProductStates {}


//Get Products
class GetProductLoadingState extends AddProductStates {}
class GetProductSuccessState extends AddProductStates {}
class GetProductFailureState extends AddProductStates {
  final String error;

  GetProductFailureState({required this.error});
}
