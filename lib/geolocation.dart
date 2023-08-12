import 'package:background_location/background_location.dart';

class BackgroundLocationUtils {
  static final BackgroundLocationUtils _instance =
      BackgroundLocationUtils._internal();

  int _counter = 0; // Der Counter

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

  void initBackgroundLocation() {
    BackgroundLocation.setAndroidConfiguration(100);
    BackgroundLocation.startLocationService(distanceFilter: 10);
  }
}
