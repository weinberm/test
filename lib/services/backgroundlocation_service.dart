import 'package:background_location/background_location.dart';
import 'dart:async';
import '../models/Coordinate.dart';

class BackgroundLocationService {
  static final BackgroundLocationService _instance =
      BackgroundLocationService._internal();

  // Hinzugefügt: Callback-Setter
  void set onNewCoordinate(void Function(Coordinate)? callback) {
    _instance._onNewCoordinate = callback;
  }

  BackgroundLocationService._internal();

  factory BackgroundLocationService() {
    return _instance;
  }

  void Function(Coordinate)? _onNewCoordinate;

  late Timer _locationTimer; // Timer für die Position

  void startLocationTimer() {
    const duration = Duration(seconds: 5);
    _locationTimer = Timer.periodic(duration, _updateLocationTimer);
  }

  void _updateLocationTimer(Timer timer) {
    BackgroundLocation().getCurrentLocation().then((location) {
      Coordinate newCord = Coordinate(
          longtitude: location.longitude, latitude: location.latitude);
      _onNewCoordinate?.call(newCord); // Callback auslösen
    });
  }

  Future<Coordinate> getCurrentPosition() async {
    final location = await BackgroundLocation().getCurrentLocation();
    final newCord = Coordinate(
      longtitude: location.longitude,
      latitude: location.latitude,
    );
    return newCord;
  }

  void stopLocationTimer() {
    _locationTimer.cancel();
  }

  void initBackgroundLocation() async {
    //Zeit der Aktualisierung
    BackgroundLocation.setAndroidConfiguration(100);
    //Wann trigger in m
    BackgroundLocation.startLocationService(distanceFilter: 10);
  }
}
