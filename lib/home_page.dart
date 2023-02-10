import 'package:flutter/material.dart';
import 'package:flutter_ego/web_scrapping/web_scraping.dart';
import 'package:flutter_ego/web_scrapping/hat_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class HomePageView extends StatefulWidget {
  const HomePageView({super.key, });
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String? _searchString;
  List<Hat>? _filteredHatList;

  @override
  void initState() {
    super.initState();
    scrapeWebsite().then((value) {
      if (value != null) {
        setState(() {
          _filteredHatList = value;
        });
      }
    });
  }

  void _filterList(String value) {
    setState(() {
      _searchString = value;
      _filteredHatList = _filteredHatList
        ?.where((hat) => hat.numarasi.contains(_searchString!) || hat.turu.contains(_searchString!))
        .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hat List"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _filterList(value),
              decoration: const InputDecoration(
                hintText: "Search by Hat Numarası or Hat Türü",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredHatList?.length,
              itemBuilder: (context, index) {
                final hat = _filteredHatList![index];
                return ListTile(
                  title: Text(hat.adi),
                  subtitle: Text(hat.numarasi),
                  trailing: Text(hat.turu),
                  leading: Text(hat.uzunlugu),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
