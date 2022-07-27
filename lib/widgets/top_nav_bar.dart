import 'package:flutter/material.dart';
import 'package:mobily_app/screens/fabric_page.dart';
import 'package:mobily_app/screens/models_page.dart';
import 'package:mobily_app/screens/products_page.dart';

import '../screens/legs_page.dart';

class topNavBar extends StatefulWidget {
  topNavBar({Key? key}) : super(key: key);

  @override
  State<topNavBar> createState() => _topNavBarState();
}

Color selected = Color(0xffffffff);
Color notSelected = Color(0xafffffff);

class _topNavBarState extends State<topNavBar> {
  List<Widget> navBarItems = [
    NavBarItem(
      text: 'Modeller',
    ),
    VerticalDivider(
      color: Colors.white,
      thickness: 1,
      indent: 10,
      endIndent: 10,
    ),
    NavBarItem(
      text: 'Ürünler',
    ),
    VerticalDivider(
      color: Colors.white,
      thickness: 1,
      indent: 10,
      endIndent: 10,
    ),
    NavBarItem(
      text: 'Kumaşlar',
    ),
    VerticalDivider(
      color: Colors.white,
      thickness: 1,
      indent: 10,
      endIndent: 10,
    ),
    NavBarItem(
      text: 'Ayaklar',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: EdgeInsets.only(top: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(151, 54, 20, 1),
            ),
            width: 522,
            height: 50.0,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    children: navBarItems,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final String text;
  NavBarItem({
    required this.text,
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  Color color = notSelected;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          color = selected;
        });
      },
      onExit: (value) {
        setState(() {
          color = notSelected;
        });
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            switch (widget.text) {
              case 'Modeller':
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ModelsPage()));
                break;
              case 'Ürünler':
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProductsPage()));
                break;
              case 'Kumaşlar':
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const FabricPage()));
                break;
              case 'Ayaklar':
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LegsPage()));
                break;
              default:
            }
          },
          child: Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 16.0,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
