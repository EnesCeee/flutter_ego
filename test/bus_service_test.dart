// Import the test package and Counter class
import 'package:dio/dio.dart';
import 'package:flutter_ego/flutter_map_resource/model/bus_model.dart';
import 'package:flutter_ego/flutter_map_resource/service/bus_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import the class under test

// Import the generated file
import 'bus_service_test.mocks.dart';

// Generate a MockDio using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([Dio])
void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  group('BusService', () {
    test('returns a list of Table if the http call completes successfully', () async {
      // Arrange
      final dio = MockDio();
      final busService = BusService(dio);
      // Use Mockito to return a successful response when it calls the
      // provided Dio.
      when(dio.get('101'))
          .thenAnswer((_) async => Response(data: '''
          {"data":[{"table":['arac_no':'07-158','plaka_no':'06 BG 3505','lat':'39.795977','lng':'32.797097','hiz':'40 km','durak_no':'11166','onceki_durak_no':'11177','hat_no':'101','durak_sira_no':'52','aci':'42','doluluk':'Dolu','saniye':'999999','sure':'T.V.Süresi','secili_durak_no':'','secili_durak_sira_no':'1','yon':'1','konum':'Karşıyaka Mh.Haymana Yolu Blv.Gölbaşı','detay':'MAN 2007, Solo, Engelli, Kapasite  Kişi']}]}
          ''', statusCode: 200, requestOptions: RequestOptions(
            baseUrl: "http://88.255.141.66/mblSrv1/service.asp?FNC=Otobus&PRM=&VER=3.1.0&LAN=tr&TST=&HAT=",
            headers: {"User-Agent": "EGO Genel Mudurlugu-EGO Cepte-3.1.0 R16NM.G950FXXU4CRL3 8.0.0"}
          )));

      // Act
      final tableList = await busService.fetchBusItem('101');

      // Assert
      expect(tableList, isA<List<Table>>());
      expect(tableList?.length, equals(1));
      expect(tableList![0].hatNo, equals('101'));
      // Verify that the dio.get method was called once with the correct URL.
      verify(dio.get('101'));
      // Verify that no other methods were called on the dio.
      verifyNoMoreInteractions(dio);
    });

    test('returns null if the http call fails', () {
      // Arrange
      final dio = MockDio();
      final busService = BusService(dio);
      // Use Mockito to return an unsuccessful response when it calls the
      // provided Dio.
      when(dio.get('101'))
          .thenAnswer((_) async => Response(data: 'Not Found', statusCode: 404, requestOptions: RequestOptions(
            baseUrl: "http://88.255.141.66/mblSrv1/service.asp?FNC=Otobus&PRM=&VER=3.1.0&LAN=tr&TST=&HAT=",
            headers: {"User-Agent": "EGO Genel Mudurlugu-EGO Cepte-3.1.0 R16NM.G950FXXU4CRL3 8.0.0"}
          )));

      // Act
      expect(busService.fetchBusItem('101'), equals(null));

      // Assert
      // Verify that the dio.get method was called once with the correct URL.
      verify(dio.get('101'));
      // Verify that no other methods were called on the dio.
      verifyNoMoreInteractions(dio);
    });
  });
}
