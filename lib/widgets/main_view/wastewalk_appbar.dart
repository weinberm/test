import 'package:flutter/material.dart';

class WasteWalkAppBar extends StatefulWidget implements PreferredSizeWidget {
  const WasteWalkAppBar({super.key});

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  State<WasteWalkAppBar> createState() => _WasteWalkAppBarState();
}

class _WasteWalkAppBarState extends State<WasteWalkAppBar> {
  bool isLoggedIn = false;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage("assets/logo/ww-logo.png"),
            width: 40,
            height: 40,
          ),
          Row(children: [
            isLoggedIn
                ? ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          print("OpenProfile");
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
                    onPressed: () => {},
                    child: const Text(
                      "Anmelden",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
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

// As Stateless Widget
// import 'package:flutter/material.dart';

// class WasteWalkAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const WasteWalkAppBar({Key? key}) : super(key: key);

//   @override
//   Size get preferredSize => Size.fromHeight(60); // Sie hatten toolbarHeight auf 60 gesetzt

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       toolbarHeight: 60,
//       title: const Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image(
//             image: AssetImage("assets/logo/ww-logo.png"),
//             width: 40,
//             height: 40,
//           ), // Ihr zentrales Icon
//         ],
//       ),
//     );
//   }