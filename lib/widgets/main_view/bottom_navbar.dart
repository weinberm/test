import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 56,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TabBar(tabs: [
            Tab(
                child: Column(children: [
              Icon(Icons.group, color: Colors.black),
              Text(
                "Community",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ])),
            Tab(
                child: Column(children: [
              Icon(Icons.emoji_events, color: Colors.black),
              Text("Rangliste",
                  style: Theme.of(context).textTheme.headlineSmall),
            ])),
            Tab(
                child: Column(children: [
              Icon(Icons.map, color: Colors.black),
              Text("Karte", style: Theme.of(context).textTheme.headlineSmall),
            ])),
            Tab(
                child: Column(children: [
              Icon(Icons.feed, color: Colors.black),
              Text("Verlauf", style: Theme.of(context).textTheme.headlineSmall),
            ]))
          ])
        ]));
  }
}
