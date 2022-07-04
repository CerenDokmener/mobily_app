
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import '../models/leg_model.dart';

import '../services/cloud_functions.dart';



class ItemsListView extends StatefulWidget {
  const ItemsListView({Key? key}) : super(key: key);
  @override
  State<ItemsListView> createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: StreamBuilder<List<Document>>(
      stream: legModelsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
         if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.isEmpty
          ? const Center(child: Text('')) 
          : ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: snapshot.data!.map((legModels){
              return ListTile(
                title: Text(legModels['legModel']),
                leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteItem(legModels['legModel'], legModelsCollection);
                },
              ),
            );
             }).toList().cast(),
          );
        },
    ),
    
    );
  }
}
