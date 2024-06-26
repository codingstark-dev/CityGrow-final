import 'dart:async';

import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/provider/common/ps_provider.dart';
import 'package:digitalproductstore/repository/clear_all_data_repository.dart';
import 'package:digitalproductstore/viewobject/common/ps_value_holder.dart';
import 'package:digitalproductstore/viewobject/product.dart';
import 'package:flutter/cupertino.dart';

class ClearAllDataProvider extends PsProvider {
  ClearAllDataProvider(
      {@required ClearAllDataRepository repo, this.psValueHolder})
      : super(repo) {
    _repo = repo;
    print('ClearAllData Provider: $hashCode');
    allListStream = StreamController<PsResource<List<Product>>>.broadcast();
    subscription =
        allListStream.stream.listen((PsResource<List<Product>> resource) {
      updateOffset(resource.data.length);

      _basketList = resource;

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  StreamController<PsResource<List<Product>>> allListStream;
  ClearAllDataRepository _repo;
  PsValueHolder psValueHolder;

  PsResource<List<Product>> _basketList =
      PsResource<List<Product>>(PsStatus.NOACTION, '', <Product>[]);

  PsResource<List<Product>> get basketList => _basketList;
  StreamSubscription<PsResource<List<Product>>> subscription;
  @override
  void dispose() {
    subscription.cancel();
    // allListStream.close();
    isDispose = true;
    print('ClearAll Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> clearAllData() async {
    isLoading = true;
    _repo.clearAllData(allListStream);
  }
}
