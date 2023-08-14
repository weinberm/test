import 'package:background_location/background_location.dart';
import 'dart:async';

import './models/Coordinate.dart';

class BackgroundLocationUtils {
  static final BackgroundLocationUtils _instance =
      BackgroundLocationUtils._internal();

  int _counter = 0; // Der Counter
  Timer? _locationTimer; // Timer für die Position

  List<Coordinate> cordList = [];

  Function(Coordinate)? onNewCoordinate;

  BackgroundLocationUtils._internal();

  factory BackgroundLocationUtils() {
    return _instance;
  }

  // Funktion, um den Counter zu erhöhen
  void incrementCounter() {
    _counter++;
  }

  // Funktion, um den aktuellen Counter-Wert abzurufen
  int getCounter() {
    return _counter;
  }

  List<Coordinate> getCoordinateList() {
    return cordList;
  }

  // Funktion, um einen Timer für die Position zu starten
  void startLocationTimer(int seconds) {
    _locationTimer?.cancel(); // Timer stoppen, wenn bereits aktiv
    _locationTimer = Timer.periodic(Duration(seconds: seconds), (timer) {
      // Hier kannst du die Logik zum Abfragen der Position einfügen
      print("Timer Running");
      BackgroundLocation().getCurrentLocation().then((location) {
        Coordinate newCord = Coordinate(
            longtitude: location.longitude, latitude: location.latitude);
        cordList.add(newCord);
        print(newCord);
        onNewCoordinate?.call(newCord); // Callback auslösen
      });
      incrementCounter();
    });
  }

  // Funktion, um den Timer zu stoppen
  void stopLocationTimer() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  void initBackgroundLocation() {
    //Zeit der Aktualisierung
    BackgroundLocation.setAndroidConfiguration(100);
    //Wann trigger in m
    BackgroundLocation.startLocationService(distanceFilter: 10);
  }
}
