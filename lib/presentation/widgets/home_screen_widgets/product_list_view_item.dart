import 'package:flutter/material.dart';

class ProductListViewItem extends StatelessWidget {
  final String productName;

  final String price;

  final void Function()? onPressed;

  const ProductListViewItem({
    super.key,
    required this.productName,
    required this.price,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(productName),
      subtitle: Text('price: $price\$'),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.delete),
      ),
    );
  }
}