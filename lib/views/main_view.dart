// import 'package:flutter/material.dart';

// import 'package:waste_walking_ba/amplify.dart';
// import 'package:waste_walking_ba/views/main_view.dart';
// import 'package:waste_walking_ba/widgets/bottom_navbar.dart';
// import 'views/map.dart';

// import './models/Coordinate.dart';

// class MainView extends StatefulWidget {
//   const MainView({super.key, required this.title});

//   final String title;

//   @override
//   State<MainView> createState() => _MainViewState();
// }

// class _MainViewState extends State<MainView> {
//   // late final AmplifyService _awsService;

//   @override
//   void initState() {
//     super.initState();

//     // _awsService = AmplifyService();
//     // _awsService.configure();
//   }

//   // Future<void> _configureAws() async {
//   //   // await _awsService.configure();
//   // }

//   // Future<void> createRecord(List<Coordinate> coordinates, int user_id) async {
//   //   await _awsService.createRecord(coordinates, user_id);
//   // }

//   // static const TextStyle optionStyle =
//   //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text(widget.title),
//         ),
//         bottomNavigationBar: BottomNavBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
//         body: _tabs[_selectedIndex],
//         floatingActionButton: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//               onPressed: _lockPosition,
//               child: Icon(started ? Icons.stop_circle : Icons.play_circle),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             FloatingActionButton(
//               onPressed: _test,
//               child: Icon(started ? Icons.stop_circle : Icons.play_circle),
//             )
//           ],
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/widgets/bottom_navbar.dart';

class MainView extends StatelessWidget {
  const MainView({required this.viewModel, required this.title});

  final MainViewModel viewModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(title),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: viewModel.selectedIndex,
        onItemTapped: viewModel.changeTabIndex,
      ),
      body: viewModel.getTabAtIndex(viewModel),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   onPressed: viewModel.incrementCounter,
          //   child: Icon(Icons.abc),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // FloatingActionButton(
          //   onPressed: viewModel.test,
          //   child:
          //       Icon(viewModel.started ? Icons.stop_circle : Icons.play_circle),
          // )
        ],
      ),
    );
  }
}
