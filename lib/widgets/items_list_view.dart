import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import '../models/leg_model.dart';

import '../services/cloud_functions.dart';

class ItemsListView extends StatefulWidget {
  final String nameCol, nameElement;
  const ItemsListView({
    Key? key,
    required this.nameCol,
    required this.nameElement,
  }) : super(key: key);
  @override
  State<ItemsListView> createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<Document>>(
        stream: streamOfCollection(collectionOfItem(widget.nameCol)),
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.isEmpty
              ? const Center(child: Text('Ürün Yok'))
              : ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map((items) {
                        if (widget.nameCol != 'Fabrics') {
                          return ListTile(
                            title: Text(items[widget.nameElement]),
                            leading: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteItem(items[widget.nameElement],
                                    collectionOfItem(widget.nameCol));
                              },
                            ),
                          );
                        } else {
                          List<String> fabricColors =
                              List<String>.from(items['fabricColors']);

                          return ListTile(
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Text(items['fabricModel']),
                                      width: 170,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                      ),
                                      child: DropdownButton(
                                        underline: SizedBox(),
                                        isExpanded: true,
                                        onChanged: (String? changedValue) {},
                                        value: fabricColors[0],
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color.fromRGBO(151, 54, 20, 1),
                                        ),
                                        items: fabricColors.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    /*
                                    
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
                                          onPressed: () {}),
                                    ),
                                    */
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.brown,
                                      ),
                                      onPressed: () {
                                        deleteItem(items['fabricModel'],
                                            collectionOfItem(widget.nameCol));
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
                        }
                      })
                      .toList()
                      .cast(),
                );
        },
      ),
    );
  }
}
