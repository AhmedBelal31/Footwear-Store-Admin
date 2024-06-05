import 'package:flutter/material.dart';
import 'package:footwear_store_admin/styles.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
                  image: NetworkImage(
                      'https://st2.depositphotos.com/4307429/7393/i/950/depositphotos_73934475-stock-photo-sneaker-on-white-background.jpg'),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Name : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      'New Balance 574',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                    child: Text(
                      'NStand out with the bold and vibrant Puma RS-X³ Puzzle, perfect for making a statement on and off the track.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Category  : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sandal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Brand  : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Nike',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Price  : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' 122\$',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Address : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      'Alex',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Phone : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      ' 01155137512',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Order Time   : ',
                    style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse('2024-06-03T16:47:29.083411')),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
