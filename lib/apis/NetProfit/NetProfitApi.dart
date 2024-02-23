import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/IntervalBenifits.dart';
import 'package:http/http.dart' as http;

import '../../utility/contants.dart';
import '../userapi.dart';

final NetProfitForPeriodApiProvider = Provider<NetProfitForPeriodApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return NetProfitForPeriodApi(tokken: token);
});

class NetProfitForPeriodApi {
  final String tokken;

  NetProfitForPeriodApi({required this.tokken});

  /*  Future<IntervalBenfitsModule> */ GetData(
      String dateFrom, String dateTo) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        "http://$baseUrl/Reports/ProfitInDuration",
      ),
    )..headers.addAll({
        "Authorization": "Bearer $tokken",
        "Content-Type": "application/json"
      });
    var params = {"dateFrom": dateFrom, "dateTo": dateTo};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    final body = await response.stream.bytesToString();
    final data = jsonEncode(body);
    print(data);
    final bodu = jsonDecode(body);
    print(bodu[0]);

    final res = IntervalBenfitsModule.fromMap(bodu[0]);
    return res;
  }
}
