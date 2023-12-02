import 'package:buffalos/apis/MaterialAPi.dart';
import 'package:buffalos/models/Material.dart';
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
}
