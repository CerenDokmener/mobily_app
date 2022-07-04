import 'package:flutter/material.dart';
import 'package:mobily_app/models/product.dart';
import 'package:mobily_app/widgets/products.list.view.dart';

import '../widgets/top_nav_bar.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Products> products = [];

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
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget addNewData() {
      return Column(
        children: [
          Container(
            width: 400.0,
            child: TextField(
              cursorWidth: 2.0,
              controller: myController,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(151, 54, 20, 1),
            onPressed: () {
              products.add(Products(numbers: (myController.text)));

              setState(() {});
            },
            tooltip: 'Show me the value!',
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              mainImage(0.25, 0.25, 50),
            ],
          ),
          Column(
            children: [
              Text(
                'ürünler',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 400.0,
                      height: 200.0,
                      child: ProductsListView(
                        products: products,
                      ))),
              addNewData(),
            ],
          ),
        ],
      ),
    );
  }
}