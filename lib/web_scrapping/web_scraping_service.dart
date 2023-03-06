import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'hat_model.dart';

abstract class IScrape {
  Future<List<HatModel>> scrapeWebsite();
}

class Scrape implements IScrape {
  @override
  Future<List<HatModel>> scrapeWebsite() async {
    final List<HatModel> hatList = [];
    final url = Uri.parse('http://map.ego.gov.tr:8080/ego/hatListesi.aspx');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final document = parse(response.body);
      final table = document.getElementsByTagName('table')[0];
      final rows = table.getElementsByTagName('tr');
      for (var i = 1; i < rows.length; i++) {
        final cells = rows[i].getElementsByTagName('td');
        if (cells.isNotEmpty&&cells.length>=4) {
          final hatNumarasi = cells[0].text;
          final hatAdi = cells[1].text;
          final hatTuru = cells[2].text;
          final hatUzunlugu = cells[3].text;
          final hat = HatModel(numarasi: hatNumarasi, adi: hatAdi, turu: hatTuru, uzunlugu: hatUzunlugu);
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
