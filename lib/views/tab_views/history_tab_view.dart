import 'package:flutter/material.dart';

import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/history_viewmodel.dart';
import 'package:waste_walking_ba/widgets/history_list.dart';

class HistoryTabView extends StatelessWidget {
  HistoryTabView({required this.mainViewModel, required this.historyViewModel});

  final MainViewModel mainViewModel;
  final HistoryViewModel historyViewModel;

  final List<String> items = [
    'Element 1',
    'Element 2',
    'Element 3',
    'Element 4',
    'Element 5',
    'Element 1',
    'Element 2',
    'Element 3',
    'Element 4',
    'Element 5',
    'Element 1',
    'Element 2',
    'Element 3',
    'Element 4',
    'Element 5',
    'Element 1',
    'Element 2',
    'Element 3',
    'Element 4',
    'Element 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HistoryList(records: items),
    );
  }
}
