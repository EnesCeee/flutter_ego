import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
