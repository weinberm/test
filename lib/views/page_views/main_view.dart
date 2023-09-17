import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/leaderboard_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/history_viewmodel.dart';
import 'package:waste_walking_ba/views/page_views/login_view.dart';

import 'package:waste_walking_ba/widgets/main_view/bottom_navbar.dart';

import 'package:waste_walking_ba/views/tab_views/community_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/history_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/leaderboard_tab_view.dart';
import 'package:waste_walking_ba/views/tab_views/map_tab_view.dart';

import 'package:provider/provider.dart';
import 'package:waste_walking_ba/widgets/main_view/wastewalk_appbar.dart';

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
        appBar: const WasteWalkAppBar(),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: mainViewModel.selectedIndex,
          onItemTapped: mainViewModel.changeTabIndex,
        ),
        body: Column(
          children: [
            Container(
              height: 4,
              color: Color(0xFF35B05C),
            ),
            Expanded(
                child: TabBarView(
              children: [
                CommunityTabView(mainViewModel: mainViewModel),
                ChangeNotifierProvider(
                  create: (context) => LeaderboardViewModel(),
                  builder: (context, child) {
                    return LeaderboardTabView(
                      leaderboardViewModel:
                          Provider.of<LeaderboardViewModel>(context),
                      mainViewModel: mainViewModel,
                    );
                  },
                ),
                MapTabView(mapViewModel: mapViewModel),
                ChangeNotifierProvider(
                  create: (context) => HistoryViewModel(),
                  builder: (context, child) {
                    return HistoryTabView(
                      historyViewModel: Provider.of<HistoryViewModel>(context),
                      mainViewModel: mainViewModel,
                    );
                  },
                )
              ],
            )),
            Container(
              height: 4,
              color: Color(0xFF35B05C),
            ),
          ],
        ));
  }
}
