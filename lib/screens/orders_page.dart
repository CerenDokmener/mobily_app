import 'dart:ffi';

import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';

import '../services/cloud_functions.dart';
import '../widgets/checkbox_list.dart';
import '../widgets/navbar.dart';

import '../services/globals.dart' as globals;
import '../widgets/order_order.dart';
import '../widgets/search.dart';

class OrdersPage extends StatefulWidget {
  final String status;
  OrdersPage({Key? key, required this.status}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

List<String> selectedModels = [];
List<String> selectedProducts = [];
List<String> selectedFabrics = [];
List<String> selectedFabricColors = [];
List<String> selectedLegColors = [];
List<String> selectedLegModels = [];
List<String> selectedCustomerNames = [];

bool selectBox = false;

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    bool streamStatus = true;

    void showCheckList(String nameCol, String nameElement) async {
      Future<List<String>> future;
      List<String> results = [];
      String status = '';
      switch (widget.status) {
        case 'Beklemede':
          status = 'newOrders';
          break;
        case 'Üretiliyor':
          status = 'completedOrders';
          break;
        case 'Tamamlandı':
          status = 'onGoingOrders';
          break;
      }

      if (nameCol == 'CustomerNames') {
        future = getCustomerNames(status);
        results = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CheckboxList(
              nameCol: nameCol,
              nameElement: nameElement,
              future: future,
            );
          },
        );
      } else if (nameCol == 'FabricColors') {
        future = getFabricColors();
        results = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CheckboxList(
              nameCol: nameCol,
              nameElement: nameElement,
              future: future,
            );
          },
        );
      } else {
        results = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CheckboxList(
              nameCol: nameCol,
              nameElement: nameElement,
            );
          },
        );
      }

      switch (nameCol) {
        case 'Models':
          selectedModels = results;
          break;
        case 'Fabrics':
          selectedFabrics = results;
          break;
        case 'FabricColors':
          selectedFabricColors = results;
          break;
        case 'LegModels':
          selectedLegModels = results;
          break;
        case 'LegColors':
          selectedLegColors = results;
          break;
        case 'ProductNames':
          selectedProducts = results;
          break;
        case 'CustomerNames':
          selectedCustomerNames = results;
          break;
      }
    }

    addRow(String typeName, List<String> selectedItems) {
      return Row(
        children: [
          Text(
            typeName,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
            height: 30,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 220, 166, 118),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                child: const Text('Seçim Yap'),
                onPressed: () {
                  switch (typeName) {
                    case 'MODEL':
                      showCheckList('Models', 'modelName');
                      break;
                    case 'KUMAŞ':
                      showCheckList('Fabrics', 'fabricModel');
                      break;
                    case 'KUMAŞ RENGİ':
                      showCheckList('FabricColors', 'orderByFabricColors');
                      break;
                    case 'AYAK MODELİ':
                      showCheckList('LegModels', 'legModel');
                      break;
                    case 'AYAK RENGİ':
                      showCheckList('LegColors', 'legColor');
                      break;
                    case 'ÜRÜN':
                      showCheckList('ProductNames', 'productName');
                      break;
                    case 'MÜŞTERİ ADI':
                      showCheckList('CustomerNames', 'customerName');

                      break;
                  }
                }),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 400,
              height: 30,
              child: Wrap(
                children: selectedItems
                    .map((e) => Chip(
                          label: Text(e),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      );
    }

    void _cancel() {
      selectedModels = [];
      selectedProducts = [];
      selectedFabrics = [];
      selectedFabricColors = [];
      selectedLegColors = [];
      selectedLegModels = [];
      selectedCustomerNames = [];
      Navigator.pop(context);
      setState(() {});
    }

    void _submit() {
      Navigator.pop(context);
      setState(() {});
    }

    Future<dynamic> FilterPopUp() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Align(
                    alignment: Alignment.center,
                    child: Text('FİLTRELE',
                        style: TextStyle(color: Colors.black))),
                content: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(183, 170, 165, 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            addRow('MODEL', selectedModels),
                            addRow('KUMAŞ', selectedFabrics),
                            addRow('KUMAŞ RENGİ', selectedFabricColors),
                            addRow('AYAK MODELİ', selectedLegModels),
                            addRow('AYAK RENGİ', selectedLegColors),
                            addRow('ÜRÜN', selectedProducts),
                            addRow('MÜŞTERİ ADI', selectedCustomerNames),
                          ],
                        )
                      ],
                    )),
                actions: [
                  TextButton(
                    child: const Text('Çıkış'),
                    onPressed: _cancel,
                  ),
                  ElevatedButton(
                    child: const Text('Kaydet'),
                    onPressed: _submit,
                  ),
                ]);
          });
    }

    return Scaffold(
        body: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 70, left: 15),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Color.fromRGBO(174, 93, 64, 1),
                      ))),
              Container(
                width: 220,
                height: 50,
                child: Image(image: AssetImage('assets/images/38372.png')),
              ),
              Container(height: 50, width: 800, child: NavBar()),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 200, bottom: 20),
                child: Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(),
                    child: ElevatedButton(
                      onPressed: (() {
                        streamStatus = false;
                        FilterPopUp();
                      }),
                      child: Text(
                        'Filtrele',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(234, 214, 206, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    )),
              ),
            ),
            SizedBox(
              width: 600,
            ),
            Search()
          ],
        ),
        Container(
          height: 450,
          width: 1000,
          child: OrderOrder(
            orders: getOrders(
                selectedModels,
                selectedProducts,
                selectedFabrics,
                selectedFabricColors,
                selectedLegColors,
                selectedLegModels,
                selectedCustomerNames,
                widget.status),
            status: widget.status,
            streamStatus: streamStatus,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 850),
          child: Row(
            children: [
              Text(
                'Hepsini Seç: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.green,
                value: selectBox,
                onChanged: (bool? value) {
                  setState(() {
                    selectBox = value!;
                  });
                },
              ),
              SizedBox(
                width: 150,
                height: 30,
                child: FloatingActionButton(
                  onPressed: (() {}),
                  child: Text('Yazdir'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  heroTag: null,
                  backgroundColor: Color.fromARGB(255, 187, 78, 19),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
