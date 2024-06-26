import 'dart:async';

import 'package:digitalproductstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/provider/common/ps_provider.dart';
import 'package:digitalproductstore/repository/sub_category_repository.dart';
import 'package:digitalproductstore/viewobject/sub_category.dart';

class SubCategoryProvider extends PsProvider {
  SubCategoryProvider({@required SubCategoryRepository repo}) : super(repo) {
    _repo = repo;
    print('SubCategory Provider: $hashCode');

    utilsCheckInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
    });

    subCategoryListStream =
        StreamController<PsResource<List<SubCategory>>>.broadcast();
    subscription = subCategoryListStream.stream.listen((dynamic resource) {
      updateOffset(resource.data.length);

      _subCategoryList = resource;

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  StreamController<PsResource<List<SubCategory>>> subCategoryListStream;
  SubCategoryRepository _repo;

  PsResource<List<SubCategory>> _subCategoryList =
      PsResource<List<SubCategory>>(PsStatus.NOACTION, '', <SubCategory>[]);

  PsResource<List<SubCategory>> get subCategoryList => _subCategoryList;
  StreamSubscription<PsResource<List<SubCategory>>> subscription;

  String categoryId = '';

  @override
  void dispose() {
    subscription.cancel();
    isDispose = true;
    print('SubCategory Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> loadSubCategoryList(String categoryId) async {
    isLoading = true;
    isConnectedToInternet = await utilsCheckInternetConnectivity();
    await _repo.getSubCategoryListByCategoryId(
        subCategoryListStream,
        isConnectedToInternet,
        limit,
        offset,
        PsStatus.PROGRESS_LOADING,
        categoryId);
  }

  Future<dynamic> loadAllSubCategoryList(String categoryId) async {
    isLoading = true;
    isConnectedToInternet = await utilsCheckInternetConnectivity();
    await _repo.getAllSubCategoryListByCategoryId(subCategoryListStream,
        isConnectedToInternet, PsStatus.PROGRESS_LOADING, categoryId);
  }

  Future<dynamic> nextSubCategoryList(String categoryId) async {
    isConnectedToInternet = await utilsCheckInternetConnectivity();
    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;

      await _repo.getNextPageSubCategoryList(
          subCategoryListStream,
          isConnectedToInternet,
          limit,
          offset,
          PsStatus.PROGRESS_LOADING,
          categoryId);
    }
  }

  Future<void> resetSubCategoryList(String categoryId) async {
    isConnectedToInternet = await utilsCheckInternetConnectivity();

    isLoading = true;

    updateOffset(0);

    await _repo.getSubCategoryListByCategoryId(
        subCategoryListStream,
        isConnectedToInternet,
        limit,
        offset,
        PsStatus.PROGRESS_LOADING,
        categoryId);

    isLoading = false;
  }
}
