import 'package:digitalproductstore/viewobject/common/ps_value_holder.dart';
import 'package:flutter/material.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/provider/common/ps_provider.dart';
import 'package:digitalproductstore/repository/app_info_repository.dart';
import 'package:digitalproductstore/viewobject/ps_app_info.dart';

class AppInfoProvider extends PsProvider {
  AppInfoProvider({@required AppInfoRepository repo, this.psValueHolder})
      : super(repo) {
    _repo = repo;
    print('App Info Provider: $hashCode');
    isDispose = false;
  }

  AppInfoRepository _repo;
  PsValueHolder psValueHolder;

  final PsResource<PSAppInfo> _psAppInfo =
      PsResource<PSAppInfo>(PsStatus.NOACTION, '', null);

  PsResource<PSAppInfo> get categoryList => _psAppInfo;

  @override
  void dispose() {
    isDispose = true;
    print('App Info Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> loadDeleteHistory(Map<dynamic, dynamic> jsonMap) async {
    isLoading = true;

    final PsResource<PSAppInfo> psAppInfo =
        await _repo.postDeleteHistory(jsonMap);

    return psAppInfo;
  }
}
