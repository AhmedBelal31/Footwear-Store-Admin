import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'fulfilled_orders_screen.dart';

class FulfilledOrders extends StatelessWidget {
  const FulfilledOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FulfilledOrdersScreen(),
          ),
        );
      },
      child: const FulfilledOrdersAnimatedText(),
    );
  }
}

class FulfilledOrdersAnimatedText extends StatelessWidget {
  const FulfilledOrdersAnimatedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: buildBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          child: buildAnimatedTextKit(context),
        ),
      ),
    );
  }

  AnimatedTextKit buildAnimatedTextKit(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText('Fulfilled Orders'),
      ],
      isRepeatingAnimation: true,
      repeatForever: true,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FulfilledOrdersScreen(),
          ),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(12.0),
    );
  }
}
