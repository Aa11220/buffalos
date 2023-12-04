import 'package:buffalos/apis/componentapi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/Componentcategory.dart';
import '../../../models/Material.dart';

final componentcontrollerProvider = Provider<componentcontroller>((ref) {
  final api = ref.watch(componentapiProvider);
  return componentcontroller(compapi: api);
});

class componentcontroller {
  final componentapi compapi;

  componentcontroller({required this.compapi});
  Future<List<Material>> fetchitems() async {
    final list = await compapi.fetchitems();
    return list;
  }

  Future<void> addMaterial(Componnent item) async {
    compapi.addMaterial(item);
  }
}
