import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/data/models/product_model.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';

class ProductListViewItem extends StatelessWidget {
  final ProductModel product;


  const ProductListViewItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name ?? ''),
      subtitle: Text('price: ${product.price}\$'),
      trailing: IconButton(
        onPressed: () {
          BlocProvider.of<ProductCubit>(context).deleteProduct(productId: product.id);

        },
        icon:const Icon(Icons.delete),
      ),
    );
  }
}
