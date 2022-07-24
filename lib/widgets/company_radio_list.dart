import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/services/cloud_functions.dart';

class CompanyRadioList extends StatefulWidget {
  const CompanyRadioList({Key? key}) : super(key: key);

  @override
  State<CompanyRadioList> createState() => _CompanyRadioListState();
}

class _CompanyRadioListState extends State<CompanyRadioList> {
  String selected = '';

  void _itemChange(String itemValue) {
    setState(() {
      selected = itemValue;
    });
  }

  void _cancel() {
    Navigator.pop(context, '');
  }

  void _submit() {
    Navigator.pop(context, selected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seçim Yap'),
      content: SingleChildScrollView(
        child: FutureBuilder<List<Document>>(
          future: getItems('Companies'),
          builder:
              (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Yükleniyor...'));
            }

            return snapshot.data!.isEmpty
                ? const Center(child: Text('Firma Yok'))
                : ListBody(
                    children: snapshot.data!
                        .map(
                          (companies) => RadioListTile(
                            title: Text(companies['companyName']),
                            value: companies['companyName'].toString(),
                            groupValue: selected,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) => _itemChange(value.toString()),
                          ),
                        )
                        .toList(),
                  );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Çıkış'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Kaydet'),
          onPressed: _submit,
        ),
      ],
    );
  }
}
