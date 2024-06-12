import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import '../../../data/models/order_product_model.dart';
import '../../../styles.dart';
import '../../screens/order_details_screen.dart';
import '../custom_snack_bar.dart';
import 'Order_price.dart';
import 'alert_dialog_delete_order.dart';
import 'shipped_orders_order_image.dart';

class FulfilledOrdersScreen extends StatefulWidget {
  const FulfilledOrdersScreen({super.key});

  @override
  FulfilledOrdersScreenState createState() => FulfilledOrdersScreenState();
}

class FulfilledOrdersScreenState extends State<FulfilledOrdersScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getShippedOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          final List<OrderProductModel> shippedOrders =
              BlocProvider.of<ProductCubit>(context).shippedOrders;
          // if (state is GetShippedOrdersLoadingState)
          //   {
          //   return  const Center(
          //       child: CircularProgressIndicator(
          //         color: AppStyles.kPrimaryColor,
          //       ),
          //     );
          //   }
          // else if (state is GetShippedOrdersSuccessState)
          //   {
          //     return RefreshIndicator(
          //       onRefresh: () async {
          //         BlocProvider.of<ProductCubit>(context).getShippedOrders();
          //         setState(() {});
          //       },
          //       child: ListView.builder(
          //         padding: const EdgeInsets.only(top: 30),
          //         itemBuilder: (context, index) {
          //           return ShippedOrdersListViewItem(
          //             key: ValueKey(shippedOrders[index].orderId),
          //             order: shippedOrders[index],
          //           );
          //         },
          //         itemCount: shippedOrders.length,
          //       ),
          //     );
          //   }
          // else if (state is GetShippedOrdersFailureState)
          //   {
          //     return Text('Error is ${state.error.toString()}');
          //   }
          // else
          //   {
          //     return const SizedBox() ;
          //   }

          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ProductCubit>(context).getShippedOrders();
              setState(() {});
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 30),
              itemBuilder: (context, index) {
                return ShippedOrdersListViewItem(
                  key: ValueKey(shippedOrders[index].orderId),
                  order: shippedOrders[index],
                );
              },
              itemCount: shippedOrders.length,
            ),
          );

        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      // leading: IconButton(
      //   onPressed: (){
      //     BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
      //     Navigator.of(context).pop();
      //   },
      //   icon: const Icon(Icons.arrow_back_ios_new),
      // ),
      title: const Text('Fulfilled Orders'),
      centerTitle: true,
      scrolledUnderElevation: 0,
    );
  }
}

class ShippedOrdersListViewItem extends StatelessWidget {
  final OrderProductModel order;

  const ShippedOrdersListViewItem({
    super.key,
    required this.order,
  });

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
              order: order,
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
                    ShippedOrdersOrderImage(
                        productImageUrl: order.productImageUrl),
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
                              // Ensure unique keys for checkboxes
                              value: order.isShipped,
                              checkColor: AppStyles.kPrimaryColor,
                              fillColor: WidgetStateProperty.all(
                                  Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              overlayColor:
                                  WidgetStateProperty.all(Colors.white),
                              onChanged: (value) {
                                if (value != null) {
                                  BlocProvider.of<ProductCubit>(context)
                                      .updateOrderStatusValue(
                                    orderID: order.orderId,
                                    isShipped: value,
                                  );
                                  BlocProvider.of<ProductCubit>(context)
                                      .getShippedOrders();
                                  if (value) {
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
                                }
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

