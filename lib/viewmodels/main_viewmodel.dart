import 'package:flutter/material.dart';

import 'package:waste_walking_ba/views/tab_views/community_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/history_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/leaderboard_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/map_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/profile_tab_view.dart';

class MainViewModel extends ChangeNotifier {
  int selectedIndex = 2;

  void changeTabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Widget getTabAtIndex() {
    switch (selectedIndex) {
      case 0:
        return CommunityTabView();
      case 1:
        return LeaderboardTabView();
      case 2:
        return MapTabView();
      case 3:
        return HistoryTabView();
      case 4:
        return ProfileTabView();
      default:
        return Container();
    }
  }
}
