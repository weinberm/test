import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/history_viewmodel.dart';

import 'package:waste_walking_ba/widgets/bottom_navbar.dart';

import 'package:waste_walking_ba/views/tab_views/community_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/history_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/leaderboard_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/map_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/profile_tab_view.dart';

import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView(
      {required this.mainViewModel,
      required this.mapViewModel,
      required this.title});

  final MainViewModel mainViewModel;
  final MapViewModel mapViewModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(title),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: mainViewModel.selectedIndex,
        onItemTapped: mainViewModel.changeTabIndex,
      ),
      body: _buildTabBody(mainViewModel),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Weitere FloatingActionButton Widgets hier
        ],
      ),
    );
  }

  Widget _buildTabBody(MainViewModel mainViewModel) {
    switch (mainViewModel.selectedIndex) {
      case 0:
        return CommunityTabView(
          mainViewModel: mainViewModel,
        );
      case 1:
        return LeaderboardTabView();
      case 2:
        return MapTabView(mapViewModel: mapViewModel);
      case 3:
        return ChangeNotifierProvider(
          create: (context) => HistoryViewModel(),
          builder: (context, child) {
            return HistoryTabView(
              historyViewModel: Provider.of<HistoryViewModel>(context),
              mainViewModel: mainViewModel,
            );
          },
        );
      case 4:
        return ProfileTabView();
      default:
        return Container();
    }
  }
}
