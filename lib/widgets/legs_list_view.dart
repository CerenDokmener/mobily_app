
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import '../models/leg_model.dart';

import '../services/cloud_functions.dart';



class LegsListView extends StatefulWidget {
  const LegsListView({Key? key}) : super(key: key);
  @override
  State<LegsListView> createState() => _LegsListViewState();
}

class _LegsListViewState extends State<LegsListView> {
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
          ? const Center(child: Text('Mobilya Ayak modeli yok')) 
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





/*

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/leg_model.dart';

class LegsListView extends StatefulWidget {
  const LegsListView({Key? key, required this.legsModels}) : super(key: key);
  final List<LegsModels> legsModels;

  @override
  State<LegsListView> createState() => _LegsListViewState();
}

class _LegsListViewState extends State<LegsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.legsModels.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.legsModels[index].leg_model),
                leading: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.brown,
                  ),
                  onPressed: () {
                    widget.legsModels.removeAt(index);
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