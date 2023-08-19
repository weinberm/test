import 'package:flutter/material.dart';

import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/history_viewmodel.dart';

class HistoryTabView extends StatelessWidget {
  const HistoryTabView(
      {required this.mainViewModel, required this.historyViewModel});

  final MainViewModel mainViewModel;
  final HistoryViewModel historyViewModel;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child:
          Text("To be implemented History " + mainViewModel.counter.toString()),
    );
  }
}
