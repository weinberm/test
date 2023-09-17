import 'package:flutter/material.dart';
import 'package:waste_walking_ba/widgets/history_tab/history_listitem.dart';

import '../../models/WasteWalkRecord.dart';

class HistoryList extends StatelessWidget {
  final List<WasteWalkRecord> records;

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
                print('Item clicked: ${records[index].id}');
              },
              child: Column(children: [
                HistoryListItem(
                  record: records[index],
                ),
                Container(
                  height: 2, // Höhe des unteren Balkens
                  color:
                      Color(0xFF2A3D18), // Hintergrundfarbe des unteren Balkens
                )
              ]),
            );
          },
        ),
      ],
    );
  }
}
