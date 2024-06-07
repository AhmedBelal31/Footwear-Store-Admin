import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import 'home_product_grid_view_item.dart';

class HomeProductsGridView extends StatelessWidget {
  const HomeProductsGridView({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.grey[300],
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: screenWidth / screenHeight * 1.50,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (context, index) => HomeProductsGridViewItem(product: products[index]),
        itemCount: products.length,
      ),
    );
  }
}
