import 'package:flutter/material.dart';
import 'package:waste_walking_ba/widgets/history_listitem.dart';

class HistoryList extends StatelessWidget {
  final List<String> records;

  HistoryList({required this.records});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Handle item click here
                print('Item clicked: ${records[index]}');
              },
              child: HistoryListItem(
                text: records[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
