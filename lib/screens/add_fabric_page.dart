import 'package:flutter/material.dart';

class AddFabricPage extends StatefulWidget {
  AddFabricPage({Key? key}) : super(key: key);

  @override
  State<AddFabricPage> createState() => _AddFabricPageState();
}

final fabricController = TextEditingController();

final fabricCodeController = TextEditingController();

class _AddFabricPageState extends State<AddFabricPage> {
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
            height: 40,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: SizedBox(
                  width: 80,
                  child: Text(
                    'Kumaş Kod Sayısı: ',
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
                  onChanged: (fabricCodeController) {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
