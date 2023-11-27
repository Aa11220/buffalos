import 'package:buffalos/apis/kitchensapi.dart';
import 'package:buffalos/models/kitchen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  // void getItem(String itemid, BuildContext context) async {
  //   try {
  //     final result = await itemsapi.fetchitem(itemid);
  //     Navigator.of(context).pushNamed(addandsave.path,
  //         arguments: {"Search": true, "item": result.toMap()});
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Error happended")));
  //   }
  // }
}
