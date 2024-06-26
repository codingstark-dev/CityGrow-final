import 'package:digitalproductstore/viewobject/common/ps_object.dart';

abstract class PsMapObject<T> extends PsObject<T> {
  int sorting;

  List<String> getIdList(List<T> mapList);
}
