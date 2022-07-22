// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobily_app/models/customers.dart';
import 'package:mobily_app/screens/customers_page.dart';

import '../widgets/customers_list_view.dart';

class AddCustomersPage extends StatefulWidget {
  AddCustomersPage({Key? key}) : super(key: key);

  @override
  State<AddCustomersPage> createState() => _AddCustomersPageState();
}

final customerNameController = TextEditingController();
final customerPasswordController = TextEditingController();
final branchesCustomerController = TextEditingController();
final usernameBranchController = TextEditingController();
final passwordBranchController = TextEditingController();

List<Branches> branches = [];

class _AddCustomersPageState extends State<AddCustomersPage> {
  void _addBranchWidget() {
    setState(() {
      customers.add(Customers(
          customerName: customerNameController.text,
          passwordCustomer: customerPasswordController.text,
          branches: [branchesCustomerController.text]));
      branches.add(Branches(branchesCustomerController.text,
          usernameBranchController.text, passwordBranchController.text));
      branchesCustomerController.clear();
      usernameBranchController.clear();
      passwordBranchController.clear();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CustomersPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(50),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image(image: AssetImage('assets/images/38372.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250.0),
                child: Text(
                  'Yeni Kullanıcı Oluştur',
                  style: TextStyle(
                      color: Color.fromRGBO(151, 54, 20, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 210, bottom: 40),
                    child: Text(
                      'Firma Ekle',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Kullanıcı Adı: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Parola: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          width: 50,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 40,
                              width: 200.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: TextField(
                                cursorWidth: 2.0,
                                controller: customerNameController,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 40,
                              width: 200.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: TextField(
                                cursorWidth: 2.0,
                                controller: customerPasswordController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 200, top: 30),
                    child: Text(
                      'Şube Ekle',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Bağlı Olduğu Firma: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Kullanıcı Adı: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Parola: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: 200.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: TextField(
                                cursorWidth: 2.0,
                                controller: branchesCustomerController,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: 200.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: TextField(
                                cursorWidth: 2.0,
                                controller: usernameBranchController,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: 200.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: TextField(
                                cursorWidth: 2.0,
                                controller: passwordBranchController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              width: 120,
              height: 45,
              child: FloatingActionButton(
                heroTag: null,
                child: Text(
                  'Kaydet',
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                backgroundColor: Color.fromRGBO(151, 54, 20, 1),
                onPressed: () {
                  _addBranchWidget();
                },
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
