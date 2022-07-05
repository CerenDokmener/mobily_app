// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobily_app/models/fabric.dart';
import 'package:mobily_app/screens/products_page.dart';
import 'package:mobily_app/widgets/fabric_list_view.dart';

import '../widgets/top_nav_bar.dart';

class FabricPage extends StatefulWidget {
  FabricPage({Key? key}) : super(key: key);

  @override
  State<FabricPage> createState() => _FabricPageState();
}

class _FabricPageState extends State<FabricPage> {
  Widget mainImage(double width_size, double height_size, double padding_size) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.all(padding_size),
            width: MediaQuery.of(context).size.width * width_size,
            height: MediaQuery.of(context).size.height * height_size,
            child: Image(image: AssetImage('assets/images/38372.png')),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 320),
          child: Container(
            width: 600,
            height: 100.0,
            child: topNavBar(),
          ),
        )
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
            padding: EdgeInsets.only(left: 450),
            child: Column(
              children: [
                // ignore: prefer_const_literals_to_create_immutables
                Row(children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Kumaşlar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text('Kumaş Kodları',
                      style: TextStyle(fontWeight: FontWeight.bold))
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
                  padding: EdgeInsets.only(right: 300),
                  child: Container(
                      width: 520, height: 250, child: FabricListView()),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 450, top: 50),
                  child: Container(
                    width: 250,
                    height: 50,
                    child: FloatingActionButton(
                      heroTag: null,
                      child: Text(
                        'Yeni Kumaş oluştur',
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      backgroundColor: Color.fromRGBO(174, 93, 64, 1),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductsPage()));
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
