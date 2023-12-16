import 'dart:convert';

import '../userapi.dart';
import '../../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/stock_store.dart';

final StockStoreApiProvider = Provider<StockStoreApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return StockStoreApi(tokken: token);
});

class StockStoreApi {
  final String tokken;
  StockStoreApi({required this.tokken});
  Future<List<StockStore>> getStores(int fkStoreId) async {
    List<StockStore> list = [];
    final url = Uri.http(baseUrl, "Admin/GetStockBalancebyItem",
        {"userQuery": "fk_store_id=$fkStoreId"});
    final response = await http.get(url,
        headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tokken'});
    final bodylist = jsonDecode(response.body);
    for (var elment in bodylist) {
      list.add(StockStore.fromMap(elment));
    }
    return list;
  }
}
