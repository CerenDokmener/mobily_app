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
