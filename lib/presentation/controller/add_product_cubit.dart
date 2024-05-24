import 'package:bloc/bloc.dart';
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

}
