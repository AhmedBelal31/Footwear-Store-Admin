import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/build_awesome_dialog_warning.dart';
import '../../../data/models/product_model.dart';
import '../../controller/product_cubit.dart';

class ProductOfferAndPrice extends StatelessWidget {
  const ProductOfferAndPrice({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var random = Random();
    int randomNumber = random.nextInt(60);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: product.offer == true ? Colors.transparent : Colors.green,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: Text(
                '$randomNumber% OFF',
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
          onTap: () {
            buildAwesomeDialogWarning(context,
                title: 'Delete Product',
                message: 'Warning! Deleting this product is permanent. \n Are you absolutely sure?',
                btnOkOnPress: () {
              BlocProvider.of<ProductCubit>(context)
                  .deleteProduct(productId: product.id);
            }, btnCancelOnPress: () {});
          },
          child: const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 16,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
