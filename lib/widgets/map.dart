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

  // @override
  // void initState() {
  //   super.initState();

  //   locationUtils.onNewCoordinate = (Coordinate newCoordinate) {
  //     setState(() {
  //       print("Callback Map");
  //       print(newCoordinate);
  //       currentCoord = newCoordinate;
  //     });
  //   };
  // }
  LatLng? mapCenter = LatLng(48.7902398, 9.1830674);
  fm.MapOptions mapOptions = fm.MapOptions();
  test() {
    setState(() {
      mapCenter = LatLng(0, 0);
      print("TEST");
      mapOptions =
          fm.MapOptions(center: mapCenter, maxZoom: 30, minZoom: 10, zoom: 15);
      controller.move(mapCenter!, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    // LatLng? mapCenter =
    // LatLng(currentCoord.latitude!, currentCoord.longtitude!);
    mapOptions =
        fm.MapOptions(center: mapCenter, maxZoom: 30, minZoom: 10, zoom: 15);

    List<fm.Polyline> lines = [];
    fm.Polyline line = fm.Polyline(points: [
      LatLng(48.7902398, 9.1830674),
      LatLng(48.7902398, 9.1730674),
      LatLng(48.7902398, 9.1630674)
    ], color: Colors.green, strokeWidth: 6);

    // return Flexible(
    //   child: fm.FlutterMap(
    //     options: mapOptions,
    //     nonRotatedChildren: [
    //       fm.RichAttributionWidget(
    //         attributions: [
    //           fm.TextSourceAttribution(
    //             'OpenStreetMap contributors',
    //           ),
    //         ],
    //       ),
    //     ],
    //     children: [
    //       fm.TileLayer(
    //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //         userAgentPackageName: 'com.example.app',
    //       ),
    //       // fm.MarkerLayer(
    //       //   markers: markers,
    //       // ),
    //       fm.PolylineLayer(
    //         polylines: [line],
    //       )
    //     ],
    //   ),
    // );
    return Column(
      children: [
        Expanded(
            child: TextButton(
          child: Text("Test"),
          onPressed: test,
        )),
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
              // fm.MarkerLayer(
              //   markers: markers,
              // ),
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
