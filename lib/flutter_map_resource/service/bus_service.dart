import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter_ego/flutter_map_resource/model/bus_model.dart';

abstract class IBusService {
  IBusService(this.dio);
  final Dio dio;
  Future<BusModel?> fetchBusItem();
}

class BusService extends IBusService {
  BusService(super.dio);

  @override
  Future<BusModel?> fetchBusItem() async {
    final response = await dio.get("487");

    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String,dynamic>) {
        return BusModel.fromJson(jsonBody);
      }
    }
    return null;
  }
}
