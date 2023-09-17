import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:waste_walking_ba/repositories/authentification_repository.dart';

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
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildMap(),
        ],
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return widget.mapViewModel.trackingActive
        ? AppBar(
            title: Center(
                child: Text(
                    '${widget.mapViewModel.formattedDuration}            0.00 km')))
        : null;
  }

  Widget _buildMap() {
    return Expanded(
      child: Stack(
        children: [
          // Ihr vorhandener Map-Code
          fm.FlutterMap(
            mapController: widget.mapViewModel.mapData.mapController,
            options: fm.MapOptions(
              center: const LatLng(48.7902398, 9.1830674),
              onPositionChanged: (position, hasGesture) =>
                  widget.mapViewModel.onPositionChanged(position, hasGesture),
            ),
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
            bottom: 80,
            right: 8,
            child: _buildMapControls(),
          ),
          Positioned(
            bottom: 16,
            right: (MediaQuery.of(context).size.width / 2) - 92,
            child: _buildTrackingButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        _buildLockButton(),
        const SizedBox(height: 8),
        _buildLayerButton(),
        const SizedBox(height: 8),
      ],
    );
  }

  ElevatedButton _buildLockButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
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
    );
  }

  Center _buildLayerButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
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
    );
  }

  Container _buildTrackingButton() {
    return Container(
      width: 184,
      height: 48,
      child: ElevatedButton(
        onPressed: () => _handleTrackingButtonPress(context),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // Abgerundete Ecken
            ),
            padding: const EdgeInsets.all(0),
            backgroundColor: widget.mapViewModel.trackingActive
                ? Colors.red
                : Color(0xFF35B05C),
            foregroundColor: Colors.white),
        child: _buildTrackingButtonContent(),
      ),
    );
  }

  Row _buildTrackingButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.mapViewModel.trackingActive
            ? const Text(
                "Walk beenden",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            : const Text(
                "Walk starten",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
        const SizedBox(width: 8),
        Icon(
          widget.mapViewModel.trackingActive
              ? Icons.stop_circle
              : Icons.play_circle,
          size: 40,
        )
      ],
    );
  }

  Future<void> _handleTrackingButtonPress(BuildContext context) async {
    if (await widget.mapViewModel.authentificationRepository.isUserSignedIn()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            text:
                'Sie müssen sich anmelden um diese Funktion nutzen zu können.',
            onPositiveButtonPressed: () {
              // Hier kannst du die Aktion für den positiven Button definieren

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
  }
}
