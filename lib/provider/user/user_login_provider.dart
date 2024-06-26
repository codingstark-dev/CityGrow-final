import 'dart:async';
import 'package:digitalproductstore/repository/user_repository.dart';
import 'package:digitalproductstore/viewobject/common/ps_value_holder.dart';
import 'package:digitalproductstore/viewobject/user_login.dart';
import 'package:flutter/material.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/provider/common/ps_provider.dart';

class UserLoginProvider extends PsProvider {
  UserLoginProvider(
      {@required UserRepository repo, @required this.psValueHolder})
      : super(repo) {
    _repo = repo;
    isDispose = false;
    print('User Login Provider: $hashCode');

    userLoginStream = StreamController<PsResource<UserLogin>>.broadcast();
    subscriptionUserLogin = userLoginStream.stream
        .listen((PsResource<UserLogin> userLoginResource) {
      _userLogin = userLoginResource;

      if (userLoginResource.status != PsStatus.BLOCK_LOADING &&
          userLoginResource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  UserRepository _repo;
  PsValueHolder psValueHolder;

  PsResource<UserLogin> _userLogin =
      PsResource<UserLogin>(PsStatus.NOACTION, '', null);
  PsResource<UserLogin> get userLogin => _userLogin;

  StreamController<PsResource<UserLogin>> userLoginStream;
  StreamSubscription<PsResource<UserLogin>> subscriptionUserLogin;

  @override
  void dispose() {
    subscriptionUserLogin.cancel();
    isDispose = true;
    print('User Login Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> getUserLogin(String loginUserId) async {
    isLoading = true;

    _repo.getUserLogin(loginUserId, userLoginStream, PsStatus.PROGRESS_LOADING);
  }
}
