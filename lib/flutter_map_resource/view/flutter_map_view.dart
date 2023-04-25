import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong2/latlong.dart';
import '../viewModel/bus_map_view_model.dart';
import 'bus_popup.dart';

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
  late MapController _mapController;
  late FollowOnLocationUpdate _followOnLocationUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();
    _busMapViewModel.initState();
    _mapController = MapController();
    _followOnLocationUpdate = FollowOnLocationUpdate.always;
    _followCurrentLocationStreamController = StreamController<double?>();
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
      appBar: AppBar(title: const Text('Otobüs Nerede? - Ankara')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  onTap: (_, __) => _popupLayerController.hideAllPopups(),
                  zoom: 10,
                  onPositionChanged: (MapPosition position, bool hasGesture) {
                    if (hasGesture && _followOnLocationUpdate != FollowOnLocationUpdate.never) {
                      setState(
                        () => _followOnLocationUpdate = FollowOnLocationUpdate.never,
                      );
                    }
                  },
                ),
                nonRotatedChildren: [
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(
                          () => _followOnLocationUpdate = FollowOnLocationUpdate.always,
                        );
                      },
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
                  CurrentLocationLayer(
                    followCurrentLocationStream: _followCurrentLocationStreamController.stream,
                    followOnLocationUpdate: _followOnLocationUpdate,
                  ),
                  Observer(
                    builder: (context) => PopupMarkerLayerWidget(
                        options: PopupMarkerLayerOptions(
                            popupController: _popupLayerController,
                            markers: busMarkers(),
                            markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                            popupBuilder: (BuildContext context, Marker marker) => ExamplePopup(
                                  marker as BusMarker,
                                ),
                            selectedMarkerBuilder: (context, marker) => const Icon(
                                  Icons.directions_bus_rounded,
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

  List<BusMarker> busMarkers() {
    return [
      for (var e in _busMapViewModel.buses.skip(1))
        BusMarker(
          konum: e.konum,
          detay: e.detay,
          plakaNo: e.plakaNo,
          hiz: e.hiz,
          doluluk: e.doluluk,
          aracNo: e.aracNo, // assign the busNo property here
          point: LatLng(double.parse(e.lat ?? '0'), double.parse(e.lng ?? '0')),
          width: 30,
          height: 30,
          builder: (_) => const Icon(Icons.directions_bus_rounded, size: 40),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
    ];
  }
}

class BusMarker extends Marker {
  String? aracNo;
  String? detay;
  String? plakaNo;
  String? hiz;
  String? doluluk;
  String? konum;
  BusMarker({
    required this.aracNo,
    required this.doluluk,
    required LatLng point,
    required this.detay,
    required this.plakaNo,
    required this.hiz,
    required this.konum,
    required WidgetBuilder builder,
    double width = 30.0,
    double height = 30.0,
    AnchorPos? anchorPos,
  }) : super(
          point: point,
          builder: builder,
          width: width,
          height: height,
          anchorPos: anchorPos,
        );
}
