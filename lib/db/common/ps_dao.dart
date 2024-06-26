import 'dart:async';
import 'dart:core';
import 'package:digitalproductstore/viewobject/product_collection.dart';
import 'package:sembast/sembast.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/db/common/ps_app_database.dart';
import 'package:digitalproductstore/viewobject/common/ps_map_object.dart';
import 'package:digitalproductstore/viewobject/common/ps_object.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';

abstract class PsDao<T extends PsObject<T>> {
  dynamic dao;
  T obj;
  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get db async => await PsAppDatabase.instance.database;

  void init(T obj) {
    // A Store with int keys and Map<String, dynamic> values.
    // This Store acts like a persistent map, values of which are Fruit objects converted to Map
    dao = intMapStoreFactory.store(getStoreName());
    this.obj = obj;
  }

  String getStoreName();

  // Map<String, dynamic> toMap(T object);

  // T fromMap(Map<String, dynamic> map);

  // List<Map<String, dynamic>> toMapList(List<T> objectList);

  dynamic getPrimaryKey(T object);
  Filter getFilter(T object);

  Future<dynamic> insert(String primaryKey, T object) async {
    // final finder = Finder(
    //     filter: getFilter(object)); //Filter.byKey(getPrimaryKey(object)));
    // final recordSnapshots = await dao.findFirst(
    //   await db,
    //   finder: finder,
    // );

    // var key = await update(object);
    // if (key == 0) {
    //   // if (recordSnapshots == null) {
    //   await dao.add(await db, obj.toMap(object));
    //   // } else {
    //   // print(await update(object));
    //   // }
    // }

    await deleteWithFinder(
        Finder(filter: Filter.equals(primaryKey, object.getPrimaryKey())));
    await dao.add(await db, obj.toMap(object));

    return true;
  }

  Future<dynamic> insertAll(String primaryKey, List<T> objectList) async {
    // for (var object in objectList) {
    //   await insert(object);
    // }

    // return true;

    final List<String> idList = <String>[];
    for (T data in objectList) {
      idList.add(data.getPrimaryKey());
    }
    await deleteWithFinder(Finder(filter: Filter.inList(primaryKey, idList)));
    await dao.addAll(await db, obj.toMapList(objectList));
  }

  Future<dynamic> update(T object, {Finder finder}) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    finder ??= Finder(filter: getFilter(object));

    return await dao.update(await db, obj.toMap(object),
        //Category().toMap(object),
        finder: finder);
  }

  Future<dynamic> updateWithFinder(T object, Finder finder) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    await dao.update(
      await db,
      obj.toMap(object),
      //Category().toMap(object),
      finder: finder,
    );
  }

  Future<dynamic> deleteAll() async {
    await dao.delete(await db);
  }

  Future<dynamic> delete(T object, {Finder finder}) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    finder ??= Finder(filter: getFilter(object));

    //final Finder finder = Finder(filter: finder);
    await dao.delete(
      await db,
      finder: finder,
    );
  }

  Future<dynamic> deleteWithFinder(Finder finder) async {
    await dao.delete(
      await db,
      finder: finder,
    );
  }

  Future<PsResource<List<T>>> getByKey(String key, String value,
      {List<SortOrder> sortOrderList,
      PsStatus status = PsStatus.SUCCESS}) async {
    final Finder finder = Finder(filter: Filter.equals(key, value));
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];
    recordSnapshots.forEach((dynamic snapshot) {
      resultList.add(obj.fromMap(snapshot.value));
    });

    return PsResource<List<T>>(status, '', resultList);
  }

  Future<dynamic> getAllWithSubscription(
      {StreamController<PsResource<List<T>>> stream,
      Finder finder,
      PsStatus status = PsStatus.SUCCESS,
      Function onDataUpdated}) async {
    finder ??= Finder();

    final dynamic query = await dao.query(finder: finder);
    final dynamic subscription =
        await query.onSnapshots(await db).listen((dynamic recordSnapshots2) {
      final List<T> resultList = <T>[];
      recordSnapshots2.forEach((dynamic snapshot) {
        final T localObj = obj.fromMap(snapshot.value);
        localObj.key = snapshot.key;
        resultList.add(localObj);
      });

      onDataUpdated(resultList);
    });

    return subscription;
  }

  Future<PsResource<List<T>>> getAll(
      {Finder finder, PsStatus status = PsStatus.SUCCESS}) async {
    finder ??= Finder();
    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];
    recordSnapshots.forEach((dynamic snapshot) {
      final T localObj = obj.fromMap(snapshot.value);
      localObj.key = snapshot.key;
      resultList.add(localObj);
    });

    return PsResource<List<T>>(status, '', resultList);
  }

  Future<PsResource<T>> getOne(
      {Finder finder, PsStatus status = PsStatus.SUCCESS}) async {
    finder ??= Finder();
    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: finder,
    );
    T result;

    for (dynamic snapshot in recordSnapshots) {
      final T localObj = obj.fromMap(snapshot.value);
      localObj.key = snapshot.key;
      result = localObj;
      break;
    }

    return PsResource<T>(status, '', result);
  }

  Future<PsResource<List<T>>> getAllByJoin<K extends PsMapObject<dynamic>>(
      String primaryKey, PsDao<PsObject<dynamic>> mapDao, dynamic mapObj,
      {List<SortOrder> sortOrderList,
      PsStatus status = PsStatus.SUCCESS}) async {
    final PsResource<List<PsObject<dynamic>>> dataList = await mapDao.getAll(
        finder: Finder(sortOrders: <SortOrder>[SortOrder('sorting', true)]));

    final List<String> valueList = mapObj.getIdList(dataList.data);

    final Finder finder = Finder(
      filter: Filter.inList(primaryKey, valueList),
      //sortOrders: [SortOrder(Field.key, true)]
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];

    // sorting
    for (String id in valueList) {
      for (dynamic snapshot in recordSnapshots) {
        if (snapshot.value[primaryKey] == id) {
          resultList.add(obj.fromMap(snapshot.value));
          break;
        }
      }
    }

    return PsResource<List<T>>(status, '', resultList);
  }

  Future<PsResource<List<T>>>
      getAllProductWithCollectionId<K extends PsMapObject<dynamic>>(
          String collectionId, PsDao<PsObject<dynamic>> mapDao, dynamic mapObj,
          {List<SortOrder> sortOrderList,
          PsStatus status = PsStatus.SUCCESS}) async {
    final PsResource<List<PsObject<dynamic>>> dataList = await mapDao.getAll(
        finder: Finder(sortOrders: <SortOrder>[SortOrder('sorting', true)]));
    //get productId(primaryKey == collectionId from ProductCollection )
    final List<ProductCollection> productcollection = dataList.data;
    print(productcollection.length);
    print('productcollection');

    final List<String> productIdList = <String>[];

    for (ProductCollection pc in productcollection) {
      if (collectionId == pc.collectionId) {
        productIdList.add(pc.id);
      }
    }
    print(productIdList.length);

    print('productIdList');
    //  code close

    final Finder finder = Finder(
      filter: Filter.inList('id', productIdList),
      //sortOrders: [SortOrder(Field.key, true)]
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];

    // sorting
    for (String id in productIdList) {
      for (dynamic snapshot in recordSnapshots) {
        if (snapshot.value['id'] == id) {
          resultList.add(obj.fromMap(snapshot.value));
          break;
        }
      }
    }

    return PsResource<List<T>>(status, '', resultList);
  }

  Future<PsResource<List<T>>> getAllByMap<K extends PsMapObject<dynamic>>(
      String primaryKey,
      String mapKey,
      String paramKey,
      PsDao<PsObject<dynamic>> mapDao,
      dynamic mapObj,
      {List<SortOrder> sortOrderList,
      PsStatus status = PsStatus.SUCCESS}) async {
    final PsResource<List<PsObject<dynamic>>> dataList = await mapDao.getAll(
        finder: Finder(
            filter: Filter.equals(mapKey, paramKey),
            sortOrders: <SortOrder>[SortOrder('sorting', true)]));

    final List<String> valueList = mapObj.getIdList(dataList.data);

    final Finder finder = Finder(
      filter: Filter.inList(primaryKey, valueList),
      //sortOrders: [SortOrder(Field.key, true)]
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];

    // sorting
    for (String id in valueList) {
      for (dynamic snapshot in recordSnapshots) {
        if (snapshot.value[primaryKey] == id) {
          resultList.add(obj.fromMap(snapshot.value));
          break;
        }
      }
    }

    return PsResource<List<T>>(status, '', resultList);
  }

  // Future<PsResource<List<T>>> getAllByMap<K>(String mapKey, String paramKey, List<String> valueList,
  //     {List<SortOrder> sortOrderList,
  //     PsStatus status = PsStatus.SUCCESS}) async {
  //   final finder = Finder(
  //     filter: Filter.inList(paramKey, valueList),
  //     //sortOrders: [SortOrder(Field.key, true)]
  //   );
  //   if (sortOrderList != null && sortOrderList.length > 0) {
  //     finder.sortOrders = sortOrderList;
  //   }

  //   final recordSnapshots = await dao.find(
  //     await db,
  //     finder: finder,
  //   );
  //   List<T> resultList = List();

  //   for (var id in valueList) {
  //     for (var snapshot in recordSnapshots) {
  //       if (snapshot.value[paramKey] == id) {
  //         resultList.add(obj.fromMap(snapshot.value));
  //         break;
  //       }
  //     }
  //   }

  //   return PsResource<List<T>>(status, "", resultList);
  // }
}

// recordSnapshots.forEach((snapshot) {
//   //print("KEY ${snapshot.key}");
//   T localObj = obj.fromMap(snapshot.value);
//   localObj.key = snapshot.key;
//   resultList.add(localObj);
// });
// valueList.forEach((id) {
//   recordSnapshots.forEach((snapshot) {
//     // print("${snapshot.value[key]}");
//     if (snapshot.value[key] == id) {
//       resultList.add(obj.fromMap(snapshot.value));
//       // print("Key Found");
//       return;
//     }
//   });
// });
