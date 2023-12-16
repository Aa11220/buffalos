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
  Future<List<StockStore>> getStockStore(int? fkStoreId) async {
    if (fkStoreId != null) {
      final List = await api.getStores(fkStoreId);
      return List;
    }
    return [];
  }
}
