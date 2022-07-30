import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/services/cloud_functions.dart';

import '../models/model.dart';
import '../screens/products_page.dart';

class ModelListView extends StatefulWidget {
  const ModelListView({Key? key}) : super(key: key);

  @override
  State<ModelListView> createState() => _ModelListViewState();
}

class _ModelListViewState extends State<ModelListView> {
  Widget dropDown(List<String> t, String value) {
    return Container(
      width: 140,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        value: value,
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
    return SizedBox(
      child: StreamBuilder<List<Document>>(
        stream: Firestore.instance.collection('Models').stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.isEmpty
              ? const Center(child: Text('Model yok'))
              : ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map((models) {
                        List<String> legColors =
                            List<String>.from(models['legColors']);
                        List<String> legModels =
                            List<String>.from(models['legModels']);
                        List<String> fabrics =
                            List<String>.from(models['fabrics']);
                        List<String> products =
                            List<String>.from(models['products']);

                        return ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: 90,
                                      child: Text(models['modelName'])),
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
                                  dropDown(products, products[0]),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  dropDown(fabrics, fabrics[0]),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  dropDown(legModels, legModels[0]),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  dropDown(legColors, legColors[0]),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 25,
                                    child: FloatingActionButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        heroTag: null,
                                        backgroundColor:
                                            Color.fromRGBO(151, 54, 20, 1),
                                        child: Text('Düzenle'),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductsPage()));
                                        }),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.brown,
                                    ),
                                    onPressed: () {
                                      deleteItem(models['modelName'],
                                          modelsCollection);
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
                      })
                      .toList()
                      .cast(),
                );
        },
      ),
    );
  }
}
