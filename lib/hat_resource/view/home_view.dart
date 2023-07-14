import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../product/widgets/loading_bar.dart';
import '../viewModel/home_view_model.dart';
import '../../flutter_map_resource/view/flutter_map_view.dart';
import 'package:lottie/lottie.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
  });
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with TickerProviderStateMixin {
  final _homeViewModel = HomeViewModel();
  late AnimationController _controller;
  final String _lottieBusIcon = "assets/lottie_bus_icon.json";
  @override
  void initState() {
    super.initState();
    _homeViewModel.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
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
        title: const Text("Otobüs nerede? - Ankara"),
        actions: [
          Lottie.asset(
            _lottieBusIcon,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward()
                ..repeat();
            },
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          return _homeViewModel.isLoading
              ? LoadingBar(
                  controller: _controller,
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.5),
                        onChanged: (value) {
                          _homeViewModel.searchFilter(value);
                        },
                        strutStyle: const StrutStyle(height: 1.5),
                        cursorWidth: 3,
                        cursorHeight: 30,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Hat Numarasi veya Hat Türü Giriniz",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    const Card(
                      shadowColor: Colors.redAccent,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )),
                      child: ListTile(
                        title: Center(child: Text("(Hat Numarası)       -      HAT ADI")),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _homeViewModel.filterSearch?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: Colors.redAccent,
                            elevation: 4,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return FlutterMapView(
                                          hatNumber: _homeViewModel.filterSearch?[index].numarasi ?? "");
                                    },
                                  ));
                                });
                              },
                              title: Text(_homeViewModel.filterSearch?[index].adi ?? ""),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
