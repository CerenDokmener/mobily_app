// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mobily_app/models/model.dart';
import 'package:mobily_app/screens/legs_page.dart';
import 'package:mobily_app/screens/models_page.dart';
import 'package:mobily_app/screens/products_page.dart';
import '../widgets/multi_select.dart';

class AddModelsPage extends StatefulWidget {
  AddModelsPage({Key? key}) : super(key: key);

  @override
  State<AddModelsPage> createState() => _AddModelsPageState();
}

final modelController = TextEditingController();

class _AddModelsPageState extends State<AddModelsPage> {
  List<String> _selectedProductsItems = [];
  List<String> _selectedFabricsItems = [];
  List<String> _selectedLegModelItems = [];
  List<String> _selectedLegColorItems = [];

  void _showMultiSelect(String _nameCol, String _nameElement) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          nameCol: _nameCol,
          nameElement: _nameElement,
        );
      },
    );

    if (_nameCol == 'ProductNames') {
      if (results != null) {
        setState(() {
          _selectedProductsItems = results;
        });
      }
    } else if (_nameCol == 'Fabrics') {
      if (results != null) {
        setState(() {
          _selectedFabricsItems = results;
        });
      }
    } else if (_nameCol == 'LegColors') {
      if (results != null) {
        setState(() {
          _selectedLegColorItems = results;
        });
      }
    } else if (_nameCol == 'LegModels') {
      if (results != null) {
        setState(() {
          _selectedLegModelItems = results;
        });
      }
    }
  }

  void saveAndGo(
      String modelName, List<String> products, fabrics, legColors, legModels) {
    addModel(modelName, products, fabrics, legColors, legModels);
    Navigator.of(context).pop();
  }

  Widget addRow(String firstText, String secondText, String nameCol,
      String nameElement, Widget pageName, List<String> selectClass) {
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
            //onPressed: () => _showMultiSelect(cl),
            onPressed: () {
              _showMultiSelect(nameCol, nameElement);
            },
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
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 100, left: 15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Color.fromRGBO(174, 93, 64, 1),
                          ))),
                  Container(
                    padding: EdgeInsets.all(50),
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image(image: AssetImage('assets/images/38372.png')),
                  ),
                ],
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
        addRow('Ürünler', 'Yeni Ürün Oluştur', 'ProductNames', 'productName',
            ProductsPage(), _selectedProductsItems),
        SizedBox(
          height: 10,
        ),
        addRow('Kumaşlar', 'Yeni Kumaş Oluştur', 'Fabrics', 'fabricModel',
            ModelsPage(), _selectedFabricsItems),
        SizedBox(
          height: 10,
        ),
        addRow('Ayaklar', 'Yeni Ayak Oluştur', 'LegModels', 'legModel',
            LegsPage(), _selectedLegModelItems),
        SizedBox(
          height: 10,
        ),
        addRow('Ayak Rengi', 'Yeni Ayak Rengi Oluştur', 'LegColors', 'legColor',
            LegsPage(), _selectedLegColorItems),
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
                saveAndGo(
                    modelController.text,
                    _selectedProductsItems,
                    _selectedFabricsItems,
                    _selectedLegColorItems,
                    _selectedLegModelItems);
              },
            ),
          ),
        )
      ]),
    );
  }
}
