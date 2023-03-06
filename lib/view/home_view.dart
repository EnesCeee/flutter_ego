import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../viewModel/home_view_model.dart';
import 'flutter_map_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
  });
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final _homeViewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    _homeViewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Observer(
            builder: (context) {
              return _homeViewModel.isLoading ? const CircularProgressIndicator() : const SizedBox();
            },
          )
        ],
        title: const Text("Hat List"),
      ),
      body: Observer(
        builder: (context) {
          return _homeViewModel.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          _homeViewModel.searchFilter(value);
                        },
                        decoration: const InputDecoration(
                          hintText: "Search by Hat Numarasi or Hat Türü",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _homeViewModel.filterSearch?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
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
                              subtitle: Text(_homeViewModel.filterSearch?[index].numarasi ?? ""),
                              trailing: Text(_homeViewModel.filterSearch?[index].turu ?? ""),
                              leading: Text(_homeViewModel.filterSearch?[index].uzunlugu ?? ""),
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
