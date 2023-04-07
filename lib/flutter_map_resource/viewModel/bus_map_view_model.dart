import 'package:flutter_ego/flutter_map_resource/model/bus_model.dart';
import 'package:flutter_ego/product/service/project_network_manager.dart';
import 'package:mobx/mobx.dart';
import '../service/bus_service.dart';
part 'bus_map_view_model.g.dart';

class BusMapViewModel = _BusMapViewModelBase with _$BusMapViewModel;

abstract class _BusMapViewModelBase with Store {
  late final IBusService busService;

  @observable
  List<Table> buses = [];

  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  void initState() {
    busService = BusService(ProjectNetworkManager.instance.service);
  }

  @action
  Future<void> fetch(String hatNumber) async {
    changeLoading();
    buses = (await busService.fetchBusItem(hatNumber)) ?? [];
    changeLoading();
  }
}
