// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobily_app/main.dart';
import 'package:mobily_app/screens/add_models_page.dart';
import 'package:mobily_app/screens/products_page.dart';
import 'package:mobily_app/widgets/models_list_view.dart';
import 'package:mobily_app/widgets/top_nav_bar.dart';

class ModelsPage extends StatefulWidget {
  ModelsPage({Key? key}) : super(key: key);

  @override
  State<ModelsPage> createState() => _ModelsPageState();
}

class _ModelsPageState extends State<ModelsPage> {
  Widget backButton() {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Color.fromRGBO(174, 93, 64, 1),
        ));
  }

  Widget mainImage(double width_size, double height_size, double padding_size) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100, left: 15),
                child: backButton(),
              ),
              Container(
                padding: EdgeInsets.only(right: 50, top: 50, bottom: 50),
                width: MediaQuery.of(context).size.width * width_size,
                height: MediaQuery.of(context).size.height * height_size,
                child: const Image(
                    image: const AssetImage('assets/images/38372.png')),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 280),
          child: Container(
            width: 600,
            height: 100.0,
            child: topNavBar(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        mainImage(0.25, 0.25, 45),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120),
          child: Column(children: [
            // ignore: prefer_const_literals_to_create_immutables
            Row(children: [
              SizedBox(
                width: 30,
              ),
              Text(
                'Modeller',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 120,
              ),
              Text('Ürünler', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                width: 130,
              ),
              Text('Kumaş', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                width: 150,
              ),
              Text('Ayak', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                width: 130,
              ),
              Text('Ayak Rengi', style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            Divider(
              color: Colors.black,
              height: 20,
              thickness: 2,
              endIndent: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(right: 80),
              child:
                  Container(width: 1200, height: 200, child: ModelListView()),
            ),
            Padding(
              padding: EdgeInsets.only(left: 800, top: 60),
              child: Container(
                width: 250,
                height: 45,
                child: FloatingActionButton(
                  heroTag: null,
                  child: Text(
                    'Yeni Model oluştur',
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  backgroundColor: Color.fromRGBO(174, 93, 64, 1),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddModelsPage()));
                  },
                ),
              ),
            )
          ]),
        )
      ],
    ));
  }
}
