// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_map_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BusMapViewModel on _BusMapViewModelBase, Store {
  late final _$busesAtom =
      Atom(name: '_BusMapViewModelBase.buses', context: context);

  @override
  List<Table> get buses {
    _$busesAtom.reportRead();
    return super.buses;
  }

  @override
  set buses(List<Table> value) {
    _$busesAtom.reportWrite(value, super.buses, () {
      super.buses = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_BusMapViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fetchAsyncAction =
      AsyncAction('_BusMapViewModelBase.fetch', context: context);

  @override
  Future<void> fetch(String hatNumber) {
    return _$fetchAsyncAction.run(() => super.fetch(hatNumber));
  }

  late final _$_BusMapViewModelBaseActionController =
      ActionController(name: '_BusMapViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_BusMapViewModelBaseActionController.startAction(
        name: '_BusMapViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_BusMapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
buses: ${buses},
isLoading: ${isLoading}
    ''';
  }
}
