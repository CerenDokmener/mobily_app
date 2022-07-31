import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/screens/admin_main_page.dart';
import 'package:mobily_app/screens/login_page.dart';

const apiKey = 'AIzaSyDgZE97hyCx9gcpR6iP7c_pzXedFPO7mgY';
const projectId = 'sima-e84ef';

void main() {
  //Get.put(FormController()); // controller init
  Firestore.initialize(projectId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginPage(),
    );
  }
}
