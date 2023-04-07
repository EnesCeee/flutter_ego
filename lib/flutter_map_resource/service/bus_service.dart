import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_ego/flutter_map_resource/model/bus_model.dart';

abstract class IBusService {
  IBusService(this.dio);
  final Dio dio;
  Future<List<Table>?> fetchBusItem(String hatNumber);
}

class BusService extends IBusService {
  BusService(super.dio);

  @override
  Future<List<Table>?> fetchBusItem(String hatNumber) async {
    final response = await dio.get(hatNumber);

    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;  
      final fixedJson = jsonBody.replaceAll("'", "\"");
      final start = fixedJson.indexOf('{');
      final end = fixedJson.lastIndexOf('}') + 1;
      final innerJson = fixedJson.substring(start, end);
      final decodedJson = jsonDecode(innerJson);
      if (decodedJson is Map<String, dynamic>) {
        return BusModel.fromJson(decodedJson).data?.first.table;
        
      }
    }
    return null;
  }
}
