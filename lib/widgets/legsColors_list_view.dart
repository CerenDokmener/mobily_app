import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import '../models/leg_color.dart';

import '../services/cloud_functions.dart';

class LegsColorsListView extends StatefulWidget {
  const LegsColorsListView({Key? key}) : super(key: key);
  @override
  State<LegsColorsListView> createState() => _LegsColorsListState();
}

class _LegsColorsListState extends State<LegsColorsListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<Document>>(
        stream: legColorsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.isEmpty
              ? const Center(child: Text('Mobilya Ayak rengi yok'))
              : ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map((legColors) {
                        return ListTile(
                          title: Text(legColors['legColor']),
                          leading: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteItem(
                                  legColors['legColor'], legColorsCollection);
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

 return SizedBox(
      child: StreamBuilder<List<Document>>(
      stream: legColorsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
         if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.isEmpty
          ? const Center(child: Text('Mobilya Ayak rengi yok')) 
          : ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: snapshot.data!.map((legColors){
              return ListTile(
                title: Text(legColors['legColor']),
                leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteItem(legColors['legColor'], legColorsCollection);
                },
              ),
            );
             }).toList().cast(),
          );
        },
    ),
    
    );
  }

  */


/*
import 'package:flutter/material.dart';
import '../models/leg_color.dart';

class LegsColorsListView extends StatefulWidget {
  const LegsColorsListView({Key? key, required this.legsColors})
      : super(key: key);
  final List<LegsColors> legsColors;

  @override
  State<LegsColorsListView> createState() => _LegsColorsListViewState();
}

class _LegsColorsListViewState extends State<LegsColorsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.legsColors.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.legsColors[index].leg_color),
                leading: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.brown,
                  ),
                  onPressed: () {
                    widget.legsColors.removeAt(index);
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