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

class AddModelsPage extends StatefulWidget {
  AddModelsPage({Key? key}) : super(key: key);

  @override
  State<AddModelsPage> createState() => _AddModelsPageState();
}

List<String> products = ['naem1', 'naem2'];

final modelController = TextEditingController();

class _AddModelsPageState extends State<AddModelsPage> {
  Widget addRow(
      String firstText, String secondText, List<String> cl, Widget pageName) {
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: DropdownButton<String>(
            underline: SizedBox(),
            isExpanded: true,
            value: null,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Color.fromRGBO(151, 54, 20, 1),
            ),
            items: cl.map((e) {
              return DropdownMenuItem(child: Text(e), value: e);
            }).toList(),
            onChanged: (value) {},
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
        )
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
        addRow('Ürünler', 'Yeni Ürün Oluştur', products, ProductsPage()),
        SizedBox(
          height: 10,
        ),
        addRow('Kumaşlar', 'Yeni Kumaş Oluştur', products, AddFabricPage()),
        SizedBox(
          height: 10,
        ),
        addRow(
          'Ayaklar',
          'Yeni Ayak Oluştur',
          products,
          LegsPage(),
        ),
        SizedBox(
          height: 10,
        ),
        addRow('Ayak Rengi', 'Yeni Ayak Rengi Oluştur', products, LegsPage()),
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
