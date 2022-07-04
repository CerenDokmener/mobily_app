import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/leg_models.dart';

class LegsListView extends StatefulWidget {
  const LegsListView({Key? key, required this.legsModels}) : super(key: key);
  final List<LegsModels> legsModels;

  @override
  State<LegsListView> createState() => _LegsListViewState();
}

class _LegsListViewState extends State<LegsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.legsModels.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.legsModels[index].leg_model),
                leading: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.brown,
                  ),
                  onPressed: () {
                    widget.legsModels.removeAt(index);
                    setState(() {});
                  },
                ),
              );
            }),
      ]),
    );
  }
}
