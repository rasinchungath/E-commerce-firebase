import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:provider/provider.dart';
import 'checkout/paymentpage.dart';
import 'homescreen.dart';
import 'model/product_class.dart';

Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}