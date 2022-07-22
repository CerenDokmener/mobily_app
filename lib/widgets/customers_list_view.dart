import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mobily_app/models/customers.dart';
import 'package:mobily_app/screens/add_customers_page.dart';

import '../screens/products_page.dart';

class CustomersListView extends StatefulWidget {
  CustomersListView({Key? key}) : super(key: key);

  @override
  State<CustomersListView> createState() => _CustomersListViewState();
}

List<Customers> customers = [
  Customers(
      customerName: 'Yon AVM',
      ////   username: 'cernn',
      branches: ['avcilar', '2'],
      passwordCustomer: '123'),
  Customers(
      customerName: 'Kuzey AVM',
      branches: ['avcilar', 'beylikdüzü'],
      // username: 'cernn',
      passwordCustomer: '123'),
];

String dropdownvalue = 'avcilar';

class _CustomersListViewState extends State<CustomersListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: customers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 110, child: Text(customers[index].customerName)),
                    SizedBox(
                      width: 108,
                    ),
                    Container(
                      width: 180,
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
                        items: customers[index].branches.map((String items) {
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
                                builder: (context) => AddCustomersPage()));
                          }),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.brown,
                      ),
                      onPressed: () {
                        customers.removeAt(index);
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
