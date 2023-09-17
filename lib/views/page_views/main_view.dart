import 'package:flutter/material.dart';
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
              height: 4, // Höhe des oberen Balkens
              color: Color(0xFF35B05C), // Hintergrundfarbe des oberen Balkens
            ),
            Expanded(
                child: TabBarView(
              children: [
                CommunityTabView(mainViewModel: mainViewModel),
                LeaderboardTabView(),
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
            )
                // child: _buildTabBody(
                //     mainViewModel, context), // Ihr eigentlicher Inhalt
                ),
            Container(
              height: 4, // Höhe des unteren Balkens
              color: Color(0xFF35B05C), // Hintergrundfarbe des unteren Balkens
            ),
          ],
        ));
  }

  Widget _buildTabBody(MainViewModel mainViewModel, BuildContext context) {
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
      default:
        return Container();
    }
  }
}
