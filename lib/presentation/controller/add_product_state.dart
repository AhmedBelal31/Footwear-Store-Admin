part of 'add_product_cubit.dart';

@immutable
sealed class AddProductStates {}

 class AddProductInitialState extends AddProductStates {}
 class ChangeDropDownBtnCategoryValueState extends AddProductStates {}
 class ChangeDropDownBtnBrandValueState extends AddProductStates {}
 class ChangeDropDownBtnOfferValueState extends AddProductStates {}
