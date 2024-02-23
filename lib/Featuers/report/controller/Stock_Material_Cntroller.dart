import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/stock_apis/Stock_material.dart';
import '../../../models/Stock_Material.dart';
import '../../../models/stock_store.dart';

final StockMaterialControllerProvider =
    Provider<StockMaterialController>((ref) {
  final api = ref.read(StockMaterialApiProvider);
  return StockMaterialController(api: api);
});

class StockMaterialController {
  final StockMaterialApi api;

  StockMaterialController({required this.api});
  Future<List<StockStore>> getStockStore(int? fkStoreId) async {
    final List = await api.getStores(fkStoreId ?? 0);
    print(List);
    return List;
  }
}
