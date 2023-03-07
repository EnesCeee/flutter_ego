import 'package:flutter_ego/flutter_map_resource/model/bus_model.dart';
import 'package:flutter_ego/flutter_map_resource/service/bus_service.dart';
import 'package:flutter_ego/product/service/project_dio.dart';
import 'package:mobx/mobx.dart';
part 'bus_map_view_model.g.dart';

class BusMapViewModel = _BusMapViewModelBase with _$BusMapViewModel;

abstract class _BusMapViewModelBase with Store, ProjectDioMixin {
  late final IBusService busService;
  bool isLoading = false;
  List<Table> buses = [];

  void changeLoading() {
    isLoading = !isLoading;
  }

  void initState() {
    busService = BusService(service);
  }

  Future<void> fetch() async {
    changeLoading();
    buses = (await busService.fetchBusItem())?.table ?? [];
    changeLoading();
  }
}
