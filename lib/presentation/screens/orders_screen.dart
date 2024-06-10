import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import '../../data/models/order_product_model.dart';
import '../widgets/orders_screen_widgets/fulfilled_orders_animated_text.dart';
import '../widgets/orders_screen_widgets/order_list_view_item.dart';

class OrdersScreen extends StatefulWidget {


  const OrdersScreen({super.key,});

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          List<OrderProductModel> unShippedOrders =  BlocProvider.of<ProductCubit>(context).unShippedOrders;
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const FulfilledOrders(),
                  const SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OrdersListViewItem(
                        order:unShippedOrders[index],
                      );
                    },
                    itemCount:unShippedOrders.length,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Orders'),
      centerTitle: true,
      scrolledUnderElevation: 0,
    );
  }
}

///Animated Orders List

// class OrdersScreen extends StatefulWidget {
//   final List<OrderProductModel> orders;
//
//   const OrdersScreen({super.key, required this.orders});
//
//   @override
//   OrdersScreenState createState() => OrdersScreenState();
// }
//
// class OrdersScreenState extends State<OrdersScreen> {
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
//         _listKey.currentState!.insertItem(orders.length - 1,
//             duration: const Duration(milliseconds: 300));
//       } else {
//         orders.insert(0, updatedOrder);
//         _listKey.currentState!
//             .insertItem(0, duration: const Duration(milliseconds: 300));
//       }
//
//       // Ensure the list remains sorted correctly
//       _sortOrders();
//     });
//   }
//
//   Widget _buildRemovedItem(
//       OrderProductModel order, Animation<double> animation) {
//     return SizeTransition(
//       sizeFactor: animation,
//       child: OrderListViewItem(
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
//       appBar: buildAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             const FulfilledOrdersAnimatedText(),
//             const SizedBox(height: 30),
//             AnimdatedOrdersList(
//               key: _listKey,
//               orders: orders,
//               onUpdate: _updateOrder,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       title: const Text('Orders'),
//       centerTitle: true,
//       scrolledUnderElevation: 0,
//     );
//   }
// }
//
//
//
//
//
//
//
// class AnimdatedOrdersList extends StatelessWidget {
//   final List<OrderProductModel> orders;
//   final Function(OrderProductModel) onUpdate;
//
//   const AnimdatedOrdersList({
//     super.key,
//     required this.orders,
//     required this.onUpdate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedList(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       key: key,
//       initialItemCount: orders.length,
//       itemBuilder: (context, index, animation) {
//         return _buildListItem(
//           context,
//           orders[index],
//           animation,
//         );
//       },
//     );
//   }
//
//   Widget _buildListItem(
//       BuildContext context,
//       OrderProductModel order,
//       Animation<double> animation,
//       ) {
//     return SlideTransition(
//       position: animation.drive(
//         Tween<Offset>(
//           begin: const Offset(-1, 0),
//           end: Offset.zero,
//         ).chain(CurveTween(curve: Curves.easeInOut)),
//       ),
//       child: OrderListViewItem(
//         key: ValueKey(order.orderId),
//         order: order,
//         onUpdate: onUpdate,
//       ),
//     );
//   }
// }
