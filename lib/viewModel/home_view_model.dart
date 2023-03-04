
import 'package:flutter/material.dart';
import '../view/home_view.dart';
import '../web_scrapping/hat_model.dart';
import '../web_scrapping/web_scraping_service.dart';

abstract class HomeViewModel extends State<HomePageView>{
  List<HatModel>? items;
  bool isLoading = false;
  late final IScrape _scrape;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchGetItemsScrape() async {
    changeLoading();
    items = await _scrape.scrapeWebsite();
    changeLoading();
  }

  @override
  void initState() {
    super.initState();
    _scrape = Scrape();
    fetchGetItemsScrape();
  }

  void searchFilter(String query) {
    if (items != null) {
      final suggestions = items?.where((hat) {
        final hatAdi = hat.adi.toLowerCase();
        final hatNumarasi = hat.numarasi.toLowerCase();
        final input = query.toLowerCase();
        return hatAdi.contains(input) || hatNumarasi.contains(input);
      }).toList();

      setState(() {
        items = suggestions;
      });
    }
  }
}