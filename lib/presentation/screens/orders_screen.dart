import 'package:flutter/material.dart';
import 'package:footwear_store_admin/presentation/screens/order_details_screen.dart';
import 'package:footwear_store_admin/styles.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
            return const ProductOrderListViewItem();
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
            indent: 12,
            endIndent: 12,
          ),
          itemCount: 12,
        ),
      ),
    );
  }
}

class ProductOrderListViewItem extends StatelessWidget {
  const ProductOrderListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const OrderDetailsScreen(),
        ));
      },
      child: Row(
        children: [
          const Image(
            height: 120,
            width: 120,
            image: NetworkImage(
                'https://st2.depositphotos.com/4307429/7393/i/950/depositphotos_73934475-stock-photo-sneaker-on-white-background.jpg'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Balance 574',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Price : ',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const TextSpan(
                  text: '120\$',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppStyles.kPrimaryColor,
                  ),
                ),
              ])),
            ],
          )
        ],
      ),
    );
  }
}
