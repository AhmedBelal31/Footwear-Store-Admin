import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import 'package:footwear_store_admin/presentation/screens/add_product_screen.dart';
import 'package:footwear_store_admin/styles.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/home_screen_widgets/product_list_view_item.dart';
import 'orders_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {
        if (state is DeleteProductSuccessState) {
          CustomSnackBarOverlay.show(
            context,
            message: 'Deleted',
            messageDescription: 'Product Deleted !',
            msgColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<ProductCubit>(context);
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            title: const Text("Footwear Products"),
            centerTitle: true,
            // actions: [
            //   if (state is GetProductLoadingState)
            //     const CircularProgressIndicator(color: AppStyles.kPrimaryColor),
            //   if (state is! GetProductLoadingState)
            //     IconButton(
            //       onPressed: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (context) => OrdersScreen(
            //               orders: BlocProvider.of<ProductCubit>(context).orders,
            //             ),
            //           ),
            //         );
            //       },
            //       icon: const Icon(Icons.menu),
            //     ),
            //   const SizedBox(width: 10),
            // ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProductScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: Builder(
            builder: (context) {
              if (cubit.products.isEmpty && state is! GetProductLoadingState) {
                return const Center(child: Text('There Is No Products '));
              } else {
                if (state is GetProductFailureState) {
                  return Text('Error: ${state.error}');
                } else if (state is DeleteProductFailureState) {
                  return Text('Error: ${state.error}');
                } else {
                  return Column(
                    children: [
                      if (state is GetProductLoadingState)
                        const CircularProgressIndicator(color: Colors.white),
                      if (state is! GetProductLoadingState)
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OrdersScreen(
                                  orders: BlocProvider.of<ProductCubit>(context)
                                      .orders,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppStyles.kPrimaryColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const ListTile(
                              title: Text(
                                'Orders ',
                                style: TextStyle(color: Colors.white , fontSize: 18),
                              ),
                              trailing: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      if (state is DeleteProductLoadingState)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: LinearProgressIndicator(),
                        ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            cubit.fetchAllProducts();
                          },
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ProductListViewItem(
                                product: cubit.products[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemCount: cubit.products.length,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        );
      },
    );
  }
}
