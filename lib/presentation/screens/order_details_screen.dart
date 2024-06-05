import 'package:flutter/material.dart';
import 'package:footwear_store_admin/styles.dart';
import 'package:intl/intl.dart';

import '../../data/models/order_product_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderProductModel order ;
   const OrderDetailsScreen({super.key , required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Order Details '),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding:  const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Align(
                alignment: Alignment.center,
                child: Image(
                  height: 150,
                  image: NetworkImage(order.productImageUrl),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Name : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      order.productName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
               const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text(
                    'Description : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(order.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Category  : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                   order.productCategory,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Brand  : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.productBrand,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Price  : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.price,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Address : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      order.address,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Phone : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      order.phone,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Order Time   : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(order.dateTime)),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
