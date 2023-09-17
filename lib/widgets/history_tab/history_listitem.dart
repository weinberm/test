import 'package:flutter/material.dart';
import 'package:waste_walking_ba/models/ModelProvider.dart';

class HistoryListItem extends StatelessWidget {
  final WasteWalkRecord record;

  HistoryListItem({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 80,
      child: Row(
        children: [Column()],
      ),
    );
  }
}
