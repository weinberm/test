import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import '../../widgets/shared/dialog.dart';

class CommunityTabView extends StatelessWidget {
  const CommunityTabView({required this.mainViewModel});

  final MainViewModel mainViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: mainViewModel.amplifyService.signInUser,
            child: Text("Sign In")),
        TextButton(
            onPressed: mainViewModel.amplifyService.isUserSignedIn,
            child: Text("Sign In ?")),
        TextButton(
            onPressed: mainViewModel.amplifyService.confirmNewPassword,
            child: Text("Confirm new pass")),
        TextButton(
            onPressed: mainViewModel.amplifyService.signOutCurrentUser,
            child: Text("Sign out ")),
        TextButton(
            onPressed: mainViewModel.amplifyService.getCurrentUser,
            child: Text("Get USer ")),
        TextButton(
            onPressed:
                mainViewModel.amplifyWasteWalkRecordService.queryListItems,
            child: Text("Fetch ")),
        Text(mainViewModel.amplifyService.signedIn.toString()),
        Center(
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
        )
      ],
    );
  }
}
