// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobily_app/models/leg_color.dart';
import 'package:mobily_app/models/leg_model.dart';
import 'package:mobily_app/models/product.dart';

import '../models/model.dart';
import '../screens/products_page.dart';

class ModelsListView extends StatefulWidget {
  ModelsListView({Key? key}) : super(key: key);

  @override
  State<ModelsListView> createState() => _ModelsListViewState();
}

List<Models> models = [
  Models(
      products: [('1 p')],
      fabric: [('1 k')],
      legColors: [('c c')],
      legModels: [('d f')],
      model_name: 'Palmira'),
  Models(
      products: [('1')],
      fabric: [('1')],
      legColors: [('c')],
      legModels: [('d')],
      model_name: 'Napoli'),
  Models(
      products: [('1')],
      fabric: [('1')],
      legColors: [('c')],
      legModels: [('d')],
      model_name: 'Silver'),
];

class _ModelsListViewState extends State<ModelsListView> {
  Widget dropDown(List<String> t) {
    return Container(
      width: 140,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        value: null,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Color.fromRGBO(151, 54, 20, 1),
        ),
        items: t.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: models.length,
        itemBuilder: (context, index) {
          List<String> fabricList = models[index].fabric;
          List<String> productslist = models[index].products;
          List<String> legColorList = models[index].legColors;
          List<String> legModelList = models[index].legModels;

          return ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(width: 90, child: Text(models[index].model_name)),
                    Column(
                      children: [
                        Divider(
                          color: Colors.black,
                          height: 10,
                          thickness: 0.5,
                          endIndent: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    dropDown(productslist),
                    SizedBox(
                      width: 40,
                    ),
                    dropDown(fabricList),
                    SizedBox(
                      width: 50,
                    ),
                    dropDown(legModelList),
                    SizedBox(
                      width: 40,
                    ),
                    dropDown(legColorList),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 100,
                      height: 25,
                      child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          heroTag: null,
                          backgroundColor: Color.fromRGBO(151, 54, 20, 1),
                          child: Text('Düzenle'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductsPage()));
                          }),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.brown,
                      ),
                      onPressed: () {
                        models.removeAt(index);
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 0.5,
                  endIndent: 10,
                ),
              ],
            ),
          );
        });
  }
}
