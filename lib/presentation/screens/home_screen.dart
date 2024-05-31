import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import 'package:footwear_store_admin/presentation/screens/add_product_screen.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/home_screen_widgets/product_list_view_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text("Footwear Admin"),
        centerTitle: true,
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
      body: BlocProvider(
        create: (context) => ProductCubit()..fetchAllProducts(),
        child: BlocConsumer<ProductCubit, ProductStates>(
          listener: (context, state) {
            if(state is DeleteProductSuccessState)
              {
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
            if (cubit.products.isEmpty && state is! GetProductLoadingState) {
              return const Center(child: Text('There Is No Products '));
            }
            else
              {
                if (state is GetProductFailureState) {
                  return Text('Error: ${state.error}');
                }
                else if (state is GetProductSuccessState ||
                    state is AddProductSuccessState ||
                    state is DeleteProductSuccessState ) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ProductListViewItem(
                        product: cubit.products[index],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemCount: cubit.products.length,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }

              }


          },
        ),
      ),


    );
  }
}
