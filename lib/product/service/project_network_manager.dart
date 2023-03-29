import 'package:dio/dio.dart';

class ProjectNetworkManager {
  ProjectNetworkManager._() {
    _dio = Dio(
        BaseOptions(baseUrl: 'http://88.255.141.66/mblSrv1/service.asp?FNC=Otobus&PRM=&VER=3.1.0&LAN=tr&TST=&HAT='));
    _dio.options = _dio.options.copyWith(headers: {"Authorization": "EGO Genel Mudurlugu-EGO Cepte-3.1.0 R16NM.G950FXXU4CRL3 8.0.0"});
  }
  late final Dio _dio;
  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get service => _dio;

}
