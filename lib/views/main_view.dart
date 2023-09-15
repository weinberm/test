import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/history_viewmodel.dart';
import 'package:waste_walking_ba/views/login_view.dart';

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
    // Überprüfen Sie, ob der Benutzer angemeldet ist
    bool isUserLoggedIn = mainViewModel.amplifyService.signedIn;

    if (!isUserLoggedIn && mainViewModel.selectedIndex == 0) {
      // Direkt in der build Methode
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Bitte anmelden'),
              content: Text(
                  'Für den Zugriff auf die Community müssen Sie angemeldet sein.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  child: Text('Anmelden'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Abbrechen'),
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/logo/ww-logo.png"),
                width: 40,
                height: 40,
              ), // Ihr zentrales Icon
            ],
          ),
        ),
        drawer: Drawer(
          // Fügen Sie die Elemente Ihres Drawers hier hinzu
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
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
              child: _buildTabBody(
                  mainViewModel, context), // Ihr eigentlicher Inhalt
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
      case 4:
        return ProfileTabView();
      default:
        return Container();
    }
  }
}
