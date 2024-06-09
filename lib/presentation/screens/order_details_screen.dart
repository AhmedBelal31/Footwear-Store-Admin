import 'package:flutter/material.dart';
import 'package:footwear_store_admin/styles.dart';
import 'package:intl/intl.dart';
import '../../data/models/order_product_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderProductModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details '),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              buildInfoRow('Name', order.productName),
              const SizedBox(height: 16),
              buildInfoRow('Description', order.description),
              const SizedBox(height: 12),
              buildInfoRow('Category', order.productCategory),
              const SizedBox(height: 12),
              buildInfoRow('Brand', order.productBrand),
              const SizedBox(height: 12),
              buildInfoRow('Price', order.price),
              const SizedBox(height: 12),
              buildInfoRow('Address', order.address),
              const SizedBox(height: 12),
              buildInfoRow('Phone', order.phone),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Order Time : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('yyyy-MM-dd – kk:mm')
                          .format(DateTime.parse(order.dateTime)),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              if (order.isShipped == true)
                buildStatusContainer(
                    'Order Shipped Successfully ! 😁', Colors.green)
              else
                buildStatusContainer(
                    'Order has not been shipped! ☹️', Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Row buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label : ',
          style: const TextStyle(
              color: AppStyles.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Align buildStatusContainer(String message, Color color) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                spreadRadius: 8,
                color: Colors.grey.shade200.withOpacity(.7),
                blurRadius: 5,
              )
            ]),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderProductModel order;
  final VoidCallback onCheckboxChanged;

  const OrderCard(
      {super.key, required this.order, required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Description : ',
                  style: TextStyle(
                      color: AppStyles.kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    order.description,
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
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
                    DateFormat('yyyy-MM-dd – kk:mm')
                        .format(DateTime.parse(order.dateTime)),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: order.isShipped,
                    onChanged: (bool? value) {
                      onCheckboxChanged();
                      // You may need to use setState or a similar method to update the UI.
                    },
                  ),
                  Text(
                      order.isShipped
                          ? 'Order Shipped Successfully! '
                          : 'Order has not been shipped! ',
                      style: TextStyle(
                          color: order.isShipped ? Colors.green : Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
