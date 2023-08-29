import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';
import 'package:waste_walking_ba/views/main_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Walking Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainViewModel()),
          ChangeNotifierProvider(create: (context) => MapViewModel()),
        ],
        builder: (context, child) {
          return MainView(
            mainViewModel: Provider.of<MainViewModel>(context),
            mapViewModel: Provider.of<MapViewModel>(context),
            title: "Waste Walking Demo",
          );
        },
      ),
    );
  }
}
