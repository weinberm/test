import 'package:flutter/material.dart';

import 'package:waste_walking_ba/amplify.dart';
import 'widgets/map.dart';
import 'geolocation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Walking Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Waste Walking Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final AmplifyService _awsService;
  BackgroundLocationUtils locationUtils = BackgroundLocationUtils();

  @override
  void initState() {
    super.initState();

    locationUtils.initBackgroundLocation();

    _awsService = AmplifyService();
    _awsService.configure();
  }

  Future<void> _configureAws() async {
    await _awsService.configure();
  }

  Future<void> createRecord() async {
    await _awsService.createRecord();
  }

  int _selectedIndex = 2;
  bool started = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _tabs = [
    Tab1(),
    Tab2(),
    Tab3(),
    Tab2(),
    Tab1(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _test() {
    setState(() {
      if (started == false) {
        started = true;
        print(started);
        locationUtils.startLocationTimer(2);
      } else {
        started = false;
        print(started);
        locationUtils.stopLocationTimer();
      }
    });
    // createRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.green[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
      ),
      body: _tabs[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _test,
        child: Icon(started ? Icons.stop_circle : Icons.play_circle),
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  BackgroundLocationUtils locationUtils = BackgroundLocationUtils();

  void printIncCounter() {
    locationUtils.incrementCounter();
    print(locationUtils.getCounter());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber,
        child: Column(
          children: [
            Text('Tab 1 Content'),
            TextButton(
              child: Text("1"),
              onPressed: printIncCounter,
            )
          ],
        ));
  }
}

class Tab2 extends StatelessWidget {
  BackgroundLocationUtils locationUtils = BackgroundLocationUtils();

  void printIncCounter() {
    locationUtils.incrementCounter();
    print(locationUtils.getCounter());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber,
        child: Column(
          children: [
            Text('Tab 2 Content'),
            TextButton(
              child: Text("2"),
              onPressed: printIncCounter,
            )
          ],
        ));
  }
}

class Tab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WasteWalkMap(),
    );
  }
}
