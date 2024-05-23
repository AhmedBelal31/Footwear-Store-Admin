import 'package:flutter/material.dart';

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
        onPressed: ()
        {
          print("Done ") ;
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ProductListViewItem(
            productName: 'Nike a34',
            price: '400',
            onPressed: () {
              print('hello ! , Num : ${index + 1}');
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        itemCount: 18,
      ),
    );
  }
}

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
