import '../web_scrapping/hat_model.dart';
import '../web_scrapping/web_scraping_service.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  @observable
  List<HatModel>? items;

  @observable
  List<HatModel>? filterSearch;

  @observable
  bool isLoading = false;

  late final IScrape _scrape;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  Future<void> fetchGetItemsScrape() async {
    changeLoading();
    items = await _scrape.scrapeWebsite();
    filterSearch=await _scrape.scrapeWebsite();
    changeLoading();
  }

  void initState() {
    _scrape = Scrape();
    fetchGetItemsScrape();
  }

  @action
  void searchFilter(String query) {
    if (items != null) {
      final result = items?.where((hat) {
        final hatAdi = hat.adi.toLowerCase();
        final hatNumarasi = hat.numarasi.toLowerCase();
        final input = query.toLowerCase();
        return hatAdi.contains(input) || hatNumarasi.contains(input);
      }).toList();
      filterSearch = result;
    }
  }
}
