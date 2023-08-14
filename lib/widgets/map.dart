import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import '../geolocation.dart';
import '../models/Coordinate.dart';

class WasteWalkMap extends StatefulWidget {
  const WasteWalkMap({super.key});

  @override
  State<WasteWalkMap> createState() => _WasteWalkMapState();
}

class _WasteWalkMapState extends State<WasteWalkMap> {
  BackgroundLocationUtils locationUtils = BackgroundLocationUtils();
  Coordinate currentCoord = Coordinate(latitude: 0, longtitude: 0);
  MapController controller = MapController();

  fm.Marker marker = fm.Marker(
    point: LatLng(0, 0),
    width: 10,
    height: 10,
    builder: (context) => Icon(Icons.my_location),
  );

  fm.Polyline line =
      fm.Polyline(points: [], color: Colors.green, strokeWidth: 6);

  @override
  void initState() {
    super.initState();

    locationUtils.onNewCoordinate = (Coordinate newCoordinate) {
      setState(() {
        print("Callback Map");
        print(newCoordinate);
        //TODO get Current Zoom?
        controller.move(
            LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
            controller.zoom);
        marker = fm.Marker(
          point: LatLng(newCoordinate.latitude!, newCoordinate.longtitude!),
          width: 10,
          height: 10,
          builder: (context) => Icon(Icons.my_location),
        );
        line.points
            .add(LatLng(newCoordinate.latitude!, newCoordinate.longtitude!));
        print(line.points);
      });
    };
  }

  //TODO init map and get current pos for start of map
  LatLng? mapCenter = LatLng(48.7902398, 9.1830674);
  fm.MapOptions mapOptions = fm.MapOptions();

  // LatLng? mapCenter =
  // LatLng(currentCoord.latitude!, currentCoord.longtitude!);
  // mapOptions =
  //     fm.MapOptions(center: mapCenter, maxZoom: 30, minZoom: 10, zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: fm.FlutterMap(
            mapController: controller,
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
              fm.MarkerLayer(
                markers: [marker],
              ),
              fm.PolylineLayer(
                polylines: [line],
              )
            ],
          ),
        )
      ],
    );
  }
}
