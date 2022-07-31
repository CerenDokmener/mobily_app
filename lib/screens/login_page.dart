import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:mobily_app/screens/admin_main_page.dart';

import '../services/cloud_functions.dart';
import '../services/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final passwordController = TextEditingController();

checkUser(BuildContext context) async {
  if (passwordController.text.isNotEmpty) {
    List<Document> docs = await collectionOfItem('Admins').get();
    Map<String, dynamic>? value1 = docs[0].map;
    Map<String, dynamic>? value2 = docs[1].map;

    if (passwordController.text == value1['password'] ||
        passwordController.text == value2['password']) {
      if (passwordController.text == value1['password']) {
        if (value1['adminName'] == 'admin') {
          globals.user = 'admin';
        } else {
          globals.user = 'worker';
        }
      } else {
        if (value2['adminName'] == 'admin') {
          globals.user = 'admin';
        } else {
          globals.user = 'worker';
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminMain(),
        ),
      );
    } else {
      passwordController.text = '';
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Hatalı Giriş"),
              content: Text('Şifre Yanlış'),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            child: Padding(
          padding: EdgeInsets.only(bottom: 420),
          child: Center(
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image(image: AssetImage('assets/images/38372.png')),
            ),
          ),
        )),
        AnimatedPositioned(
          left: 350,
          width: 600,
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
          top: 230,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
            height: 300,
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width - 40,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5),
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(150, 54, 21, 1)
                                        .withOpacity(0.5),
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(224, 160, 45, 1)
                                        .withOpacity(0.5),
                                    width: 2),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Şifre Giriniz',
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Color(0XFFA7BCC7)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        AnimatedPositioned(
          top: 530,
          left: 540,
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.05,
          duration: Duration(milliseconds: 300),
          child: ElevatedButton(
            onPressed: () {
              checkUser(context);
            },
            child: const Text(
              "Giriş Yap",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(214, 220, 147, 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
          ),
        ),
      ],
    ));
  }
}
