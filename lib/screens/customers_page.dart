// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobily_app/screens/add_customers_page.dart';
import 'package:mobily_app/widgets/customers_list_view.dart';

import '../widgets/top_nav_bar.dart';

class CustomersPage extends StatefulWidget {
  CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  Widget backButton() {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Color.fromRGBO(174, 93, 64, 1),
        ));
  }

  Widget mainImage(double width_size, double height_size, double padding_size) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100, left: 15),
                child: backButton(),
              ),
              Container(
                padding: EdgeInsets.only(right: 50, top: 50, bottom: 50),
                width: MediaQuery.of(context).size.width * width_size,
                height: MediaQuery.of(context).size.height * height_size,
                child: const Image(
                    image: const AssetImage('assets/images/38372.png')),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainImage(0.25, 0.25, 50),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 300,
            ),
            child: Column(
              children: [
                // ignore: prefer_const_literals_to_create_immutables
                Row(children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Firma Adı',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 200,
                  ),
                  Text('Şubeler', style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 2,
                  endIndent: 350,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 370),
                  child: Container(
                    width: 590,
                    height: 250,
                    child: CustomersListView(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 450, top: 50),
                  child: Container(
                    width: 250,
                    height: 50,
                    child: FloatingActionButton(
                      heroTag: null,
                      child: Text(
                        'Yeni Kullanıcı oluştur',
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      backgroundColor: Color.fromRGBO(174, 93, 64, 1),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddCustomersPage()));
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
