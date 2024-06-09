import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import 'package:footwear_store_admin/presentation/widgets/custom_snack_bar.dart';
import 'package:footwear_store_admin/styles.dart';
import '../../const.dart';
import '../widgets/home_screen_widgets/add_product_card.dart';
import '../widgets/home_screen_widgets/home_products_grid_view.dart';
import '../widgets/home_screen_widgets/order_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {
          if (state is DeleteProductSuccessState) {
            CustomSnackBarOverlay.show(context,
                message: 'Deleted ',
                messageDescription: 'Product Deleted Successfully',
                msgColor: Colors.red);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<ProductCubit>(context);
          return RefreshIndicator(
            onRefresh: () async {
              cubit.fetchAllProducts();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(child: OrderCard()),
                        SizedBox(width: 20),
                        Expanded(child: AddProductCard()),
                        SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (state is GetOrdersLoadingState)
                      const CircularProgressIndicator(color: AppStyles.kPrimaryColor),
                    if (state is GetProductLoadingState && products.isEmpty)
                      const CircularProgressIndicator(color: AppStyles.kPrimaryColor),
                    HomeProductsGridView(products: products),
                  ],
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
      title: const Text("Footwear Products"),
      centerTitle: true,
      scrolledUnderElevation: 0,
    );
  }
}
