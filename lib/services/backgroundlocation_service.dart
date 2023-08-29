// import 'package:background_location/background_location.dart';
import 'dart:async';
import '../models/Coordinate.dart';
import 'package:location/location.dart';

class BackgroundLocationService {
  static final BackgroundLocationService _instance =
      BackgroundLocationService._internal();

  int _counter = 0; // Der Counter
  Timer? _locationTimer; // Timer für die Position

  //Testing location library
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  List<Coordinate> cordList = [];

  Function(Coordinate)? onNewCoordinate;

  BackgroundLocationService._internal();

  factory BackgroundLocationService() {
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

  void clearCoordinateList() {
    cordList.clear();
  }

  // Funktion, um einen Timer für die Position zu starten
  void startLocationTimer(int seconds) {
    _locationTimer?.cancel(); // Timer stoppen, wenn bereits aktiv
    _locationTimer = Timer.periodic(Duration(seconds: seconds), (timer) {
      // Hier kannst du die Logik zum Abfragen der Position einfügen
      print("Timer Running");
      // BackgroundLocation().getCurrentLocation().then((location) {
      //   Coordinate newCord = Coordinate(
      //       longtitude: location.longitude, latitude: location.latitude);
      //   cordList.add(newCord);
      //   print(newCord);
      //   onNewCoordinate?.call(newCord); // Callback auslösen
      // });
      incrementCounter();
    });
  }

  // Funktion, um den Timer zu stoppen
  void stopLocationTimer() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  void initBackgroundLocation() async {
    // //Zeit der Aktualisierung
    // BackgroundLocation.setAndroidConfiguration(100);
    // //Wann trigger in m
    // BackgroundLocation.startLocationService(distanceFilter: 10);

    print("Starting BAckground Loc");
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.enableBackgroundMode(enable: true);
    location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 10);
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      Coordinate newCord = Coordinate(
          longtitude: currentLocation.longitude,
          latitude: currentLocation.latitude);
      cordList.add(newCord);
      print(newCord);
      onNewCoordinate?.call(newCord);
      print(currentLocation);
    });
  }
}
