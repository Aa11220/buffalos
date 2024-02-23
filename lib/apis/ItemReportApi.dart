import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ItemReportModule.dart';
import '../utility/contants.dart';
import 'package:http/http.dart' as http;

import 'userapi.dart';

final ItemReportApiProvider = Provider<ItemReportApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return ItemReportApi(tokken: token);
});

class ItemReportApi {
  final String? tokken;

  ItemReportApi({required this.tokken});
  Future<List<ItemReportModule>> getallemp(String? empID, String? dateFrom,
      String? dateTo, String? fkCatId, String? fkItemId) async {
    List<ItemReportModule> list = [];
    var request = http.Request(
      'GET',
      Uri.parse(
        "http://$baseUrl/Reports/ItemReport",
      ),
    )..headers.addAll({
        "Authorization": "Bearer $tokken",
        "Content-Type": "application/json"
      });
    var params = {
      "empID": empID,
      "dateFrom": dateFrom,
      "dateTo": dateTo,
      "fkCatId": fkCatId,
      "fkItemId": fkItemId
    };
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    final body = await response.stream.bytesToString();
    final data = jsonEncode(body);
    print(data);
    final bodu = jsonDecode(body);

    for (var element in bodu) {
      list.add(ItemReportModule.fromMap(element));
    }
    return list;
  }
}
