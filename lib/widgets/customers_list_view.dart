import 'dart:core';
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/models/company.dart';
import 'package:mobily_app/screens/add_customers_page.dart';
import 'branches_list_view.dart';
import '../services/cloud_functions.dart';

class CustomersListView extends StatefulWidget {
  CustomersListView({Key? key}) : super(key: key);

  @override
  State<CustomersListView> createState() => _CustomersListViewState();
}

class _CustomersListViewState extends State<CustomersListView> {
  void _branchesList(String belongedCompany) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BranchesList(
          belongedCompany: belongedCompany,
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<Document>>(
        stream: Firestore.instance.collection('Companies').stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('Sistemde kayıtlı firma Yok'));
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data!.map((companies) {
                return ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 110,
                              child: Text(companies['companyName'])),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 110, child: Text(companies['password'])),
                          Container(
                            width: 180,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                onPrimary: Colors.white,
                                onSurface: Colors.grey,
                              ),
                              child: const Text('Şubeleri Göster'),
                              //onPressed: () => _showMultiSelect(cl),
                              onPressed: () {
                                _branchesList(companies['companyName']);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.brown,
                            ),
                            onPressed: () {
                              deleteItem(companies['companyName'],
                                  companiesCollection);
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
              }).toList(),
            );
          }
        },
      ),
    );
  }
}



/*

 child: DropdownButton(
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      onChanged: (String? changedValue) {},
                                      value: '',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color.fromRGBO(151, 54, 20, 1),
                                      ),
                                      items: branchesG.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                    ),
                                    */