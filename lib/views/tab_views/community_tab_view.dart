import 'package:flutter/material.dart';
import '../../widgets/dialog.dart';

class CommunityTabView extends StatefulWidget {
  const CommunityTabView({super.key});

  @override
  State<CommunityTabView> createState() => _CommunityTabViewState();
}

class _CommunityTabViewState extends State<CommunityTabView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                text: 'Möchten Sie fortfahren?',
                onPositiveButtonPressed: () {
                  // Hier kannst du die Aktion für den positiven Button definieren
                  Navigator.pop(context); // Dialog schließen
                },
                onNegativeButtonPressed: () {
                  // Hier kannst du die Aktion für den negativen Button definieren
                  Navigator.pop(context); // Dialog schließen
                },
              );
            },
          );
        },
        child: Text('Zeige Dialog'),
      ),
    );
  }
}
