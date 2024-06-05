import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footwear_store_admin/presentation/controller/product_cubit.dart';
import 'package:footwear_store_admin/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/utils/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(const FootWearStore());
}

class FootWearStore extends StatelessWidget {
  const FootWearStore({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..fetchAllProducts()..getOrders(),
      child: MaterialApp(
        title: 'FootWear Store',
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.almaraiTextTheme(
            Theme
                .of(context)
                .textTheme,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white
          ),

        ),
        debugShowCheckedModeBanner: false,
        // ? Navigate From Home To Add New Products .
        home: const HomeScreen(),
      ),
    );
  }
}


