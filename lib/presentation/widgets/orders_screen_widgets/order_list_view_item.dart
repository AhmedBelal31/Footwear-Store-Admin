import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/order_product_model.dart';
import '../../../styles.dart';
import '../../controller/product_cubit.dart';
import '../../screens/order_details_screen.dart';
import '../custom_snack_bar.dart';
import 'order_price.dart';
import 'alert_dialog_delete_order.dart';

class OrdersListViewItem extends StatefulWidget {
  final OrderProductModel order;

  const OrdersListViewItem({
    super.key,
    required this.order,
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
      key: UniqueKey(),
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
                    ClipRRect(
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
                    ),
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
                            BlocBuilder<ProductCubit, ProductStates>(
                              builder: (context, state) {
                                return Checkbox(
                                  value: isChecked,
                                  checkColor: AppStyles.kPrimaryColor,
                                  fillColor:
                                  WidgetStateProperty.all(Colors.grey.shade300
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  overlayColor:
                                      WidgetStateProperty.all(Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                      widget.order.isShipped = isChecked;
                                      BlocProvider.of<ProductCubit>(context)
                                          .updateOrderStatusValue(
                                        orderID: widget.order.orderId,
                                        isShipped: value,
                                      );
                                      if (isChecked) {
                                        CustomSnackBarOverlay.show(
                                          context,
                                          message: 'Order Shipped',
                                          messageDescription:
                                              'The order has been marked as shipped.',
                                          msgColor: Colors.green,
                                        );
                                      } else {
                                        CustomSnackBarOverlay.show(
                                          context,
                                          message: 'Order Not Shipped',
                                          messageDescription:
                                              'The order has been marked as not shipped.',
                                          msgColor: Colors.red,
                                        );
                                      }
                                    });
                                  },
                                );
                              },
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
                  // width: double.infinity,
                  height: .5,
                  // width: 20,
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

///Animated List

// class OrderAnimatedListViewItem extends StatefulWidget {
//   final OrderProductModel order;
//   final Function(OrderProductModel) onUpdate;
//
//   const OrderAnimatedListViewItem(
//       {super.key, required this.order, required this.onUpdate});
//
//   @override
//   State<OrderAnimatedListViewItem> createState() =>
//       _OrderAnimatedListViewItemState();
// }
//
// class _OrderAnimatedListViewItemState extends State<OrderAnimatedListViewItem> {
//   late bool isChecked;
//
//   @override
//   void initState() {
//     super.initState();
//     isChecked = widget.order.isShipped;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: UniqueKey(),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         color: Colors.red,
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: const Icon(Icons.delete, color: Colors.white),
//       ),
//       confirmDismiss: (direction) async {
//         return await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialogDeleteOrder(
//               order: widget.order,
//               onUpdate: widget.onUpdate,
//             );
//           },
//         );
//       },
//       onDismissed: (direction) {
//         // Delete the order
//         widget.onUpdate(widget.order);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Order deleted"),
//           ),
//         );
//       },
//       child: InkWell(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => OrderDetailsScreen(order: widget.order),
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           child: Container(
//             decoration: BoxDecoration(
//               color: isChecked ? Colors.green[300] : Colors.white,
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(12.0),
//                         bottomLeft: Radius.circular(12.0),
//                       ),
//                       child: FancyShimmerImage(
//                         width: 120,
//                         height: 120,
//                         imageUrl: widget.order.productImageUrl,
//                         errorWidget: Image.network(
//                             'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         height: 120,
//                         child: Row(
//                           children: [
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     widget.order.productName,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: isChecked
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   OrderPrice(
//                                     isChecked: isChecked,
//                                     widget: widget,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             BlocBuilder<ProductCubit, ProductStates>(
//                               builder: (context, state) {
//                                 return Checkbox(
//                                   value: isChecked,
//                                   checkColor: AppStyles.kPrimaryColor,
//                                   fillColor:
//                                       WidgetStateProperty.all(Colors.white),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   overlayColor:
//                                       WidgetStateProperty.all(Colors.white),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       isChecked = value!;
//                                       widget.order.isShipped = isChecked;
//                                       widget.onUpdate(widget.order);
//                                       BlocProvider.of<ProductCubit>(context)
//                                           .updateOrderStatusValue(
//                                         orderID: widget.order.orderId,
//                                         isShipped: value,
//                                       );
//                                       if (isChecked) {
//                                         CustomSnackBarOverlay.show(
//                                           context,
//                                           message: 'Order Shipped',
//                                           messageDescription:
//                                               'The order has been marked as shipped.',
//                                           msgColor: Colors.green,
//                                         );
//                                       } else {
//                                         CustomSnackBarOverlay.show(
//                                           context,
//                                           message: 'Order Not Shipped',
//                                           messageDescription:
//                                               'The order has been marked as not shipped.',
//                                           msgColor: Colors.red,
//                                         );
//                                       }
//                                     });
//                                   },
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // const SizedBox(width: 20),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   // width: double.infinity,
//                   height: .5,
//                   // width: 20,
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
