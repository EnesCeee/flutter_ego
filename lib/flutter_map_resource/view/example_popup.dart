import 'package:flutter/material.dart';
import 'flutter_map_view.dart';

class ExamplePopup extends StatefulWidget {
  final BusMarker marker;
  const ExamplePopup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {
  @override
  Widget build(BuildContext context) {
    return Card(child: _cardDescription(context));
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Otobüs Detaylari!',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Position: ${widget.marker.point.latitude}, ${widget.marker.point.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Plaka No: ${widget.marker.plakaNo},',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Detay: ${widget.marker.detay}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Hiz: ${widget.marker.hiz}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Konum: ${widget.marker.konum}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Doluluk: ${widget.marker.doluluk}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
