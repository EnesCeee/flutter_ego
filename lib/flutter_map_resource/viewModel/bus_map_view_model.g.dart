// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_map_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BusMapViewModel on _BusMapViewModelBase, Store {
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

  late final _$latitudeAtom =
      Atom(name: '_BusMapViewModelBase.latitude', context: context);

  @override
  double? get latitude {
    _$latitudeAtom.reportRead();
    return super.latitude;
  }

  @override
  set latitude(double? value) {
    _$latitudeAtom.reportWrite(value, super.latitude, () {
      super.latitude = value;
    });
  }

  late final _$longitudeAtom =
      Atom(name: '_BusMapViewModelBase.longitude', context: context);

  @override
  double? get longitude {
    _$longitudeAtom.reportRead();
    return super.longitude;
  }

  @override
  set longitude(double? value) {
    _$longitudeAtom.reportWrite(value, super.longitude, () {
      super.longitude = value;
    });
  }

  late final _$getLocationAsyncAction =
      AsyncAction('_BusMapViewModelBase.getLocation', context: context);

  @override
  Future<void> getLocation() {
    return _$getLocationAsyncAction.run(() => super.getLocation());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
latitude: ${latitude},
longitude: ${longitude}
    ''';
  }
}
