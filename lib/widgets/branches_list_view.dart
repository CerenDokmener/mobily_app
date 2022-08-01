import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/models/branch.dart';
import 'package:mobily_app/services/cloud_functions.dart';

class BranchesList extends StatefulWidget {
  final String belongedCompany;
  const BranchesList({Key? key, required this.belongedCompany})
      : super(key: key);

  @override
  State<BranchesList> createState() => _BranchesListState();
}

class _BranchesListState extends State<BranchesList> {
  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Şubeler'),
      content: SingleChildScrollView(
        child: FutureBuilder<List<Document>>(
          future: collectionOfItem('Branches')
              .where('belongedCompany', isEqualTo: widget.belongedCompany)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Yükleniyor...'));
            }

            return snapshot.data!.isEmpty
                ? const Center(child: Text('Şube Yok'))
                : ListBody(
                    children: snapshot.data!
                        .map((items) {
                          return ListTile(
                            title: Column(children: [
                              Row(children: [
                                Container(
                                    width: 110,
                                    child: Text(items['branchName'])),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    width: 110, child: Text(items['password'])),
                              ])
                            ]),
                            leading: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteItem(
                                    items['branchName'], branchesCollection);
                                _cancel();
                              },
                            ),
                          );
                        })
                        .toList()
                        .cast(),
                  );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Çıkış'),
          onPressed: _cancel,
        ),
      ],
    );
  }
}
