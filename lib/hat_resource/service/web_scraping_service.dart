import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../model/hat_model.dart';

abstract class IScrape {
  Future<List<HatModel>> scrapeWebsite();
}

class Scrape implements IScrape {
  @override
  Future<List<HatModel>> scrapeWebsite() async {
    final List<HatModel> hatList = [];
    final url = Uri.parse('https://www.ego.gov.tr/AjaxData/HatListesi');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final document = parse(response.body);
      var optionElements = document.querySelectorAll('option').skip(1);

      for (var element in optionElements) {
        var value = element.attributes['value'];
        var text = element.text;

        if (value != null) {
          final hatNumarasi = value;
          final hatAdi = text;
          final hat = HatModel(numarasi: hatNumarasi, adi: hatAdi);
          hatList.add(hat);
        }
      }

      return hatList;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return hatList;
    }
  }
}
