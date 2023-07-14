// Import the test package and Counter class
import 'package:flutter_ego/hat_resource/model/hat_model.dart';
import 'package:flutter_ego/hat_resource/service/web_scraping_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import the class under test

// Import the generated file
import 'web_scrape_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  group('Scrape', () {
    test('returns a list of HatModel if the http call completes successfully', () async {
      // Arrange
      final client = MockClient();
      final scrape = Scrape();
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://www.ego.gov.tr/AjaxData/HatListesi')))
          .thenAnswer((_) async => http.Response('''
          <option value="0">Seçiniz</option>
          <option value="100">100 - KIZILAY - ERYAMAN 5</option>
          <option value="101">101 - KIZILAY - ERYAMAN 5</option>
          <option value="102">102 - KIZILAY - ERYAMAN 5</option>
          ''', 200));

      // Act
      final hatList = await scrape.scrapeWebsite();

      // Assert
      expect(hatList, isA<List<HatModel>>());
      expect(hatList.length, equals(3));
      expect(hatList[0].numarasi, equals('100'));
      expect(hatList[0].adi, equals('100 - KIZILAY - ERYAMAN 5'));
      // Verify that the client.get method was called once with the correct URL.
      verify(client.get(Uri.parse('https://www.ego.gov.tr/AjaxData/HatListesi')));
      // Verify that no other methods were called on the client.
      verifyNoMoreInteractions(client);
    });

    test('throws an exception if the http call fails', () {
      // Arrange
      final client = MockClient();
      final scrape = Scrape();
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://www.ego.gov.tr/AjaxData/HatListesi')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      expect(scrape.scrapeWebsite(), throwsException);

      // Assert
      // Verify that the client.get method was called once with the correct URL.
      verify(client.get(Uri.parse('https://www.ego.gov.tr/AjaxData/HatListesi')));
      // Verify that no other methods were called on the client.
      verifyNoMoreInteractions(client);
    });
  });
}
