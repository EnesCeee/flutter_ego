import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
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
  late FollowOnLocationUpdate _followOnLocationUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _busMapViewModel.initState();
    _followOnLocationUpdate = FollowOnLocationUpdate.always;
    _followCurrentLocationStreamController = StreamController<double?>();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _busMapViewModel.fetch(widget.hatNumber);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _followCurrentLocationStreamController.close();
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
                        // Follow the location marker on the map when location updated until user interact with the map.
                        setState(
                          () => _followOnLocationUpdate = FollowOnLocationUpdate.always,
                        );
                        // Follow the location marker on the map and zoom the map to level 20.
                        _followCurrentLocationStreamController.add(15);
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
                  Observer(
                    builder: (context) => MarkerLayer(
                        markers: _busMapViewModel.buses.skip(1).map(
                      (e) {
                        return Marker(
                          height: 30,
                          width: 30,
                          point: LatLng(double.parse(e.lat!), double.parse(e.lng!)),
                          builder: (context) => const BusWidget(),
                        );
                      },
                    ).toList()),
                  ),
                  CurrentLocationLayer(
                    followCurrentLocationStream: _followCurrentLocationStreamController.stream,
                    followOnLocationUpdate: _followOnLocationUpdate,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusWidget extends StatelessWidget {
  const BusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.directions_bus,
        color: Colors.redAccent,
        size: 30,
      ),
      onPressed: () {},
    );
  }
}
