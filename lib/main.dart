import 'package:flutter/material.dart';
import 'package:mobily_app/screens/products_page.dart';
import 'models/leg_models.dart';
import 'models/product.dart';
import 'screens/legs_page.dart';

void main() {
  //Get.put(FormController()); // controller init
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LegsPage(),
    );
  }
}
