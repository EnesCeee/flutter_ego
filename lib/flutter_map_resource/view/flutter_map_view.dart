import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong2/latlong.dart';
import '../../product/widgets/bus_marker.dart';
import '../viewModel/bus_map_view_model.dart';
import 'bus_popup.dart';
import 'dart:math' as math;

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
  final String busImage = "assets/bus.png";

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
      appBar: AppBar(
          bottomOpacity: 0.5,
          elevation: 4,
          shadowColor: Colors.blueAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          title: const Text('Otobüs Nerede? - Ankara')),
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
                      markerRotate: false,
                      markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                      popupBuilder: (BuildContext context, Marker marker) => ExamplePopup(
                        marker as BusMarker,
                      ),
                      selectedMarkerBuilder: (context, marker) => marker.builder(context),
                    )),
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
          width: 60,
          height: 100,
          builder: (context) {
            // create a Transform.rotate widget that rotates the Icon widget
            final double rotation = double.parse(e.aci ?? "0"); // assume 0 if rotation data is not available
            return Transform.rotate(
              angle: rotation * math.pi / 180, // convert degrees to radians
              child: Image.asset(busImage, width: 100, height: 100),
            );
          },
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
    ];
  }
}
