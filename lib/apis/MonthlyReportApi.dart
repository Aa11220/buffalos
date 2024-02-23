import 'dart:convert';

import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/MonthlyProfitItem.dart';

final MonthlyReportApiProvider = Provider<MonthlyReportApi>((ref) {
  final tokken = ref.watch(authprovider).logedin.token;

  return MonthlyReportApi(Tokken: tokken);
});

class MonthlyReportApi {
  final String Tokken;

  MonthlyReportApi({required this.Tokken});
  Future<MonthlyProfitItem> GetData(String month, String year) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        "http://$baseUrl/Reports/MonthTrans",
      ),
    )..headers.addAll({
        "Authorization": "Bearer $Tokken",
        "Content-Type": "application/json"
      });
    var params = {"month": month, "year": year};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    final body = await response.stream.bytesToString();
    final data = jsonEncode(body);
    print(data);
    final bodu = jsonDecode(body);

    final res = MonthlyProfitItem.fromlist(bodu);
    return res;
  }
}
