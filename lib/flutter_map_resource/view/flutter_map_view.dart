import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../viewModel/bus_map_view_model.dart';

class FlutterMapView extends StatefulWidget {
  const FlutterMapView({super.key, required this.hatNumber});
  final String hatNumber;
  @override
  State<FlutterMapView> createState() => _FlutterMapViewState();
}

class _FlutterMapViewState extends State<FlutterMapView> {
  final _busMapViewModel = BusMapViewModel();
  final MapController _mapController = MapController();
  StreamSubscription<Position>? _positionStreamSubscription;
  List<Marker> userMarkers = [];

  @override
  void initState() {
    super.initState();
    _busMapViewModel.initState();
    getListenLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _positionStreamSubscription?.cancel();
  }

  Future<void> getListenLocation() async {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10),
    ).listen((Position position) {
      LatLng latLng = LatLng(position.latitude, position.longitude);
      _mapController.move(latLng, 13.0);
      Marker marker = Marker(
        width: 80.0,
        height: 80.0,
        point: latLng,
        builder: (ctx) => const Icon(
          Icons.location_on_rounded,
          size: 50.0,
          color: Colors.red,
        ),
      );
      setState(() {
        userMarkers.clear();
        userMarkers.add(marker);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  zoom: 5,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: () {},
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  // MarkerLayer(markers: userMarkers),
                  userLocation()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget userLocation() {
  return CurrentLocationLayer(
    followOnLocationUpdate: FollowOnLocationUpdate.always,
    turnOnHeadingUpdate: TurnOnHeadingUpdate.always,
    style: LocationMarkerStyle(
      marker: const DefaultLocationMarker(
        child: Icon(
          Icons.navigation,
          color: Colors.white,
        ),
      ),
      markerSize: const Size(30, 30),
      accuracyCircleColor: Colors.green.withOpacity(0.1),
      headingSectorColor: Colors.green.withOpacity(0.8),
      markerDirection: MarkerDirection.heading,
    ),
    moveAnimationDuration: Duration.zero,
  );
}
