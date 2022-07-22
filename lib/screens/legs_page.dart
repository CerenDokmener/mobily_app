import 'package:flutter/material.dart';
import 'package:mobily_app/main.dart';
import 'package:mobily_app/models/leg_model.dart';
import 'package:mobily_app/services/cloud_functions.dart';
import 'package:mobily_app/widgets/top_nav_bar.dart';

import '../models/leg_color.dart';
import '../widgets/items_list_view.dart';

class LegsPage extends StatefulWidget {
  const LegsPage({Key? key}) : super(key: key);

  @override
  State<LegsPage> createState() => _LegsPageState();
}

class _LegsPageState extends State<LegsPage> {
  Widget mainImage(double width_size, double height_size, double padding_size) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.all(padding_size),
            width: MediaQuery.of(context).size.width * width_size,
            height: MediaQuery.of(context).size.height * height_size,
            child: Image(image: AssetImage('assets/images/38372.png')),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 320),
          child: Container(
            width: 600,
            height: 100.0,
            child: topNavBar(),
          ),
        )
      ],
    );
  }

  final legModelController = TextEditingController();
  final legColorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget addLegModel() {
      return Column(
        children: [
          Container(
            width: 400.0,
            child: TextField(
              cursorWidth: 2.0,
              controller: legModelController,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Color.fromRGBO(151, 54, 20, 1),
            onPressed: () async {
              await addItem('legModel', legModelController.text);
              // await addLeg(legModelController.text);
              setState(() {
                legModelController.clear();
              });
            },
            tooltip: 'Show me the value!',
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    Widget addLegColor() {
      return Column(
        children: [
          Container(
            width: 400.0,
            child: TextField(
              cursorWidth: 2.0,
              controller: legColorController,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Color.fromRGBO(151, 54, 20, 1),
            onPressed: () async {
              await addItem('legColor', legColorController.text);
              setState(() {
                legColorController.clear();
              });
            },
            tooltip: 'Show me the value!',
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            mainImage(0.25, 0.25, 50),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
            ),
            Column(
              children: [
                Text(
                  'Ayak Modelleri',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 400.0,
                        height: 200.0,
                        child: const ItemsListView(
                            nameCol: 'LegModels', nameElement: 'legModel'))),
                addLegModel(),
              ],
            ),
            SizedBox(
              width: 200,
            ),
            Column(
              children: [
                Text(
                  'Ayak Renk Kodları',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 400.0,
                        height: 200.0,
                        child: const ItemsListView(
                            nameCol: 'LegColors', nameElement: 'legColor'))),
                addLegColor(),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
