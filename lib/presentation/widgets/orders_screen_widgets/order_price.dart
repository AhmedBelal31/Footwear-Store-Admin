import 'package:flutter/material.dart';
import 'package:footwear_store_admin/data/models/order_product_model.dart';
import '../../../styles.dart';

class OrderPrice extends StatelessWidget {
  const OrderPrice({
    super.key,
    required this.isChecked,
    required this.order,
  });

  final bool isChecked;
  final OrderProductModel order;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Price: ',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
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
    );
  }
}
