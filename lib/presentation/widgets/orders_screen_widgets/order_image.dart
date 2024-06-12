import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'order_list_view_item.dart';

class OrderImage extends StatelessWidget {
  const OrderImage({
    super.key,
    required this.widget,
  });

  final OrdersListViewItem widget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        bottomLeft: Radius.circular(12.0),
      ),
      child: FancyShimmerImage(
        width: 120,
        height: 120,
        imageUrl: widget.order.productImageUrl,
        errorWidget: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
      ),
    );
  }
}
