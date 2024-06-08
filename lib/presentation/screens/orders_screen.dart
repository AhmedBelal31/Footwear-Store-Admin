// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
// import 'package:footwear_store_admin/presentation/screens/order_details_screen.dart';
// import 'package:footwear_store_admin/presentation/widgets/custom_snack_bar.dart';
// import 'package:footwear_store_admin/styles.dart';
// import '../../data/models/order_product_model.dart';
//
// class OrdersScreen extends StatelessWidget {
//   final List<OrderProductModel> orders;
//
//   const OrdersScreen({super.key, required this.orders});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders'),
//         centerTitle: true,
//         scrolledUnderElevation: 0,
//       ),
//       body: BlocBuilder<ProductCubit, ProductStates>(
//         builder: (context, state) {
//           return RefreshIndicator(
//             onRefresh: () async {
//               BlocProvider.of<ProductCubit>(context).getOrders();
//             },
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: ConstrainedBox(
//                 constraints:
//                 BoxConstraints(minHeight: MediaQuery.of(context).size.height),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView.separated(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return ProductOrderListViewItem(
//                         order: orders[index],
//                       );
//                     },
//                     separatorBuilder: (context, index) =>
//                     const Divider(
//                       thickness: 1,
//                       indent: 12,
//                       endIndent: 12,
//                     ),
//                     itemCount: orders.length,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ProductOrderListViewItem extends StatefulWidget {
//   final OrderProductModel order;
//
//   const ProductOrderListViewItem({super.key, required this.order});
//
//   @override
//   State<ProductOrderListViewItem> createState() =>
//       _ProductOrderListViewItemState();
// }
//
// class _ProductOrderListViewItemState extends State<ProductOrderListViewItem> {
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
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) =>
//               OrderDetailsScreen(
//                 order: widget.order,
//               ),
//         ));
//       },
//       child: Row(
//         children: [
//           Image(
//             height: 120,
//             width: 120,
//             image: NetworkImage(widget.order.productImageUrl),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: isChecked ? Colors.green : Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.order.productName,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: isChecked ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Price: ',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: isChecked ? Colors.white : Colors.black,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: '${widget.order.price}\$',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   color: AppStyles.kPrimaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   BlocBuilder<ProductCubit, ProductStates>(
//                     builder: (context, state) {
//                       return Checkbox(
//                         value: isChecked,
//                         checkColor: AppStyles.kPrimaryColor,
//                         fillColor: MaterialStateProperty.all(Colors.white),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         overlayColor: MaterialStateProperty.all(Colors.white),
//                         onChanged: (value) {
//                           setState(() {
//                             isChecked = value!;
//                             widget.order.isShipped = isChecked;
//                             BlocProvider.of<ProductCubit>(context)
//                                 .updateOrderStatusValue(
//                               orderID: widget.order.orderId,
//                               isShipped: value,
//                             );
//                             if (isChecked) {
//                               CustomSnackBarOverlay.show(
//                                 context,
//                                 message: 'Order Shipped',
//                                 messageDescription:
//                                 'The order has been marked as shipped.',
//                                 msgColor: Colors.green,
//                               );
//                             } else {
//                               CustomSnackBarOverlay.show(
//                                 context,
//                                 message: 'Order Not Shipped',
//                                 messageDescription:
//                                 'The order has been marked as not shipped.',
//                                 msgColor: Colors.red,
//                               );
//                             }
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//         ],
//       ),
//     );
//   }
// }

//Worked WithOut Animation

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
// import 'package:footwear_store_admin/presentation/screens/order_details_screen.dart';
// import 'package:footwear_store_admin/presentation/widgets/custom_snack_bar.dart';
// import 'package:footwear_store_admin/styles.dart';
// import '../../data/models/order_product_model.dart';
//
// class OrdersScreen extends StatefulWidget {
//   final List<OrderProductModel> orders;
//
//   const OrdersScreen({super.key, required this.orders});
//
//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }
//
// class _OrdersScreenState extends State<OrdersScreen> {
//   late List<OrderProductModel> orders;
//
//   @override
//   void initState() {
//     super.initState();
//     orders = List.from(widget.orders);
//   }
//
//   void _updateOrder(OrderProductModel updatedOrder) {
//     setState(() {
//       // Update the order in the list
//       orders = orders.map((order) {
//         return order.orderId == updatedOrder.orderId ? updatedOrder : order;
//       }).toList();
//
//       // Sort the list with unshipped orders first
//       orders.sort((a, b) => a.isShipped ? 1 : -1);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders'),
//         centerTitle: true,
//         scrolledUnderElevation: 0,
//       ),
//       body: BlocBuilder<ProductCubit, ProductStates>(
//         builder: (context, state) {
//           return RefreshIndicator(
//             onRefresh: () async {
//               BlocProvider.of<ProductCubit>(context).getOrders();
//             },
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView.separated(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return ProductOrderListViewItem(
//                         key: ValueKey(orders[index].orderId),
//                         order: orders[index],
//                         onUpdate: _updateOrder,
//                       );
//                     },
//                     separatorBuilder: (context, index) => const Divider(
//                       thickness: 1,
//                       indent: 12,
//                       endIndent: 12,
//                     ),
//                     itemCount: orders.length,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ProductOrderListViewItem extends StatefulWidget {
//   final OrderProductModel order;
//   final Function(OrderProductModel) onUpdate;
//
//   const ProductOrderListViewItem({super.key, required this.order, required this.onUpdate});
//
//   @override
//   State<ProductOrderListViewItem> createState() => _ProductOrderListViewItemState();
// }
//
// class _ProductOrderListViewItemState extends State<ProductOrderListViewItem> {
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
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => OrderDetailsScreen(order: widget.order),
//         ));
//       },
//       child: Row(
//         children: [
//           Image(
//             height: 120,
//             width: 120,
//             image: NetworkImage(widget.order.productImageUrl),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: isChecked ? Colors.green : Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.order.productName,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: isChecked ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Price: ',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: isChecked ? Colors.white : Colors.black,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: '${widget.order.price}\$',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   color: AppStyles.kPrimaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   BlocBuilder<ProductCubit, ProductStates>(
//                     builder: (context, state) {
//                       return Checkbox(
//                         value: isChecked,
//                         checkColor: AppStyles.kPrimaryColor,
//                         fillColor: WidgetStateProperty.all(Colors.white),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         overlayColor: WidgetStateProperty.all(Colors.white),
//                         onChanged: (value) {
//                           setState(() {
//                             isChecked = value!;
//                             widget.order.isShipped = isChecked;
//                             widget.onUpdate(widget.order);
//                             BlocProvider.of<ProductCubit>(context)
//                                 .updateOrderStatusValue(
//                               orderID: widget.order.orderId,
//                               isShipped: value,
//                             );
//                             if (isChecked) {
//                               CustomSnackBarOverlay.show(
//                                 context,
//                                 message: 'Order Shipped',
//                                 messageDescription: 'The order has been marked as shipped.',
//                                 msgColor: Colors.green,
//                               );
//                             } else {
//                               CustomSnackBarOverlay.show(
//                                 context,
//                                 message: 'Order Not Shipped',
//                                 messageDescription: 'The order has been marked as not shipped.',
//                                 msgColor: Colors.red,
//                               );
//                             }
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
// import 'package:footwear_store_admin/presentation/screens/order_details_screen.dart';
// import 'package:footwear_store_admin/presentation/widgets/custom_snack_bar.dart';
// import 'package:footwear_store_admin/styles.dart';
// import '../../data/models/order_product_model.dart';
//
// class OrdersScreen extends StatefulWidget {
//   final List<OrderProductModel> orders;
//
//   const OrdersScreen({super.key, required this.orders});
//
//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }
//
// class _OrdersScreenState extends State<OrdersScreen> {
//   late List<OrderProductModel> orders;
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//
//   @override
//   void initState() {
//     super.initState();
//     orders = List.from(widget.orders);
//     _sortOrders();
//   }
//
//   void _sortOrders() {
//     orders.sort((a, b) => a.isShipped ? 1 : -1);
//   }
//
//   void _updateOrder(OrderProductModel updatedOrder) {
//     setState(() {
//       // Remove the order from its current position
//       int index = orders.indexWhere((order) => order.orderId == updatedOrder.orderId);
//       if (index != -1) {
//         _listKey.currentState!.removeItem(
//           index,
//               (context, animation) => _buildRemovedItem(orders[index], animation),
//           duration: const Duration(milliseconds: 300),
//         );
//         orders.removeAt(index);
//       }
//
//       // Add the order to the end of the list if shipped, otherwise to the beginning
//       if (updatedOrder.isShipped) {
//         orders.add(updatedOrder);
//         _listKey.currentState!.insertItem(orders.length - 1, duration: const Duration(milliseconds: 300));
//       } else {
//         orders.insert(0, updatedOrder);
//         _listKey.currentState!.insertItem(0, duration: const Duration(milliseconds: 300));
//       }
//
//       // Ensure the list remains sorted correctly
//       _sortOrders();
//     });
//   }
//
//   Widget _buildRemovedItem(OrderProductModel order, Animation<double> animation) {
//     return SizeTransition(
//       sizeFactor: animation,
//       child: ProductOrderListViewItem(
//         key: ValueKey(order.orderId),
//         order: order,
//         onUpdate: _updateOrder,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders'),
//         centerTitle: true,
//         scrolledUnderElevation: 0,
//       ),
//       body: BlocBuilder<ProductCubit, ProductStates>(
//         builder: (context, state) {
//           return RefreshIndicator(
//             onRefresh: () async {
//               BlocProvider.of<ProductCubit>(context).getOrders();
//               setState(() {
//                 orders = List.from(widget.orders);
//                 _sortOrders();
//               });
//             },
//             child: AnimatedList(
//               key: _listKey,
//               initialItemCount: orders.length,
//               itemBuilder: (context, index, animation) {
//                 return SizeTransition(
//                   sizeFactor: animation,
//                   child: ProductOrderListViewItem(
//                     key: ValueKey(orders[index].orderId),
//                     order: orders[index],
//                     onUpdate: _updateOrder,
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ProductOrderListViewItem extends StatefulWidget {
//   final OrderProductModel order;
//   final Function(OrderProductModel) onUpdate;
//
//   const ProductOrderListViewItem({super.key, required this.order, required this.onUpdate});
//
//   @override
//   State<ProductOrderListViewItem> createState() => _ProductOrderListViewItemState();
// }
//
// class _ProductOrderListViewItemState extends State<ProductOrderListViewItem> {
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
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => OrderDetailsScreen(order: widget.order),
//         ));
//       },
//       child: Row(
//         children: [
//           Image(
//             height: 120,
//             width: 120,
//             image: NetworkImage(widget.order.productImageUrl),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: isChecked ? Colors.green : Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.order.productName,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: isChecked ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Price: ',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: isChecked ? Colors.white : Colors.black,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: '${widget.order.price}\$',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   color: AppStyles.kPrimaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   BlocBuilder<ProductCubit, ProductStates>(
//                     builder: (context, state) {
//                       return Checkbox(
//                         value: isChecked,
//                         checkColor: AppStyles.kPrimaryColor,
//                         fillColor: WidgetStateProperty.all(Colors.white),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         overlayColor: WidgetStateProperty.all(Colors.white),
//                         onChanged: (value) {
//                           setState(() {
//                             isChecked = value!;
//                             widget.order.isShipped = isChecked;
//                             widget.onUpdate(widget.order);
//                             BlocProvider.of<ProductCubit>(context)
//                                 .updateOrderStatusValue(
//                               orderID: widget.order.orderId,
//                               isShipped: value,
//                             );
//                             if (isChecked) {
//                               CustomSnackBarOverlay.show(
//                                 context,
//                                 message: 'Order Shipped',
//                                 messageDescription: 'The order has been marked as shipped.',
//                                 msgColor: Colors.green,
//                               );
//                             } else {
//                               CustomSnackBarOverlay.show(
//                                 context,
//                                 message: 'Order Not Shipped',
//                                 messageDescription: 'The order has been marked as not shipped.',
//                                 msgColor: Colors.red,
//                               );
//                             }
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//         ],
//       ),
//     );
//   }
// }

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import 'package:footwear_store_admin/presentation/screens/order_details_screen.dart';
import 'package:footwear_store_admin/presentation/widgets/custom_snack_bar.dart';
import 'package:footwear_store_admin/styles.dart';
import '../../data/models/order_product_model.dart';

class OrdersScreen extends StatefulWidget {
  final List<OrderProductModel> orders;

  const OrdersScreen({super.key, required this.orders});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late List<OrderProductModel> orders;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    orders = List.from(widget.orders);
    _sortOrders();
  }

  void _sortOrders() {
    orders.sort((a, b) => a.isShipped ? 1 : -1);
  }

  void _updateOrder(OrderProductModel updatedOrder) {
    setState(() {
      // Remove the order from its current position
      int index =
          orders.indexWhere((order) => order.orderId == updatedOrder.orderId);
      if (index != -1) {
        _listKey.currentState!.removeItem(
          index,
          (context, animation) => _buildRemovedItem(orders[index], animation),
          duration: const Duration(milliseconds: 300),
        );
        orders.removeAt(index);
      }

      // Add the order to the end of the list if shipped, otherwise to the beginning
      if (updatedOrder.isShipped) {
        orders.add(updatedOrder);
        _listKey.currentState!.insertItem(orders.length - 1,
            duration: const Duration(milliseconds: 300));
      } else {
        orders.insert(0, updatedOrder);
        _listKey.currentState!
            .insertItem(0, duration: const Duration(milliseconds: 300));
      }

      // Ensure the list remains sorted correctly
      _sortOrders();
    });
  }

  Widget _buildRemovedItem(
      OrderProductModel order, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ProductOrderListViewItem(
        key: ValueKey(order.orderId),
        order: order,
        onUpdate: _updateOrder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ProductCubit>(context).getOrders();
              setState(() {
                orders = List.from(widget.orders);
                _sortOrders();
              });
            },
            child: AnimatedList(
              physics: const BouncingScrollPhysics(),
              key: _listKey,
              initialItemCount: orders.length,
              itemBuilder: (context, index, animation) {
                return _buildListItem(orders[index], animation);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildListItem(OrderProductModel order, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: ProductOrderListViewItem(
        key: ValueKey(order.orderId),
        order: order,
        onUpdate: _updateOrder,
      ),
    );
  }
}
class ProductOrderListViewItem extends StatefulWidget {
  final OrderProductModel order;
  final Function(OrderProductModel) onUpdate;

  const ProductOrderListViewItem({Key? key, required this.order, required this.onUpdate}) : super(key: key);

  @override
  State<ProductOrderListViewItem> createState() => _ProductOrderListViewItemState();
}

class _ProductOrderListViewItemState extends State<ProductOrderListViewItem> {
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
              onUpdate: widget.onUpdate,
            );
          },
        );
      },
      onDismissed: (direction) {
        // Delete the order
        widget.onUpdate(widget.order);
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
              color: isChecked ? Colors.green[300] : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
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
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isChecked ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              OrderPrice(isChecked: isChecked, widget: widget),
                            ],
                          ),
                        ),
                        BlocBuilder<ProductCubit, ProductStates>(
                          builder: (context, state) {
                            return Checkbox(
                              value: isChecked,
                              checkColor: AppStyles.kPrimaryColor,
                              fillColor: WidgetStateProperty.all(Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              overlayColor: WidgetStateProperty.all(Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  widget.order.isShipped = isChecked;
                                  widget.onUpdate(widget.order);
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
          ),
        ),
      ),
    );
  }
}

class AlertDialogDeleteOrder extends StatefulWidget {
  final OrderProductModel order;
  final Function(OrderProductModel) onUpdate;

  const AlertDialogDeleteOrder({super.key, required this.order, required this.onUpdate});

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
            ///Delete Order ..
            Navigator.of(context).pop(true); // Return true to confirm dismissal
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}


















// class ProductOrderListViewItem extends StatefulWidget {
//   final OrderProductModel order;
//   final Function(OrderProductModel) onUpdate;
//
//   const ProductOrderListViewItem(
//       {super.key, required this.order, required this.onUpdate});
//
//   @override
//   State<ProductOrderListViewItem> createState() =>
//       _ProductOrderListViewItemState();
// }
//
// class _ProductOrderListViewItemState extends State<ProductOrderListViewItem> {
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
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => OrderDetailsScreen(order: widget.order),
//         ));
//
//       },
//       onDoubleTap:(){
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//            return AlertDialog(
//               title: const Text('Delete Order'),
//               content: const Text('Are you sure you want to delete this order ?'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Code to delete the order goes here
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Delete'),
//                 ),
//               ],
//             );
//
//           },
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal:8 , vertical: 4),
//         child: Container(
//           decoration: BoxDecoration(
//             color: isChecked ? Colors.green[300] : Colors.white,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12.0),
//                   bottomLeft: Radius.circular(12.0),
//                 ),
//                 child: FancyShimmerImage(
//                   width: 120,
//                   height: 120,
//                   imageUrl: widget.order.productImageUrl,
//                   errorWidget: Image.network(
//                       'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
//                 ),
//               ),
//               Expanded(
//                 child: SizedBox(
//                   height: 120,
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.order.productName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: isChecked ? Colors.white : Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             OrderPrice(isChecked: isChecked, widget: widget),
//                           ],
//                         ),
//                       ),
//                       BlocBuilder<ProductCubit, ProductStates>(
//                         builder: (context, state) {
//                           return Checkbox(
//                             value: isChecked,
//                             checkColor: AppStyles.kPrimaryColor,
//                             fillColor: WidgetStateProperty.all(Colors.white),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             overlayColor: WidgetStateProperty.all(Colors.white),
//                             onChanged: (value) {
//                               setState(() {
//                                 isChecked = value!;
//                                 widget.order.isShipped = isChecked;
//                                 widget.onUpdate(widget.order);
//                                 BlocProvider.of<ProductCubit>(context)
//                                     .updateOrderStatusValue(
//                                   orderID: widget.order.orderId,
//                                   isShipped: value,
//                                 );
//                                 if (isChecked) {
//                                   CustomSnackBarOverlay.show(
//                                     context,
//                                     message: 'Order Shipped',
//                                     messageDescription:
//                                         'The order has been marked as shipped.',
//                                     msgColor: Colors.green,
//                                   );
//                                 } else {
//                                   CustomSnackBarOverlay.show(
//                                     context,
//                                     message: 'Order Not Shipped',
//                                     messageDescription:
//                                         'The order has been marked as not shipped.',
//                                     msgColor: Colors.red,
//                                   );
//                                 }
//                               });
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // const SizedBox(width: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class OrderPrice extends StatelessWidget {
  const OrderPrice({
    super.key,
    required this.isChecked,
    required this.widget,
  });

  final bool isChecked;
  final ProductOrderListViewItem widget;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Price: ',
            style: TextStyle(
              fontSize: 18,
              color:
                  isChecked ? Colors.white : Colors.black,
            ),
          ),
          TextSpan(
            text: '${widget.order.price}\$',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppStyles.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
