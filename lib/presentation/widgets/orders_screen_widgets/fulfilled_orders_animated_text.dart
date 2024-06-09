import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../../data/models/order_product_model.dart';
import 'fulfilled_orders_screen.dart';

class FulfilledOrders extends StatelessWidget {
  final List<OrderProductModel> orders;

  const FulfilledOrders({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FulfilledOrdersScreen(orders: orders),
          ),
        );
      },
      child: FulfilledOrdersAnimatedText(orders: orders),
    );
  }
}

class FulfilledOrdersAnimatedText extends StatelessWidget {
  const FulfilledOrdersAnimatedText({
    super.key,
    required this.orders,
  });

  final List<OrderProductModel> orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Fulfilled Orders'),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FulfilledOrdersScreen(orders: orders),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
