import '../../../apis/MaterialAPi.dart';
import '../../../models/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final MaterialcontrollerProvider = Provider((ref) {
  final material = ref.watch(MaterialapiProvider);
  return Materialcontroller(materialapi: material);
});

class Materialcontroller {
  final Materialapi _materialapi;

  Materialcontroller({required Materialapi materialapi})
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
