import 'package:flutter/material.dart';
import 'package:footwear_store_admin/presentation/screens/edit_product_screen.dart';
import 'package:footwear_store_admin/presentation/widgets/home_screen_widgets/product_offer_and_price.dart';
import 'package:footwear_store_admin/presentation/widgets/home_screen_widgets/products_grid_view_banner.dart';
import '../../../data/models/product_model.dart';
import '../../../styles.dart';

class HomeProductsGridViewItem extends StatelessWidget {
  final ProductModel product;

  const HomeProductsGridViewItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditProductScreen(product: product),
          ),
        );
      },
      child: Container(
        // elevation:8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductsGridViewBanner(product: product),
              const SizedBox(height: 4),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, height: 1.3),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    // '${product.price}\$',
                    product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${product.price}\$',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppStyles.kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // if (product.offer == true)
              ProductOfferAndPrice(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
