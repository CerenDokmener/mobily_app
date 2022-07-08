import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

import '../services/cloud_functions.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({Key? key}) : super(key: key);
  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView>{
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: StreamBuilder<List<Document>>(
        stream: productsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.isEmpty
              ? const Center(child: Text('Ürün yok'))
              : ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map((products) {
                        return ListTile(
                          title: Text(products['productName']),
                          leading: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteItem(
                                  products['productName'], productsCollection);
                            },
                          ),
                        );
                      })
                      .toList()
                      .cast(),
                );
        },
      ),
    );
  }

}





/*

import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsListView extends StatefulWidget {
  ProductsListView({Key? key, required this.products}) : super(key: key);
  final List<Products> products;
  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ListView.builder(
            primary: false,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.products[index].numbers),
                leading: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.brown,
                  ),
                  onPressed: () {
                    widget.products.removeAt(index);
                    setState(() {});
                  },
                ),
              );
            }),
      ]),
    );
  }
}

*/