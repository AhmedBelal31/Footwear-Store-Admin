import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'presentation/screens/add_product_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FootWearStore());
}

class FootWearStore extends StatelessWidget {
  const FootWearStore({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FootWear Store',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        scaffoldBackgroundColor: Colors.white ,
        appBarTheme:const  AppBarTheme(
          backgroundColor: Colors.white
        )
      ),
      debugShowCheckedModeBanner: false,
      /// Navigate From Home To Add New Products .
      home:  AddProductScreen(),
    );
  }
}


