import 'dart:convert';

import '../userapi.dart';
import '../../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../models/Stock_Material.dart';

final StockMaterialApiProvider = Provider<StockMaterialApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return StockMaterialApi(tokken: token);
});

class StockMaterialApi {
  final String tokken;
  StockMaterialApi({required this.tokken});
  Future<List<StockMaterial>> getStores(int fk_material_id) async {
    List<StockMaterial> list = [];
    final url = Uri.http(
        baseUrl,
        "/Admin/GetStockBalancebyItem",
        fk_material_id != 0
            ? {"userQuery": "fk_store_id=$fk_material_id"}
            : {});
    final response = await http.get(url,
        headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tokken'});
    print(response.body);
    print(response.statusCode);
    final bodylist = jsonDecode(response.body);
    for (var elment in bodylist) {
      list.add(StockMaterial.fromMap(elment));
    }
    return list;
  }
}
