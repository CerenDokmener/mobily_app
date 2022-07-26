import 'package:flutter/material.dart';
import 'package:mobily_app/widgets/items_list_view.dart';
import '../services/cloud_functions.dart';
import '../widgets/top_nav_bar.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
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
        Padding(
          padding: const EdgeInsets.only(left: 280),
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

  final productController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget addNewData() {
      return Column(
        children: [
          Container(
            width: 400.0,
            child: TextField(
              cursorWidth: 2.0,
              controller: productController,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(151, 54, 20, 1),
            onPressed: () async {
              await addItem('productName', productController.text);
              setState(() {
                productController.clear();
              });
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
                'Ürünler',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 400.0,
                      height: 200.0,
                      child: const ItemsListView(
                          nameCol: 'ProductNames',
                          nameElement: 'productName'))),
              addNewData(),
            ],
          ),
        ],
      ),
    );
  }
}
