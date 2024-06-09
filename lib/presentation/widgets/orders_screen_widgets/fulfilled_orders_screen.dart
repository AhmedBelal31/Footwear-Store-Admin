import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import '../../../data/models/order_product_model.dart';
import 'order_list_view_item.dart';


class FulfilledOrdersScreen extends StatefulWidget {
  final List<OrderProductModel> orders;

  const FulfilledOrdersScreen({super.key, required this.orders});

  @override
  FulfilledOrdersScreenState createState() => FulfilledOrdersScreenState();
}

class FulfilledOrdersScreenState extends State<FulfilledOrdersScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ProductCubit>(context).getOrders();
              setState(() {});
            },
            child :Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return OrdersListViewItem(
                    order: widget.orders[index],

                  );
                },
                itemCount: widget.orders.length,
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

