import 'package:flutter/material.dart';
import '../widgets/home_screen_widgets/product_list_view_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text("Footwear Admin "),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ProductListViewItem(
            productName: 'Nike a34',
            price: '400',
            onPressed: () {},
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 18,
      ),
    );
  }
}