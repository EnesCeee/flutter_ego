import 'package:flutter_ego/flutter_map_resource/model/bus_model.dart';
import 'package:flutter_ego/product/service/location.dart';
import 'package:flutter_ego/product/service/project_dio.dart';
import 'package:flutter_ego/product/service/project_network_manager.dart';
import 'package:mobx/mobx.dart';
import '../service/bus_service.dart';
part 'bus_map_view_model.g.dart';

class BusMapViewModel = _BusMapViewModelBase with _$BusMapViewModel;

abstract class _BusMapViewModelBase with Store, ProjectDioMixin {
  late final IBusService busService;

  List<Table> buses = [];

  @observable
  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
  }

  void initState() {
    busService = BusService(ProjectNetworkManager.instance.service);
    fetch();
    getLocation();
  }

  Future<void> fetch() async {
    changeLoading();
    buses = (await busService.fetchBusItem())?.table ?? [];
    changeLoading();
  }

  @action
  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }
  

}
