import 'package:flutter/material.dart';
import '../models/leg_colors.dart';

class LegsColorsListView extends StatefulWidget {
  const LegsColorsListView({Key? key, required this.legsColors})
      : super(key: key);
  final List<LegsColors> legsColors;

  @override
  State<LegsColorsListView> createState() => _LegsColorsListViewState();
}

class _LegsColorsListViewState extends State<LegsColorsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.legsColors.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.legsColors[index].leg_color),
                leading: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.brown,
                  ),
                  onPressed: () {
                    widget.legsColors.removeAt(index);
                    setState(() {});
                  },
                ),
              );
            }),
      ]),
    );
  }
}
