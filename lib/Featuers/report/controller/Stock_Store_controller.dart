import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/stock_apis/Stock_Store.dart';
import '../../../models/stock_store.dart';

final StockStoreControllerProvider = Provider<StockStoreController>((ref) {
  final api = ref.read(StockStoreApiProvider);
  return StockStoreController(api: api);
});

class StockStoreController {
  final StockStoreApi api;

  StockStoreController({required this.api});
  Future<List<StockStore>> getStockStore(int? fk_store_id) async {
    if (fk_store_id != null) {
      final List = await api.getStores(fk_store_id);
      return List;
    }
    return [];
  }
}
