// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobily_app/screens/add_fabric_page.dart';
import 'package:mobily_app/screens/fabric_page.dart';
import 'package:mobily_app/screens/legs_page.dart';
import 'package:mobily_app/screens/models_page.dart';
import 'package:mobily_app/screens/products_page.dart';
import 'package:mobily_app/widgets/models_list_view.dart';
import 'package:mobily_app/widgets/products.list.view.dart';
import '../models/product.dart';
import '../widgets/multi_select.dart';

class AddModelsPage extends StatefulWidget {
  AddModelsPage({Key? key}) : super(key: key);

  @override
  State<AddModelsPage> createState() => _AddModelsPageState();
}

final modelController = TextEditingController();
List<String> _products = ['1+1', '2+3', '4', '8'];
List<String> _fabrics = ['fmeğ', 'fme'];
List<String> _legColors = ['white', 'red'];
List<String> _legModels = ['idk', 'tryin'];

class _AddModelsPageState extends State<AddModelsPage> {
  List<String> _selectedProductsItems = [];
  List<String> _selectedFabricsItems = [];
  List<String> _selectedLegModelItems = [];
  List<String> _selectedLegColorItems = [];

  void _showMultiSelect(List<String> _name) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _name);
      },
    );

    if (_name == _products) {
      if (results != null) {
        setState(() {
          _selectedProductsItems = results;
        });
      }
    } else if (_name == _fabrics) {
      if (results != null) {
        setState(() {
          _selectedFabricsItems = results;
        });
      }
    } else if (_name == _legColors) {
      if (results != null) {
        setState(() {
          _selectedLegColorItems = results;
        });
      }
    } else if (_name == _legModels) {
      if (results != null) {
        setState(() {
          _selectedLegModelItems = results;
        });
      }
    }
  }

  Widget addRow(String firstText, String secondText, List<String> cl,
      Widget pageName, List<String> selectClass) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 150.0),
          child: Container(
            width: 80,
            child: Text(
              firstText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Container(
          width: 200,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.grey,
            ),
            child: const Text('Seçim Yap'),
            onPressed: () => _showMultiSelect(cl),
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Container(
          width: 230,
          height: 40,
          child: FloatingActionButton(
            heroTag: null,
            child: Text(
              secondText,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            backgroundColor: Color.fromRGBO(174, 93, 64, 1),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => pageName));
            },
          ),
        ),
        SizedBox(
          width: 30,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 400,
            height: 30,
            child: Wrap(
              children: selectClass
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                'Yeni Model Oluştur',
                style: TextStyle(
                    color: Color.fromRGBO(151, 54, 20, 1),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 150.0),
              child: Container(
                width: 80,
                child: Text(
                  'Model Adı: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              height: 40,
              width: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: TextField(
                cursorWidth: 2.0,
                controller: modelController,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        addRow('Ürünler', 'Yeni Ürün Oluştur', _products, ProductsPage(),
            _selectedProductsItems),
        SizedBox(
          height: 10,
        ),
        addRow('Kumaşlar', 'Yeni Kumaş Oluştur', _fabrics, ModelsPage(),
            _selectedFabricsItems),
        SizedBox(
          height: 10,
        ),
        addRow('Ayaklar', 'Yeni Ayak Oluştur', _legModels, LegsPage(),
            _selectedLegModelItems),
        SizedBox(
          height: 10,
        ),
        addRow('Ayak Rengi', 'Yeni Ayak Rengi Oluştur', _legColors, LegsPage(),
            _selectedLegColorItems),
        Padding(
          padding: EdgeInsets.only(left: 800, top: 60),
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ModelsPage()));
              },
            ),
          ),
        )
      ]),
    );
  }
}
