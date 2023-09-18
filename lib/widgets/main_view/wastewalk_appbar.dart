import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_walking_ba/viewmodels/login_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/views/page_views/login_view.dart';

class WasteWalkAppBar extends StatefulWidget implements PreferredSizeWidget {
  final MainViewModel mainViewModel;

  WasteWalkAppBar({required this.mainViewModel});

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  State<WasteWalkAppBar> createState() => _WasteWalkAppBarState();
}

class _WasteWalkAppBarState extends State<WasteWalkAppBar> {
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 300,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage("assets/logo/ww-logo.png"),
            width: 40,
            height: 40,
          ),
          Row(children: [
            widget.mainViewModel.authentificationRepository.isSignedIn
                ? ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () async {
                          final success = await widget
                              .mainViewModel.authentificationRepository
                              .signOutCurrentUser();
                          if (success) {
                            widget.mainViewModel.update();
                          }
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: imageUrl == null
                              ? const Icon(Icons.person, size: 24)
                              : null,
                        ),
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (context) => LoginViewModel(),
                              builder: (context, child) {
                                return LoginView(
                                    viewModel:
                                        Provider.of<LoginViewModel>(context));
                              }),
                        ),
                      );

                      if (result == 'logged_in') {
                        widget.mainViewModel.update();
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Anmelden",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
            MenuAnchor(
              menuChildren: const [
                MenuItemButton(
                    child: Row(
                  children: [
                    Icon(Icons.help),
                    SizedBox(width: 16),
                    Text("Hilfe")
                  ],
                )),
                MenuItemButton(
                    child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 16),
                    Text("Einstellungen")
                  ],
                ))
              ],
              builder: (context, controller, child) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Show menu',
                );
              },
            )
          ]),
        ],
      ),
    );
  }
}
