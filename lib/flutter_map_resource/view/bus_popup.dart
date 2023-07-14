import 'package:flutter/material.dart';
import '../../product/widgets/bus_marker.dart';

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
            Text(
              'Otobüs Detaylari!',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text('Position: ${widget.marker.point.latitude}, ${widget.marker.point.longitude}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith()),
            Text(
              'Plaka No: ${widget.marker.plakaNo},',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(),
            ),
            Text(
              'Detay: ${widget.marker.detay}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(),
            ),
            Text(
              'Hiz: ${widget.marker.hiz}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(),
            ),
            Text(
              'Konum: ${widget.marker.konum}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(),
            ),
            Text(
              'Doluluk: ${widget.marker.doluluk}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
