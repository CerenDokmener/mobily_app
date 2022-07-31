import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';

import '../services/cloud_functions.dart';

class CheckboxList extends StatefulWidget {
  final String nameCol, nameElement;
  final future;
  const CheckboxList(
      {Key? key, required this.nameCol, required this.nameElement, this.future})
      : super(key: key);

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context, _selectedItems);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nameCol != 'CustomerNames' && widget.nameCol != 'FabricColors') {
      return AlertDialog(
        title: const Text('Seçim Yap'),
        content: SingleChildScrollView(
          child: FutureBuilder<List<Document>>(
            future: collectionOfItem(widget.nameCol).get(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Yükleniyor...'));
              }

              return snapshot.data!.isEmpty
                  ? const Center(child: Text('Ürün Yok'))
                  : ListBody(
                      children: snapshot.data!
                          .map((item) => CheckboxListTile(
                                value: _selectedItems
                                    .contains(item[widget.nameElement]),
                                title: Text(item[widget.nameElement]),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (isChecked) => _itemChange(
                                    item[widget.nameElement], isChecked!),
                              ))
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
    } else {
      return AlertDialog(
        title: const Text('Seçim Yap'),
        content: SingleChildScrollView(
          child: FutureBuilder<List<String>>(
            future: widget.future,
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Yükleniyor...'));
              }

              return snapshot.data!.isEmpty
                  ? const Center(child: Text('Ürün Yok'))
                  : ListBody(
                      children: snapshot.data!
                          .map((item) => CheckboxListTile(
                                value: _selectedItems.contains(item),
                                title: Text(item),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (isChecked) =>
                                    _itemChange(item, isChecked!),
                              ))
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
}
