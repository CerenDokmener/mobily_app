import 'package:flutter/material.dart';
import 'package:mobily_app/screens/customers_page.dart';
import 'package:mobily_app/screens/models_page.dart';

class AdminMain extends StatelessWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttons(Color color, String labelText, Widget pageName) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ))),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => pageName));
            },
            child: Text(labelText)),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image(image: AssetImage('assets/images/38372.png')),
              ),
            ),
            SizedBox(height: 30),
            buttons(Color.fromRGBO(171, 92, 65, 1), "Siparişler", ModelsPage()),
            SizedBox(
              height: 10,
            ),
            buttons(Color.fromRGBO(171, 92, 65, 1), "Ürünler", ModelsPage()),
            SizedBox(
              height: 10,
            ),
            buttons(
                Color.fromRGBO(171, 92, 65, 1), "Müşteriler", CustomersPage()),
          ],
        ),
      ),
    );
  }
}
