import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/build_awesome_dialog_warning.dart';
import '../../data/models/order_product_model.dart';
import '../../styles.dart';
import '../controller/product_cubit.dart';
import '../screens/order_details_screen.dart';
import 'orders_screen_widgets/Order_price.dart';
import 'orders_screen_widgets/alert_dialog_delete_order.dart';
import 'orders_screen_widgets/order_image.dart';

class CustomOrdersDetailsListViewItem  extends StatelessWidget {
  final OrderProductModel order;
  final void Function(bool?) onChangedOfCheckBox ;

  const CustomOrdersDetailsListViewItem({
    super.key,
    required this.order,
    required this.onChangedOfCheckBox,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: buildDismissibleDecoration(),
      confirmDismiss: (direction) async {
        // return await showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialogDeleteOrder(
        //       order: order,
        //     );
        //   },
        // );
        buildAwesomeDialogWarning(context,
            title: 'Delete Order',
            message:
            'Warning! Deleting this Order is permanent. \n Are you absolutely sure?',
            btnOkOnPress: () {
              BlocProvider.of<ProductCubit>(context).deleteOrder(orderId: order.orderId);

            }, btnCancelOnPress: () {});
      },
      onDismissed: (direction) {
        // Delete the order
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order deleted"),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(order: order),
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
                    OrderImage(productImageUrl: order.productImageUrl),
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
                                    order.productName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  OrderPrice(
                                    isChecked: order.isShipped,
                                    order: order,
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              key: ValueKey(order.orderId),
                              value: order.isShipped,
                              checkColor: AppStyles.kPrimaryColor,
                              fillColor: WidgetStateProperty.all(Colors.grey.shade300),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
                              ),
                              overlayColor:
                              WidgetStateProperty.all(Colors.white),
                              onChanged:onChangedOfCheckBox,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20),
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

  Container buildDismissibleDecoration() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}