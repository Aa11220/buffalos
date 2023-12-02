import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/ingrediantsapi.dart';
import '../../../models/ingediants.dart';

final ingrediantcontrollerprovider = Provider((ref) {
  final ingredapi = ref.watch(ingrediantApiprovider);
  return IngregiantController(api: ingredapi);
});

class IngregiantController {
  final ingrediantApi api;

  IngregiantController({required this.api});

  Future<List<ingrediants>> getall(String itemid) async {
    final mylist = await api.getall(itemid);
    return mylist;
  }
}
