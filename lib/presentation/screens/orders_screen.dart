import 'package:flutter/material.dart';
import 'package:footwear_store_admin/presentation/screens/order_details_screen.dart';
import 'package:footwear_store_admin/styles.dart';

import '../../data/models/order_product_model.dart';

class OrdersScreen extends StatelessWidget {
  final List<OrderProductModel> orders;

  const OrdersScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ProductOrderListViewItem(
              order: orders[index],
            );
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
            indent: 12,
            endIndent: 12,
          ),
          itemCount: orders.length,
        ),
      ),
    );
  }
}

class ProductOrderListViewItem extends StatelessWidget {
  final OrderProductModel order;

  const ProductOrderListViewItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  OrderDetailsScreen(order: order,),
        ));
      },
      child: Row(
        children: [
          Image(
            height: 120,
            width: 120,
            image: NetworkImage(order.productImageUrl),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Price : ',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: '${order.price}\$',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppStyles.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
