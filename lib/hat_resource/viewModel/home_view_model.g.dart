// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$itemsAtom =
      Atom(name: '_HomeViewModelBase.items', context: context);

  @override
  List<HatModel>? get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<HatModel>? value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$filterSearchAtom =
      Atom(name: '_HomeViewModelBase.filterSearch', context: context);

  @override
  List<HatModel>? get filterSearch {
    _$filterSearchAtom.reportRead();
    return super.filterSearch;
  }

  @override
  set filterSearch(List<HatModel>? value) {
    _$filterSearchAtom.reportWrite(value, super.filterSearch, () {
      super.filterSearch = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HomeViewModelBase.isLoading', context: context);

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

  late final _$fetchGetItemsScrapeAsyncAction =
      AsyncAction('_HomeViewModelBase.fetchGetItemsScrape', context: context);

  @override
  Future<void> fetchGetItemsScrape() {
    return _$fetchGetItemsScrapeAsyncAction
        .run(() => super.fetchGetItemsScrape());
  }

  late final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchFilter(String query) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.searchFilter');
    try {
      return super.searchFilter(query);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
filterSearch: ${filterSearch},
isLoading: ${isLoading}
    ''';
  }
}
