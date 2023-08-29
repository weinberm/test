import 'package:flutter/material.dart';

class HistoryListItem extends StatelessWidget {
  final String text;

  HistoryListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.red, width: 5)),
      padding: EdgeInsets.all(5),
      child: Text("x"),
    );
  }
}
