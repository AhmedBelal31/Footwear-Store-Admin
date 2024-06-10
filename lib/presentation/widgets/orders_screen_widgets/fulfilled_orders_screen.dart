import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import '../../../data/models/order_product_model.dart';
import '../../../styles.dart';
import '../../screens/order_details_screen.dart';
import '../custom_snack_bar.dart';
import 'Order_price.dart';
import 'alert_dialog_delete_order.dart';
import 'order_list_view_item.dart';

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
          final List<OrderProductModel> shippedOrders =  BlocProvider.of<ProductCubit>(context).shippedOrders;
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ProductCubit>(context).getShippedOrders();
              setState(() {});
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return OrdersListViewItem(
                      order: shippedOrders[index],
                    );
                  },
                  itemCount: shippedOrders.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Fulfilled Orders'),
      centerTitle: true,
      scrolledUnderElevation: 0,
    );
  }
}






class ShippedOrdersListViewItem extends StatefulWidget {
  final OrderProductModel order;

  const ShippedOrdersListViewItem({
    super.key,
    required this.order,
  });

  @override
  State<ShippedOrdersListViewItem> createState() => ShippedOrdersOrderListViewItemState();
}

class ShippedOrdersOrderListViewItemState extends State<ShippedOrdersListViewItem> {
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
                    ShippedOrdersOrderImage(productImageUrl: widget.order.productImageUrl),
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
                                      BlocProvider.of<ProductCubit>(context).getShippedOrders();
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

class ShippedOrdersOrderImage extends StatelessWidget {
  const ShippedOrdersOrderImage({
    super.key,
    required this.productImageUrl,
  });

  final String productImageUrl;

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
        imageUrl: productImageUrl,
        errorWidget: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
      ),
    );
  }
}