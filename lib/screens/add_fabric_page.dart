import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobily_app/models/fabric.dart';
import 'package:mobily_app/screens/fabric_page.dart';

class AddFabricPage extends StatefulWidget {
  AddFabricPage({Key? key}) : super(key: key);

  @override
  State<AddFabricPage> createState() => _AddFabricPageState();
}

List<String> fabricCodes = [];
String fabricName = '';

final fabricController = TextEditingController();

final fabricCodeController = TextEditingController();
List<Fabric> fabrics = [
  Fabric(fabricModel: 'neva', fabricColors: ['a12']),
];
List<Widget> _fabricCodeList = [];

class _AddFabricPageState extends State<AddFabricPage> {
  void _addFabricCode() {
    setState(() {
      fabricCodes.add(fabricCodeController.text);
      fabricCodeController.clear();
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
                  'Yeni Kumaş Oluştur',
                  style: TextStyle(
                      color: Color.fromRGBO(151, 54, 20, 1),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(height: 70),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: Text(
                  'Kumaş Adı: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  controller: fabricController,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: SizedBox(
                  width: 80,
                  child: Text(
                    'Kumaş Kodları: ',
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
                  controller: (fabricCodeController),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: _addFabricCode,
                backgroundColor: Color.fromRGBO(151, 54, 20, 1),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 520),
            child: SizedBox(
              height: 200,
              width: 300,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fabricCodes.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 40,
                          width: 200.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Center(
                              child: Text(
                            fabricCodes[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  })),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 700),
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
                      MaterialPageRoute(builder: (context) => FabricPage()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
