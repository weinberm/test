import 'package:flutter/material.dart';

import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/history_viewmodel.dart';
import 'package:waste_walking_ba/widgets/history_list.dart';

class HistoryTabView extends StatelessWidget {
  HistoryTabView({required this.mainViewModel, required this.historyViewModel});

  final MainViewModel mainViewModel;
  final HistoryViewModel historyViewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HistoryList(records: historyViewModel.recordHistory),
    );
  }
}
