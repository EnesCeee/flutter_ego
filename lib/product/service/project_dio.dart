import 'package:dio/dio.dart';

class ProjectDioMixin {
  final service = Dio(BaseOptions(baseUrl: 'http://88.255.141.66/mblSrv1/service.asp?FNC=Otobus&PRM=&VER=3.1.0&LAN=tr&TST=&HAT='));
}
