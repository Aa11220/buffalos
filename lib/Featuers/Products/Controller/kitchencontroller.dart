import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/kitchensapi.dart';
import '../../../models/kitchen.dart';

final Kitchencontrollerprovider = Provider((ref) {
  final kitchenap = ref.watch(kitchenapiProvider);
  return kitchencontroller(kitapi: kitchenap);
});

class kitchencontroller {
  final kitchenapi kitapi;

  kitchencontroller({required this.kitapi});

  Future<List<kitchen>> getItems() async {
    final list = await kitapi.fetchitems();
    return list;
  }

  Future<int> addkitchen(String name) async {
    final id = await kitapi.addkitch(name);
    return id;
  }
}
