import 'package:flutter/material.dart';

import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';

class MapTabView extends StatelessWidget {
  const MapTabView({required this.mainViewModel, required this.mapViewModel});

  final MainViewModel mainViewModel;
  final MapViewModel mapViewModel;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text("To be implemented Map " + mainViewModel.counter.toString()),
    );
  }
}
