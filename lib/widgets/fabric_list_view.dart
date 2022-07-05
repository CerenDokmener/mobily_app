import 'package:flutter/material.dart';

import '../models/fabric.dart';
import '../screens/products_page.dart';

class FabricListView extends StatefulWidget {
  FabricListView({Key? key}) : super(key: key);

  @override
  State<FabricListView> createState() => _FabricListViewState();
}

List<Fabric> fabric = [
  Fabric(
    fabric_name: 'neva',
    fabric_code: ['1', '2', '3'],
  ),
  Fabric(fabric_name: 'Tumi', fabric_code: ['1', '2', '3']),
  Fabric(fabric_name: 'Beybifes', fabric_code: ['1', '2']),
  Fabric(fabric_name: 'Beybifes', fabric_code: ['1', '2']),
];
String dropdownvalue = '1';

class _FabricListViewState extends State<FabricListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: fabric.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Text(fabric[index].fabric_name),
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
                        value: dropdownvalue,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(151, 54, 20, 1),
                        ),
                        items: fabric[index].fabric_code.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {});
                        },
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
                        fabric.removeAt(index);
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
