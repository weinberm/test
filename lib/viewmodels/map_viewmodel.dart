// Importiere erforderliche Pakete und Bibliotheken
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import '../models/Coordinate.dart';
import 'package:waste_walking_ba/services/backgroundlocation_service.dart';
import 'dart:async';

import 'package:waste_walking_ba/services/amplify_record_service.dart';
import '../services/amplify_auth_service.dart';

// Definiere die ViewModel-Klasse für die Kartenansicht
class MapViewModel extends ChangeNotifier {
  /// Initialisiere den Hintergrundortungsdienst für die Kartenansicht
  final BackgroundLocationService backgroundLocationService =
      BackgroundLocationService();

  AmplifyAuthService amplifyService = AmplifyAuthService();
  AmplifyRecordService amplifyRecordService = AmplifyRecordService();

  /// Erstelle eine Kartencontroller-Instanz
  MapController controller = MapController();

  /// Initialisiere die Polyline für die aktuelle Abfallwegroute und die Liste aller Abfallwegrouten
  fm.Polyline currentWasteWalkRoute = fm.Polyline(
    points: [],
    color: Colors.green,
    strokeWidth: 6,
    borderStrokeWidth: 6,
    borderColor: Colors.green,
  );
  List<fm.Polyline> wasteWalkRoutes = [];

  /// Initialisiere Marker für die aktuelle Position und den Startpunkt
  fm.Marker currentPosMarker = fm.Marker(
    point: LatLng(0, 0),
    width: 10,
    height: 10,
    builder: (context) => Icon(Icons.my_location),
  );
  fm.Marker startPosMarker = fm.Marker(
    point: LatLng(0, 0),
    width: 10,
    height: 10,
    builder: (context) => Icon(Icons.start),
  );

  /// Liste von Markern für verschiedene Punkte auf der Karte
  List<fm.Marker> markers = [];

  /// Zustandsvariablen für die Kartenansicht
  bool trackingActive = false;
  bool lockPositionValue = true;
  bool hideOtherWalks = false;

  /// Variablen für die Zeitmessung
  late DateTime startTime; // Setze das Startdatum
  late Timer _timer;
  Duration difference = Duration.zero;
  String formattedDuration = "0:00:00";

  double _currentZoom = 16; // Aktueller Karten-Zoom-Level

  late Coordinate lastCoordinate; // Die zuletzt erfasste Koordinate

  List<Coordinate> currentWasteWalkCoordinates = [];

  MapViewModel() {
    /// Initialisiere den Hintergrundortungsdienst und setze Callbacks
    backgroundLocationService.initBackgroundLocation();
    backgroundLocationService.onNewCoordinate =
        (newCoordinate) => proccessNewCoordinate(newCoordinate);
    backgroundLocationService.startLocationTimer();

    markers.add(currentPosMarker);
    wasteWalkRoutes.add(currentWasteWalkRoute);
  }

  /// Funktion zum Verarbeiten einer neuen Koordinate vom Ortungsdienst
  void proccessNewCoordinate(Coordinate newCoordinate) {
    /// Aktualisiere die Abfallwegroute, falls die Verfolgung aktiv ist
    if (trackingActive) {
      wasteWalkRoutes.remove(currentWasteWalkRoute);
      currentWasteWalkRoute.points
          .add(LatLng(newCoordinate.latitude!, newCoordinate.longtitude!));
      wasteWalkRoutes.add(currentWasteWalkRoute);
      currentWasteWalkCoordinates.add(newCoordinate);
    }

    /// Zentriere die Karte auf die aktuelle Position, wenn die Positionssperre aktiv ist
    if (lockPositionValue) {
      controller.move(
          LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
          _currentZoom);
    }

    /// Aktualisiere den aktuellen Positionsmarker
    markers.remove(currentPosMarker);
    currentPosMarker = fm.Marker(
      point: LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
      width: 10,
      height: 10,
      builder: (context) => Icon(Icons.my_location),
    );
    markers.add(currentPosMarker);

    lastCoordinate = newCoordinate;
    notifyListeners();
  }

  /// Funktion zum Aktivieren/Deaktivieren der Verfolgung
  void toggleTracking() async {
    if (!trackingActive) {
      startTimer();
      startPosMarker = fm.Marker(
        point: LatLng(lastCoordinate.latitude!, lastCoordinate.longtitude!),
        width: 10,
        height: 10,
        builder: (context) => Icon(Icons.start),
      );
      markers.add(startPosMarker);
    } else {
      stopTimer();
      markers.remove(startPosMarker);
      wasteWalkRoutes.remove(currentWasteWalkRoute);
      currentWasteWalkRoute.points.clear();

      String userId = await amplifyService.getCurrentUserId();
      amplifyRecordService.createRecord(currentWasteWalkCoordinates, userId);

      currentWasteWalkCoordinates.clear();
    }
    trackingActive = !trackingActive;
    notifyListeners();
  }

  /// Funktion zum Starten des Timers
  void startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, _updateTimer);
    startTime = DateTime.now();
  }

  /// Funktion zum Aktualisieren des Timerwerts
  void _updateTimer(Timer timer) {
    final currentTime = DateTime.now();
    difference = currentTime.difference(startTime);
    formattedDuration = difference.toString().split('.')[0];
    notifyListeners();
  }

  /// Funktion zum Stoppen des Timers
  void stopTimer() {
    _timer.cancel();
    formattedDuration = "0:00:00";
    notifyListeners();
  }

  /// Funktionen zum Sperren und Entsperren der Kartenposition
  void lockPosition() {
    lockPositionValue = true;
    notifyListeners();
  }

  void unlockPosition() {
    lockPositionValue = false;
    notifyListeners();
  }

  /// Funktion zum Ein- und Ausschalten des Ausblendens anderer Abfallwege
  void toggleHideOtherWalks() {
    hideOtherWalks = !hideOtherWalks;
    notifyListeners();
  }

  /// Wird aufgerufen, wenn die Kartenposition geändert wird
  void onPositionChanged(MapPosition position, bool hasGesture) {
    if (lockPositionValue && hasGesture) {
      unlockPosition();
    }
    _currentZoom = position.zoom!;
    // print("Center: ${position.center!.latitude} ${position.center!.longitude}");
    // print("Zoom: ${position.zoom}");
    // print(
    //     "Bounds: N${position.bounds!.north} E${position.bounds!.east} S${position.bounds!.south} W${position.bounds!.west}");
    // print("Has Gesture: $hasGesture");
  }
}
