import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';

class WasteWalkMap extends StatefulWidget {
  const WasteWalkMap({super.key});

  @override
  State<WasteWalkMap> createState() => _WasteWalkMapState();
}

class _WasteWalkMapState extends State<WasteWalkMap> {
  @override
  Widget build(BuildContext context) {
    LatLng? mapCenter = LatLng(48.7902398, 9.1830674);
    fm.MapOptions mapOptions =
        fm.MapOptions(center: mapCenter, maxZoom: 30, minZoom: 10, zoom: 15);

    List<fm.Polyline> lines = [];
    fm.Polyline line = fm.Polyline(points: [
      LatLng(48.7902398, 9.1830674),
      LatLng(48.7902398, 9.1730674),
      LatLng(48.7902398, 9.1630674)
    ], color: Colors.green, strokeWidth: 6);

    return Flexible(
        child: fm.FlutterMap(
      options: mapOptions,
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
        //   markers: markers,
        // ),
        fm.PolylineLayer(
          polylines: [line],
        )
      ],
    ));
  }
}
