import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';

import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';

import '../../widgets/dialog.dart';

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
      body: Stack(
        children: [
          fm.FlutterMap(
            mapController: widget.mapViewModel.mapData.mapController,
            options: fm.MapOptions(
              center: LatLng(48.7902398, 9.1830674),
              onPositionChanged: (position, hasGesture) =>
                  widget.mapViewModel.onPositionChanged(position, hasGesture),
            ),
            nonRotatedChildren: [
              fm.RichAttributionWidget(
                attributions: [
                  fm.TextSourceAttribution(
                    'OpenStreetMap contributors',
                  ),
                ],
              ),
            ],
            children: [
              fm.TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      await widget.mapViewModel.amplifyService.isUserSignedIn();
                      if (!widget.mapViewModel.amplifyService.signedIn) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              text:
                                  'Sie müssen sich anmelden um diese Funktion nutzen zu können.',
                              onPositiveButtonPressed: () {
                                // Hier kannst du die Aktion für den positiven Button definieren
                                widget.mapViewModel.amplifyService.signInUser();
                                Navigator.pop(context); // Dialog schließen
                              },
                              onNegativeButtonPressed: () {
                                // Hier kannst du die Aktion für den negativen Button definieren
                                Navigator.pop(context); // Dialog schließen
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
                                  Navigator.pop(context); // Dialog schließen
                                },
                                onNegativeButtonPressed: () {
                                  // Hier kannst du die Aktion für den negativen Button definieren
                                  Navigator.pop(context); // Dialog schließen
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
                                  Navigator.pop(context); // Dialog schließen
                                },
                                onNegativeButtonPressed: () {
                                  // Hier kannst du die Aktion für den negativen Button definieren
                                  Navigator.pop(context); // Dialog schließen
                                },
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Icon(widget.mapViewModel.trackingActive
                        ? Icons.stop_circle
                        : Icons.play_circle),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: ElevatedButton(
                    onPressed: () => {
                      if (widget.mapViewModel.lockPositionValue)
                        {widget.mapViewModel.unlockPosition()}
                      else
                        {widget.mapViewModel.lockPosition()}
                    },
                    child: Icon(widget.mapViewModel.lockPositionValue
                        ? Icons.gps_off
                        : Icons.location_searching),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    child: Center(
                  child: ElevatedButton(
                    onPressed: widget.mapViewModel.toggleHideOtherWalks,
                    child: Icon(widget.mapViewModel.hideOtherWalks
                        ? Icons.layers
                        : Icons.layers_clear),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
