import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong2/latlong.dart';
import '../viewModel/bus_map_view_model.dart';
import 'example_popup.dart';

class FlutterMapView extends StatefulWidget {
  const FlutterMapView({super.key, required this.hatNumber});
  final String hatNumber;
  @override
  State<FlutterMapView> createState() => _FlutterMapViewState();
}

class _FlutterMapViewState extends State<FlutterMapView> {
  final _busMapViewModel = BusMapViewModel();
  Timer? _timer;
  final PopupController _popupLayerController = PopupController();

  @override
  void initState() {
    super.initState();
    _busMapViewModel.initState();

    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _busMapViewModel.fetch(widget.hatNumber);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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
                  onTap: (_, __) => _popupLayerController.hideAllPopups(),
                  zoom: 10,
                ),
                nonRotatedChildren: [
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  Observer(
                    builder: (context) => PopupMarkerLayerWidget(
                        options: PopupMarkerLayerOptions(
                            popupController: _popupLayerController,
                            markers: busMarkers(),
                            markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                            popupBuilder: (BuildContext context, Marker marker) => ExamplePopup(
                                  marker,
                                ),
                            selectedMarkerBuilder: (context, marker) => const Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Marker> busMarkers() {
    return [
      for (var e in _busMapViewModel.buses.skip(1))
        Marker(
          point: LatLng(double.parse(e.lat!), double.parse(e.lng!)),
          width: 30,
          height: 30,
          builder: (_) => const Icon(Icons.location_on, size: 40),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
    ];
  }
}
