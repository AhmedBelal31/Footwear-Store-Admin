import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import 'package:footwear_store_admin/presentation/widgets/custom_orders_details_list_view_item.dart';
import 'package:footwear_store_admin/styles.dart';
import '../../data/models/order_product_model.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/no_data_message.dart';

class ShippedOrdersScreen extends StatefulWidget {
  const ShippedOrdersScreen({super.key});

  @override
  ShippedOrdersScreenState createState() => ShippedOrdersScreenState();
}

class ShippedOrdersScreenState extends State<ShippedOrdersScreen> {
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
          if (shippedOrders.isEmpty && state is! GetShippedOrdersLoadingState) {
            return const NoDataMessage(
                message: "No orders available at the moment.");
          } else if (state is GetShippedOrdersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppStyles.kPrimaryColor,
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ProductCubit>(context).getShippedOrders();
                setState(() {});
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 30),
                itemBuilder: (context, index) {
                  return CustomOrdersDetailsListViewItem(
                      order: shippedOrders[index],
                      onChangedOfCheckBox: (value) {
                        if (value != null) {
                          BlocProvider.of<ProductCubit>(context)
                              .updateOrderStatusValue(
                            orderID: shippedOrders[index].orderId,
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
                      });
                },
                itemCount: shippedOrders.length,
              ),
            );
          }
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          BlocProvider.of<ProductCubit>(context).getUnShippedOrders();
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text('Fulfilled Orders'),
      centerTitle: true,
      scrolledUnderElevation: 0,
    );
  }
}
