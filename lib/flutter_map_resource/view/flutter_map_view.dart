import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  @override
  void initState() {
    super.initState();
    _busMapViewModel.initState();
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
                  Observer(builder: (_) {
                    return CircleLayer(
                      circles: [
                        CircleMarker(
                            point: LatLng(_busMapViewModel.latitude ?? 0, _busMapViewModel.longitude ?? 0), radius: 10)
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
