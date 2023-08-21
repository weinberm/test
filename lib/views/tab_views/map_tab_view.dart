import 'package:flutter/material.dart';

import 'package:waste_walking_ba/viewmodels/main_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/map_viewmodel.dart';

import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';

class MapTabView extends StatelessWidget {
  const MapTabView({required this.mapViewModel});

  final MapViewModel mapViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mapViewModel.trackingActive
          ? AppBar(
              title: Center(
                  child: Text(
                      '${mapViewModel.formattedDuration}            0.00 km')))
          : null, // Hier füge die AppBar hinzu
      body: Stack(
        children: [
          fm.FlutterMap(
            mapController: mapViewModel.controller,
            options: fm.MapOptions(center: LatLng(48.7902398, 9.1830674)),
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
              // fm.MarkerLayer(
              //   markers: [marker],
              // ),
              // fm.PolylineLayer(
              //   polylines: [line],
              // )
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
                    onPressed: mapViewModel.startTracking,
                    child: Icon(mapViewModel.trackingActive
                        ? Icons.stop_circle
                        : Icons.play_circle),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: ElevatedButton(
                    onPressed: mapViewModel.toggleLockPosition,
                    child: Icon(mapViewModel.lockPosition
                        ? Icons.location_searching
                        : Icons.gps_off),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    child: Center(
                  child: ElevatedButton(
                    onPressed: mapViewModel.toggleHideOtherWalks,
                    child: Icon(mapViewModel.hideOtherWalks
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
