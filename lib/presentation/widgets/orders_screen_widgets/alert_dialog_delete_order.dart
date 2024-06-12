import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import '../../../data/models/order_product_model.dart';

class AlertDialogDeleteOrder extends StatefulWidget {
  final OrderProductModel order;

  const AlertDialogDeleteOrder({
    super.key,
    required this.order,
  });

  @override
  AlertDialogDeleteOrderState createState() => AlertDialogDeleteOrderState();
}

class AlertDialogDeleteOrderState extends State<AlertDialogDeleteOrder> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: const Text('Delete Order'),
      content: const Text('Are you sure you want to delete this order?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Return false to cancel dismissal
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<ProductCubit>(context).deleteOrder(orderId: widget.order.orderId);
            ///Delete Order ..
            Navigator.of(context).pop(true); // Return true to confirm dismissal
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}




