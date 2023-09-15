import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: selectedIndex == 0
              ? Icon(Icons.group, color: Colors.black)
              : Icon(Icons.group_outlined, color: Colors.black),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          activeIcon: Column(children: [
            Icon(Icons.leaderboard_outlined, color: Colors.black),
            Text("Active"),
            SizedBox(
              height: 8,
              child: Container(color: Colors.green),
            )
          ]),
          icon: selectedIndex == 1
              ? Icon(Icons.leaderboard, color: Colors.black)
              : Icon(Icons.leaderboard_outlined, color: Colors.black),
          label: 'Leaderboard',
        ),
        BottomNavigationBarItem(
          icon: selectedIndex == 2
              ? Icon(Icons.map, color: Colors.black)
              : Icon(Icons.map_outlined, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: selectedIndex == 3
                ? Icon(Icons.assignment, color: Colors.black)
                : Icon(Icons.assignment_outlined, color: Colors.black),
            label: 'History',
            backgroundColor: Colors.red),
      ],
      currentIndex: selectedIndex,
      selectedItemColor:
          Colors.black, // Ändern Sie dies zu der Farbe, die Sie möchten
      unselectedItemColor:
          Colors.grey, // Ändern Sie dies zu der Farbe, die Sie möchten
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
    );
  }
}
