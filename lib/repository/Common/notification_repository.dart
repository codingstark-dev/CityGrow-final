import 'dart:async';

import 'package:digitalproductstore/viewobject/api_status.dart';
import 'package:flutter/material.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/api/ps_api_service.dart';
import 'package:digitalproductstore/repository/Common/ps_repository.dart';

class NotificationRepository extends PsRepository {
  NotificationRepository({@required PsApiService psApiService}) {
    _psApiService = psApiService;
  }

  PsApiService _psApiService;

  //noti register
  Future<PsResource<ApiStatus>> rawRegisterNotiToken(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.rawRegisterNotiToken(jsonMap);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
  //end region

  //noti unregister
  Future<PsResource<ApiStatus>> rawUnRegisterNotiToken(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.rawUnRegisterNotiToken(jsonMap);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  //end region
}
