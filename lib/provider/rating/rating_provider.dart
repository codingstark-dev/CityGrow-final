import 'dart:async';
import 'package:digitalproductstore/repository/rating_repository.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:digitalproductstore/viewobject/rating.dart';
import 'package:flutter/material.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/provider/common/ps_provider.dart';

class RatingProvider extends PsProvider {
  RatingProvider({@required RatingRepository repo}) : super(repo) {
    _repo = repo;
    print('Rating Provider: $hashCode');

    utilsCheckInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
    });

    ratingListStream = StreamController<PsResource<List<Rating>>>.broadcast();
    subscription =
        ratingListStream.stream.listen((PsResource<List<Rating>> resource) {
      updateOffset(resource.data.length);

      _ratingList = resource;

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  RatingRepository _repo;

  PsResource<Rating> _rating = PsResource<Rating>(PsStatus.NOACTION, '', null);
  PsResource<Rating> get user => _rating;

  PsResource<List<Rating>> _ratingList =
      PsResource<List<Rating>>(PsStatus.NOACTION, '', <Rating>[]);

  PsResource<List<Rating>> get ratingList => _ratingList;
  StreamSubscription<PsResource<List<Rating>>> subscription;
  StreamController<PsResource<List<Rating>>> ratingListStream;

  @override
  void dispose() {
    subscription.cancel();
    isDispose = true;
    print('Rating Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> loadRatingList(String productId) async {
    isLoading = true;

    isConnectedToInternet = await utilsCheckInternetConnectivity();
    await _repo.getAllRatingList(ratingListStream, productId,
        isConnectedToInternet, limit, offset, PsStatus.PROGRESS_LOADING);
  }

  Future<dynamic> nextRatingList(String productId) async {
    isConnectedToInternet = await utilsCheckInternetConnectivity();

    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;
      await _repo.getNextPageRatingList(ratingListStream, productId,
          isConnectedToInternet, limit, offset, PsStatus.PROGRESS_LOADING);
    }
  }

  Future<void> resetRatingList(String productId) async {
    isConnectedToInternet = await utilsCheckInternetConnectivity();
    isLoading = true;

    updateOffset(0);

    await _repo.getAllRatingList(ratingListStream, productId,
        isConnectedToInternet, limit, offset, PsStatus.PROGRESS_LOADING);

    isLoading = false;
  }

  Future<dynamic> refreshRatingList(String productId) async {
    isLoading = true;

    isConnectedToInternet = await utilsCheckInternetConnectivity();
    await _repo.getAllRatingList(ratingListStream, productId,
        isConnectedToInternet, limit, 0, PsStatus.PROGRESS_LOADING,
        isNeedDelete: false);
  }

  Future<dynamic> postRating(
    Map<dynamic, dynamic> jsonMap,
  ) async {
    isLoading = true;

    isConnectedToInternet = await utilsCheckInternetConnectivity();

    _rating = await _repo.postRating(
        ratingListStream, jsonMap, isConnectedToInternet);

    return _rating;
  }
}
