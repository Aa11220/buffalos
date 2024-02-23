import 'dart:convert';

import '../../models/stock_store.dart';
import '../userapi.dart';
import '../../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


final StockMaterialApiProvider = Provider<StockMaterialApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return StockMaterialApi(tokken: token);
});

class StockMaterialApi {
  final String tokken;
  StockMaterialApi({required this.tokken});
  Future<List<StockStore>> getStores(int fkMaterialId) async {
    List<StockStore> list = [];
    final url = Uri.http(baseUrl, "/Admin/GetStockBalancebyStore",
        fkMaterialId != 0 ? {"userQuery": "fk_store_id=$fkMaterialId"} : {});
    final response = await http.get(url,
        headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tokken'});
    print(response.body);
    print(response.statusCode);
    final bodylist = jsonDecode(response.body);
    for (var elment in bodylist) {
      list.add(StockStore.fromMap(elment));
    }
    return list;
  }
}
