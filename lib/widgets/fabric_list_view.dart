import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/services/cloud_functions.dart';

import '../models/fabric.dart';



class FabricListView extends StatefulWidget {
  const FabricListView({Key? key}) : super(key: key);

  @override
  State<FabricListView> createState() => _FabricListViewState();
}

class _FabricListViewState extends State<FabricListView> {
  @override
  Widget build(BuildContext context) {

return SizedBox(
      child: StreamBuilder<List<Document>>(
        stream: fabricsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.isEmpty
              ? const Center(child: Text('Kumaş yok'))
              : ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!.map((fabrics) {

                
                  List<String> fabricColors = List<String>.from(fabrics['fabricColors']);
                    
                   String newValue = fabricColors[fabrics['selected']];

           
           return ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Text(fabrics['fabricModel']),
                    SizedBox(
                      width: 120,
                    ),
                    Container(
                      width: 140,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: DropdownButton(
                        underline: SizedBox(),
                        isExpanded: true,
                        onChanged: (String? changedValue) {
                          updateFabric(fabrics['fabricModel'], fabricColors.indexOf(changedValue.toString()));
                          setState(() {
                          });
                        },
                        value: newValue,
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
                           
                          }),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.brown,
                      ),
                      onPressed: () {
                        deleteItem(fabrics['fabricModel'], fabricsCollection);
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
