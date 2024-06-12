import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/order_product_model.dart';
import '../../../styles.dart';
import '../../controller/product_cubit.dart';
import '../../screens/order_details_screen.dart';
import '../custom_snack_bar.dart';
import 'order_image.dart';
import 'order_price.dart';
import 'alert_dialog_delete_order.dart';

class OrdersListViewItem extends StatefulWidget {
  final OrderProductModel order;
  final VoidCallback onStatusChanged;
  const OrdersListViewItem({
    super.key,
    required this.order, required this.onStatusChanged,
  });

  @override
  State<OrdersListViewItem> createState() => OrderListViewItemState();
}

class OrderListViewItemState extends State<OrdersListViewItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.order.isShipped;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.order.orderId), // Use a unique key based on the order ID
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialogDeleteOrder(
              order: widget.order,
            );
          },
        );
      },
      onDismissed: (direction) {
        // Delete the order
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order deleted"),
          ),
        );
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(order: widget.order),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    OrderImage(widget: widget),
                    Expanded(
                      child: SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.productName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  OrderPrice(
                                    isChecked: isChecked,
                                    order: widget.order,
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              value: isChecked,
                              checkColor: AppStyles.kPrimaryColor,
                              fillColor: WidgetStateProperty.all(Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              overlayColor: WidgetStateProperty.all(Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  widget.order.isShipped = isChecked;
                                  BlocProvider.of<ProductCubit>(context).updateOrderStatusValue(
                                    orderID: widget.order.orderId,
                                    isShipped: value,
                                  );
                                  BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
                                  if (isChecked) {
                                    CustomSnackBarOverlay.show(
                                      context,
                                      message: 'Order Shipped',
                                      messageDescription: 'The order has been marked as shipped.',
                                      msgColor: Colors.green,
                                    );
                                  } else {
                                    CustomSnackBarOverlay.show(
                                      context,
                                      message: 'Order Not Shipped',
                                      messageDescription: 'The order has been marked as not shipped.',
                                      msgColor: Colors.red,
                                    );
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: .5,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



