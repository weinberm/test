import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';

import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';

import '../../widgets/shared/dialog.dart';

class MapTabView extends StatefulWidget {
  final MapViewModel mapViewModel;

  MapTabView({required this.mapViewModel});

  @override
  _MapTabViewState createState() => _MapTabViewState();
}

class _MapTabViewState extends State<MapTabView> {
  @override
  void dispose() {
    widget.mapViewModel.onWidgetDisposed();
    super.dispose();
  }

  @override
  void initState() {
    widget.mapViewModel.onWidgetInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.mapViewModel.trackingActive
            ? AppBar(
                title: Center(
                    child: Text(
                        '${widget.mapViewModel.formattedDuration}            0.00 km')))
            : null, // Hier füge die AppBar hinzu
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  fm.FlutterMap(
                    mapController: widget.mapViewModel.mapData.mapController,
                    options: fm.MapOptions(
                      center: LatLng(48.7902398, 9.1830674),
                      onPositionChanged: (position, hasGesture) => widget
                          .mapViewModel
                          .onPositionChanged(position, hasGesture),
                    ),
                    children: [
                      fm.TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      fm.PolylineLayer(
                        polylines: widget.mapViewModel.mapData.wasteWalkRoutes,
                      ),
                      fm.MarkerLayer(
                        markers: widget.mapViewModel.mapData.markers,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    right: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(16),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () => {
                              if (widget.mapViewModel.lockPositionValue)
                                {widget.mapViewModel.unlockPosition()}
                              else
                                {widget.mapViewModel.lockPosition()}
                            },
                            child: Icon(
                                widget.mapViewModel.lockPositionValue
                                    ? Icons.gps_off
                                    : Icons.location_searching,
                                size: 24),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                            child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(16),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: widget.mapViewModel.toggleshowOtherWalks,
                            child: Icon(
                              widget.mapViewModel.showOtherWalks
                                  ? Icons.layers
                                  : Icons.layers_clear,
                              size: 24,
                            ),
                          ),
                        )),
                        SizedBox(height: 8),
                        Container(
                          width: 48, // Breite des Containers
                          height: 48, // Höhe des Containers
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Abgerundete Ecken
                                ),
                                padding: EdgeInsets.all(0),
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFF35B05C)),
                            onPressed: () async {
                              await widget.mapViewModel.amplifyService
                                  .isUserSignedIn();
                              if (!widget
                                  .mapViewModel.amplifyService.signedIn) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      text:
                                          'Sie müssen sich anmelden um diese Funktion nutzen zu können.',
                                      onPositiveButtonPressed: () {
                                        // Hier kannst du die Aktion für den positiven Button definieren
                                        widget.mapViewModel.amplifyService
                                            .signInUser();
                                        Navigator.pop(
                                            context); // Dialog schließen
                                      },
                                      onNegativeButtonPressed: () {
                                        // Hier kannst du die Aktion für den negativen Button definieren
                                        Navigator.pop(
                                            context); // Dialog schließen
                                      },
                                    );
                                  },
                                );
                              } else {
                                if (!widget.mapViewModel.trackingActive) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        text: 'Möchten Sie fortfahren?',
                                        onPositiveButtonPressed: () {
                                          // Hier kannst du die Aktion für den positiven Button definieren
                                          widget.mapViewModel.startTracking();
                                          Navigator.pop(
                                              context); // Dialog schließen
                                        },
                                        onNegativeButtonPressed: () {
                                          // Hier kannst du die Aktion für den negativen Button definieren
                                          Navigator.pop(
                                              context); // Dialog schließen
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        text: 'Möchten Sie beenden?',
                                        onPositiveButtonPressed: () {
                                          // Hier kannst du die Aktion für den positiven Button definieren
                                          widget.mapViewModel.stopTracking();
                                          Navigator.pop(
                                              context); // Dialog schließen
                                        },
                                        onNegativeButtonPressed: () {
                                          // Hier kannst du die Aktion für den negativen Button definieren
                                          Navigator.pop(
                                              context); // Dialog schließen
                                        },
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Icon(
                                widget.mapViewModel.trackingActive
                                    ? Icons.stop_circle
                                    : Icons.play_circle,
                                size: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
