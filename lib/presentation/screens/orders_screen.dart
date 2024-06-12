// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
// import '../../data/models/order_product_model.dart';
// import '../widgets/orders_screen_widgets/fulfilled_orders_animated_text.dart';
// import '../widgets/orders_screen_widgets/order_list_view_item.dart';
//
//
// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});
//
//   @override
//   OrdersScreenState createState() => OrdersScreenState();
// }
//
// class OrdersScreenState extends State<OrdersScreen> {
//   @override
//   void initState() {
//     BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
//     super.initState();
//   }
//
//   Future<void> _refreshOrders() async {
//     BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: BlocBuilder<ProductCubit, ProductStates>(
//         builder: (context, state) {
//           List<OrderProductModel> unShippedOrders =
//               BlocProvider.of<ProductCubit>(context).unShippedOrders;
//           return RefreshIndicator(
//             onRefresh: _refreshOrders,
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: MediaQuery.sizeOf(context).height,
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     const FulfilledOrders(),
//                     const SizedBox(height: 30),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return OrdersListViewItem(
//                           key: ValueKey(unShippedOrders[index].orderId),
//                           // Use a unique key based on the order ID
//                           order: unShippedOrders[index],
//                           onStatusChanged: _refreshOrders,
//                         );
//                       },
//                       itemCount: unShippedOrders.length,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import '../../data/models/order_product_model.dart';
import '../widgets/orders_screen_widgets/fulfilled_orders_animated_text.dart';
import '../widgets/orders_screen_widgets/order_list_view_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
    super.initState();
  }

  Future<void> _refreshOrders() async {
    BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          List<OrderProductModel> unShippedOrders =
              BlocProvider.of<ProductCubit>(context).unShippedOrders;
          return RefreshIndicator(
            onRefresh: _refreshOrders,
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: FulfilledOrders(),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return OrdersListViewItem(
                      key: UniqueKey(),
                      order: unShippedOrders[index],
                      onStatusChanged: _refreshOrders,
                    );
                  },
                  itemCount: unShippedOrders.length,
                )
              ],
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
