import 'package:flutter/material.dart';
import 'package:flutter_ego/web_scrapping/web_scraping_service.dart';
import 'package:flutter_ego/web_scrapping/hat_model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
  });
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<HatModel>? _items;
  bool _isLoading = false;
  late final IScrape _scrape;

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchGetItemsScrape() async {
    _changeLoading();
    _items = await _scrape.scrapeWebsite();
    _changeLoading();
  }

  @override
  void initState() {
    super.initState();
    _scrape = Scrape();
    fetchGetItemsScrape();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [_isLoading ? const CircularProgressIndicator() : const SizedBox()],
        title: const Text("Hat List"),
      ),
      body: _items == null
          ? const Placeholder()
          : Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by Hat Numarasi or Hat Türü",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _items?.length??0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_items?[index].adi??""),
                        subtitle: Text(_items?[index].numarasi??""),
                        trailing: Text(_items?[index].turu??""),
                        leading: Text(_items?[index].uzunlugu??""),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
