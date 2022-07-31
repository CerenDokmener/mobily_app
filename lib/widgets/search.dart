import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 270,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(234, 214, 206, 1),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              'Sipariş Ara:',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: 100,
                child: TextField(
                  controller: searchController,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: (() {
                setState(() {});
              }),
              child: Text(
                'ARA',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(159, 117, 117, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ));
  }
}
