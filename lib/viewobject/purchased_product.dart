import 'package:quiver/core.dart';
import 'package:digitalproductstore/viewobject/common/ps_map_object.dart';

class PurchasedProduct extends PsMapObject<PurchasedProduct> {
  PurchasedProduct({this.id, int sorting}) {
    super.sorting = sorting;
  }
  String id;

  @override
  bool operator ==(dynamic other) =>
      other is PurchasedProduct && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String getPrimaryKey() {
    return id;
  }

  @override
  PurchasedProduct fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return PurchasedProduct(
          id: dynamicData['id'], sorting: dynamicData['sorting']);
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic> toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['sorting'] = object.sorting;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<PurchasedProduct> fromMapList(List<dynamic> dynamicDataList) {
    final List<PurchasedProduct> purchasedProductMapList = <PurchasedProduct>[];

    if (dynamicDataList != null) {
      for (dynamic dynamicData in dynamicDataList) {
        if (dynamicData != null) {
          purchasedProductMapList.add(fromMap(dynamicData));
        }
      }
    }
    return purchasedProductMapList;
  }

  @override
  List<Map<String, dynamic>> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>> dynamicList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (dynamic data in objectList) {
        if (data != null) {
          dynamicList.add(toMap(data));
        }
      }
    }

    return dynamicList;
  }

  @override
  List<String> getIdList(List<dynamic> mapList) {
    final List<String> idList = <String>[];
    if (mapList != null) {
      for (dynamic product in mapList) {
        if (product != null) {
          idList.add(product.id);
        }
      }
    }
    return idList;
  }
}
