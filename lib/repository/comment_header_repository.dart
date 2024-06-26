import 'dart:async';
import 'package:digitalproductstore/db/comment_header_dao.dart';
import 'package:digitalproductstore/viewobject/comment_header.dart';
import 'package:flutter/material.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/api/ps_api_service.dart';
import 'package:sembast/sembast.dart';

import 'Common/ps_repository.dart';

class CommentHeaderRepository extends PsRepository {
  CommentHeaderRepository(
      {@required PsApiService psApiService,
      @required CommentHeaderDao commentHeaderDao}) {
    _psApiService = psApiService;
    _commentHeaderDao = commentHeaderDao;
  }

  String primaryKey = 'id';
  PsApiService _psApiService;
  CommentHeaderDao _commentHeaderDao;

  Future<dynamic> insert(CommentHeader commentHeader) async {
    return _commentHeaderDao.insert(primaryKey, commentHeader);
  }

  Future<dynamic> update(CommentHeader commentHeader) async {
    return _commentHeaderDao.update(commentHeader);
  }

  Future<dynamic> delete(CommentHeader commentHeader) async {
    return _commentHeaderDao.delete(commentHeader);
  }

  Future<dynamic> getAllCommentList(
      String productId,
      StreamController<PsResource<List<CommentHeader>>> commentHeaderListStream,
      bool isConnectedToInternet,
      int limit,
      int offset,
      PsStatus status,
      {bool isNeedDelete = true,
      bool isLoadFromServer = true}) async {
    final Finder finder =
        Finder(filter: Filter.equals('product_id', productId));
    commentHeaderListStream.sink
        .add(await _commentHeaderDao.getAll(finder: finder, status: status));

    if (isConnectedToInternet) {
      final PsResource<List<CommentHeader>> _resource =
          await _psApiService.getCommentList(productId, limit, offset);

      if (_resource.status == PsStatus.SUCCESS) {
        if (isNeedDelete) {
          await _commentHeaderDao.deleteWithFinder(finder);
        }
        await _commentHeaderDao.insertAll(primaryKey, _resource.data);
        commentHeaderListStream.sink
            .add(await _commentHeaderDao.getAll(finder: finder));
      } else {
        commentHeaderListStream.sink
            .add(await _commentHeaderDao.getAll(finder: finder));
      }
    }
  }

  Future<dynamic> getNextPageCommentList(
      String productId,
      StreamController<PsResource<List<CommentHeader>>> commentHeaderListStream,
      bool isConnectedToInternet,
      int limit,
      int offset,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final Finder finder =
        Finder(filter: Filter.equals('product_id', productId));
    commentHeaderListStream.sink
        .add(await _commentHeaderDao.getAll(finder: finder, status: status));

    if (isConnectedToInternet) {
      final PsResource<List<CommentHeader>> _resource =
          await _psApiService.getCommentList(productId, limit, offset);

      if (_resource.status == PsStatus.SUCCESS) {
        await _commentHeaderDao.insertAll(primaryKey, _resource.data);
      }
      commentHeaderListStream.sink
          .add(await _commentHeaderDao.getAll(finder: finder));
    }
  }

  Future<PsResource<List<CommentHeader>>> postCommentHeader(
      StreamController<PsResource<List<CommentHeader>>> commentHeaderListStream,
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<List<CommentHeader>> _resource =
        await _psApiService.postCommentHeader(jsonMap);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<List<CommentHeader>>> completer =
          Completer<PsResource<List<CommentHeader>>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
