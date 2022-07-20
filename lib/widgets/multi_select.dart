import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/services/cloud_functions.dart';

class MultiSelect extends StatefulWidget {
  final String nameCol, nameElement;
  const MultiSelect(
      {Key? key, required this.nameCol, required this.nameElement})
      : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
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
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seçim Yap'),
      content: SingleChildScrollView(
        child: FutureBuilder<List<Document>>(
          future: getItems(widget.nameCol),
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
                              controlAffinity: ListTileControlAffinity.leading,
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

    /*

    return AlertDialog(
      title: const Text('Seçim Yap'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
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

*/
  }
}
