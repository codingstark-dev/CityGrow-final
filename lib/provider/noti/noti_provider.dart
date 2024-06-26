import 'dart:async';

import 'package:digitalproductstore/utils/utils.dart';
import 'package:digitalproductstore/viewobject/common/ps_value_holder.dart';
import 'package:flutter/material.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/provider/common/ps_provider.dart';
import 'package:digitalproductstore/repository/noti_repository.dart';
import 'package:digitalproductstore/viewobject/noti.dart';

class NotiProvider extends PsProvider {
  NotiProvider({@required NotiRepository repo, this.psValueHolder})
      : super(repo) {
    _repo = repo;
    //isDispose = false;
    print('Notification Provider: $hashCode');

    utilsCheckInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
    });

    notiListStream = StreamController<PsResource<List<Noti>>>.broadcast();
    subscription = notiListStream.stream.listen((dynamic resource) {
      updateOffset(resource.data.length);

      _notiList = resource;

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }
  NotiRepository _repo;
  PsValueHolder psValueHolder;
  String userId = '';
  String deviceToken;

  PsResource<Noti> _noti = PsResource<Noti>(PsStatus.NOACTION, '', null);
  PsResource<Noti> get user => _noti;

  PsResource<List<Noti>> _notiList =
      PsResource<List<Noti>>(PsStatus.NOACTION, '', <Noti>[]);
  PsResource<List<Noti>> get notiList => _notiList;
  StreamSubscription<dynamic> subscription;
  StreamController<PsResource<List<Noti>>> notiListStream;
  @override
  void dispose() {
    //_repo.cate.close();
    subscription.cancel();
    isDispose = true;
    print('Notification Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> getNotiList(Map<dynamic, dynamic> paramMap) async {
    isConnectedToInternet = await utilsCheckInternetConnectivity();
    isLoading = true;

    await _repo.getNotiList(notiListStream, isConnectedToInternet, limit,
        offset, PsStatus.BLOCK_LOADING, paramMap);
  }

  Future<dynamic> nextNotiList(Map<dynamic, dynamic> paramMap) async {
    isConnectedToInternet = await utilsCheckInternetConnectivity();
    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;

      await _repo.getNextPageNotiList(notiListStream, isConnectedToInternet,
          limit, offset, PsStatus.PROGRESS_LOADING, paramMap);
    }
  }

  Future<void> resetNotiList(Map<dynamic, dynamic> paramMap) async {
    isConnectedToInternet = await utilsCheckInternetConnectivity();
    isLoading = true;

    updateOffset(0);

    await _repo.getNotiList(notiListStream, isConnectedToInternet, limit,
        offset, PsStatus.BLOCK_LOADING, paramMap);

    isLoading = false;
  }

  Future<dynamic> postNoti(
    Map<dynamic, dynamic> jsonMap,
  ) async {
    isLoading = true;

    isConnectedToInternet = await utilsCheckInternetConnectivity();

    _noti =
        await _repo.postNoti(notiListStream, jsonMap, isConnectedToInternet);

    return _noti;
  }
}
