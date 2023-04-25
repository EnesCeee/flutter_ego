import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingBar extends StatefulWidget {
  final AnimationController controller;

  const LoadingBar({super.key, required this.controller});

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

const String _lottieBusLoader = "assets/lottie_bus_loader.json";

class _LoadingBarState extends State<LoadingBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        _lottieBusLoader,
        controller: widget.controller,
        onLoaded: (composition) {
          widget.controller
            ..duration = composition.duration
            ..forward()
            ..repeat();
        },
      ),
    );
  }
}
