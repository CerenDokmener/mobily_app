import 'package:flutter/material.dart';
import 'package:mobily_app/screens/orders_page.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

Color selectedColor = Color.fromRGBO(174, 93, 64, 1);
bool _first = true;
bool _second = false;
bool _third = false;
bool _fourth = false;

class _NavBarState extends State<NavBar> {
  String selectedPage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _first = true;
                  if (_second == false && _third == false && _fourth == false) {
                    _first = true;
                  }
                  _second = false;
                  _third = false;
                  _fourth = false;

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrdersPage(status: 'Beklemede')));
                });
              },
              child: Text('Yeni Siparişler',
                  style: TextStyle(
                      fontSize: 15,
                      color: _first ? Colors.white : Colors.black)),
              style: ElevatedButton.styleFrom(
                primary: _first ? selectedColor : Colors.white,
              ),
            )),
        SizedBox(
          width: 20,
        ),
        Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _second = true;
                  if (_first == false && _third == false && _fourth == false) {
                    _second = true;
                  }
                  _first = false;
                  _third = false;
                  _fourth = false;

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrdersPage(status: 'Üretiliyor')));
                });
              },
              child: Text('Üretiliyor',
                  style: TextStyle(
                      fontSize: 15,
                      color: _second ? Colors.white : Colors.black)),
              style: ElevatedButton.styleFrom(
                primary: _second ? selectedColor : Colors.white,
              ),
            )),
        SizedBox(
          width: 20,
        ),
        Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _third = true;
                  if (_first == false && _second == false && _fourth == false) {
                    _third = true;
                  }
                  _first = false;
                  _second = false;
                  _fourth = false;

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrdersPage(status: 'Depoda')));
                });
              },
              child: Text('Depoda',
                  style: TextStyle(
                      fontSize: 15,
                      color: _third ? Colors.white : Colors.black)),
              style: ElevatedButton.styleFrom(
                primary: _third ? selectedColor : Colors.white,
              ),
            )),
        SizedBox(
          width: 20,
        ),
        Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _fourth = true;
                  if (_second == false && _first == false && _third == false) {
                    _fourth = true;
                  }
                  _third = false;
                  _second = false;
                  _first = false;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrdersPage(status: 'Tamamlandı')));
                });
              },
              child: Text('Geçmiş Siparişler',
                  style: TextStyle(
                      fontSize: 15,
                      color: _fourth ? Colors.white : Colors.black)),
              style: ElevatedButton.styleFrom(
                primary: _fourth ? selectedColor : Colors.white,
              ),
            )),
      ],
    ));
  }
}
