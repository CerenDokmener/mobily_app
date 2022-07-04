import 'package:flutter/material.dart';
import 'package:mobily_app/main.dart';
import 'package:mobily_app/models/leg_models.dart';
import 'package:mobily_app/widgets/top_nav_bar.dart';
import 'package:provider/provider.dart';

import '../models/leg_colors.dart';
import '../widgets/legsColors_list_view.dart';
import '../widgets/legs_list_view.dart';

class LegsPage extends StatefulWidget {
  const LegsPage({Key? key}) : super(key: key);

  @override
  State<LegsPage> createState() => _LegsPageState();
}

class _LegsPageState extends State<LegsPage> {
  List<LegsModels> legsModels = [];
  List<LegsColors> legsColors = [];
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

  @override
  void initState() {
    super.initState();
  }

  final myLegModelController = TextEditingController();
  final myLegColorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget addLegModel() {
      return Column(
        children: [
          Container(
            width: 400.0,
            child: TextField(
              cursorWidth: 2.0,
              controller: myLegModelController,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(151, 54, 20, 1),
            onPressed: () {
              legsModels.add(
                LegsModels(leg_model: (myLegModelController.text)),
              );
              setState(() {});
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
              controller: myLegColorController,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(151, 54, 20, 1),
            onPressed: () {
              legsColors.add(
                LegsColors(leg_color: (myLegColorController.text)),
              );
              setState(() {});
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
                        child: LegsListView(legsModels: legsModels))),
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
                        child: LegsColorsListView(legsColors: legsColors))),
                addLegColor(),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
