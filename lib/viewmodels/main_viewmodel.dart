import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/history_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';

import 'package:waste_walking_ba/views/tab_views/community_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/history_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/leaderboard_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/map_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/profile_tab_view.dart';

import 'package:provider/provider.dart';

class MainViewModel extends ChangeNotifier {
  int selectedIndex = 2;
  int counter = 0;

  void changeTabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  Widget getTabAtIndex(MainViewModel mainViewModel) {
    switch (selectedIndex) {
      case 0:
        return CommunityTabView();
      case 1:
        return LeaderboardTabView();
      case 2:
        return ChangeNotifierProvider(
            create: (context) => MapViewModel(),
            builder: (context, child) {
              return MapTabView(
                  mapViewModel: Provider.of<MapViewModel>(context),
                  mainViewModel: mainViewModel);
            });
      case 3:
        return ChangeNotifierProvider(
            create: (context) => HistoryViewModel(),
            builder: (context, child) {
              return HistoryTabView(
                  historyViewModel: Provider.of<HistoryViewModel>(context),
                  mainViewModel: mainViewModel);
            });
      case 4:
        return ProfileTabView();
      default:
        return Container();
    }
  }
}
