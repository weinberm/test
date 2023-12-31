import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';
import 'package:waste_walking_ba/services/amplify_service.dart'; // Importieren Sie die AmplifyService Klasse
import 'package:waste_walking_ba/views/page_views/main_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Konfiguration von bevorzugten Orientierungen
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // Instanzieren Sie den AmplifyService
  final AmplifyService amplifyService = AmplifyService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: amplifyService.configureAmplify(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Amplify ist konfiguriert, App normal starten
          return MaterialApp(
              theme: ThemeData(
                colorScheme:
                    const ColorScheme.light(primary: Color(0xFF35B05C)),
                textTheme: const TextTheme(
                    headlineSmall:
                        TextStyle(fontSize: 10, color: Colors.black)),
                useMaterial3: true,
              ),
              home: DefaultTabController(
                initialIndex: 2,
                length: 4,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (context) => MainViewModel()),
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
              ));
        } else {
          // Warte-Bildschirm anzeigen, während die Konfiguration abgeschlossen wird
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
