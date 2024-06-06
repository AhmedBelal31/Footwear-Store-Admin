import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/data/models/product_model.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import 'package:footwear_store_admin/presentation/screens/add_product_screen.dart';
import 'package:footwear_store_admin/styles.dart';
import 'orders_screen.dart';
import 'dart:math';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProductCubit, ProductStates>(
//       listener: (context, state) {
//         if (state is DeleteProductSuccessState) {
//           CustomSnackBarOverlay.show(
//             context,
//             message: 'Deleted',
//             messageDescription: 'Product Deleted !',
//             msgColor: Colors.red,
//           );
//         }
//       },
//       builder: (context, state) {
//         var cubit = BlocProvider.of<ProductCubit>(context);
//         return Scaffold(
//           appBar: AppBar(
//             scrolledUnderElevation: 0.0,
//             title: const Text("Footwear Products"),
//             centerTitle: true,
//             // actions: [
//             //   if (state is GetProductLoadingState)
//             //     const CircularProgressIndicator(color: AppStyles.kPrimaryColor),
//             //   if (state is! GetProductLoadingState)
//             //     IconButton(
//             //       onPressed: () {
//             //         Navigator.of(context).push(
//             //           MaterialPageRoute(
//             //             builder: (context) => OrdersScreen(
//             //               orders: BlocProvider.of<ProductCubit>(context).orders,
//             //             ),
//             //           ),
//             //         );
//             //       },
//             //       icon: const Icon(Icons.menu),
//             //     ),
//             //   const SizedBox(width: 10),
//             // ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const AddProductScreen(),
//                 ),
//               );
//             },
//             child: const Icon(Icons.add),
//           ),
//           body: Builder(
//             builder: (context) {
//               if (cubit.products.isEmpty && state is! GetProductLoadingState) {
//                 return const Center(child: Text('There Is No Products '));
//               } else {
//                 if (state is GetProductFailureState) {
//                   return Text('Error: ${state.error}');
//                 } else if (state is DeleteProductFailureState) {
//                   return Text('Error: ${state.error}');
//                 } else {
//                   return Column(
//                     children: [
//                       if (state is GetProductLoadingState)
//                         const CircularProgressIndicator(color: Colors.white),
//                       if (state is! GetProductLoadingState)
//                         InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => OrdersScreen(
//                                   orders: BlocProvider.of<ProductCubit>(context)
//                                       .orders,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: AppStyles.kPrimaryColor,
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             child: const ListTile(
//                               title: Text(
//                                 'Orders ',
//                                 style: TextStyle(color: Colors.white , fontSize: 18),
//                               ),
//                               trailing: Icon(
//                                 // Icons.receipt_long ,
//                                 Icons.assignment ,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       if (state is DeleteProductLoadingState)
//                         const Padding(
//                           padding: EdgeInsets.all(20),
//                           child: LinearProgressIndicator(),
//                         ),
//                       Expanded(
//                         child: RefreshIndicator(
//                           onRefresh: () async {
//                             cubit.fetchAllProducts();
//                           },
//                           child: ListView.separated(
//                             physics: const BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return ProductListViewItem(
//                                 product: cubit.products[index],
//                               );
//                             },
//                             separatorBuilder: (context, index) =>
//                                 const SizedBox(height: 8),
//                             itemCount: cubit.products.length,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Footwear Products"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const AddProductScreen(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.blueGrey[50],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             margin: const EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => OrdersScreen(
//                           orders: BlocProvider.of<ProductCubit>(context).orders,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       Icon(Icons.assignment, size: 50, color: Colors.blue),
//                       const SizedBox(height: 5),
//                       Text(
//                         'Orders',
//                         style: TextStyle(fontSize: 16, color: Colors.blue),
//                       ),
//                     ],
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const AddProductScreen(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       Icon(Icons.add_shopping_cart, size: 50, color: Colors.green),
//                       const SizedBox(height: 5),
//                       Text(
//                         'Add Product',
//                         style: TextStyle(fontSize: 16, color: Colors.green),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: BlocBuilder<ProductCubit, ProductStates>(
//               builder: (context, state) {
//                 var cubit = BlocProvider.of<ProductCubit>(context);
//                 List<ProductModel> products = cubit.products;
//                 return GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     return ProductCard(product: products[index]);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Footwear Products"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          var cubit = BlocProvider.of<ProductCubit>(context);
          List<ProductModel> products = cubit.products;
          return RefreshIndicator(
            onRefresh: () async {
              cubit.fetchAllProducts();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OrdersScreen(
                                    orders:
                                        BlocProvider.of<ProductCubit>(context)
                                            .orders,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.assignment,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Orders',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddProductScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_shopping_cart,
                                      size: 50, color: Colors.blue),
                                  SizedBox(height: 10),
                                  Text(
                                    'Add Product',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (state is! GetProductLoadingState ||
                        state is! GetOrdersLoadingState)
                      Container(
                        color: Colors.grey[300],
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: screenWidth / screenHeight * 1.50,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemBuilder: (context, index) =>
                              ProductGridViewItem(product: products[index]),
                          itemCount: products.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductGridViewItem extends StatelessWidget {
  final ProductModel product;

  const ProductGridViewItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var random = Random();
    int randomNumber = random.nextInt(60);
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ProductDetailsScreen(
        //         product: product
        //     ),
        //   ),
        // );
      },
      child: Container(
        // elevation:8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: screenHeight * 0.180,
                  width: double.infinity,
                  child: FancyShimmerImage(
                    imageUrl: product.imageUrl ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png',
                    errorWidget: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
                  )),
              const SizedBox(height: 4),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, height: 1.3),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    // '${product.price}\$',
                    product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${product.price}\$',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppStyles.kPrimaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // if (product.offer == true)
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        child: Text(
                          '$randomNumber% OFF',
                          style: const TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProductCubit>(context)
                          .deleteProduct(productId: product.id);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 20,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 4),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       // color: Colors.red,
              //       borderRadius: BorderRadius.circular(4.0),
              //     ),
              //     // child: const Padding(
              //     //   padding: EdgeInsets.all(8.0),
              //     //   child: Text(
              //     //     'Delete ',
              //     //     style: TextStyle(
              //     //       color: Colors.white
              //     //     ),
              //     //   ),
              //     // ),
              //     child: IconButton(
              //       onPressed: () {},
              //       icon: Icon(
              //         Icons.restore_from_trash,
              //         color: Colors.red,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
