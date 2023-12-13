import '../../../apis/MaterialAPi.dart';
import '../../../models/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final MaterialreportcontrollerProvider = Provider((ref) {
  final material = ref.read(MaterialapiProvider);
  return Materialreportcontroller(materialapi: material);
});

class Materialreportcontroller {
  final Materialapi _materialapi;

  Materialreportcontroller({required Materialapi materialapi})
      : _materialapi = materialapi;

  Future<List<Material>> getall() async {
    final mylist = await _materialapi.fetchitems();
    return mylist;
  }

  Future<int> addMaterial(Material item) async {
    final id = _materialapi.addMaterial(item);
    return id;
  }
}
