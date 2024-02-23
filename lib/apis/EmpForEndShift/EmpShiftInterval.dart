import 'dart:convert';

import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/EmpIntervalDataclass.dart';
import '../userapi.dart';

final EmpShiftIntervalApiProvider = Provider<EmpShiftIntervalApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return EmpShiftIntervalApi(Tokken: token);
});

class EmpShiftIntervalApi {
  final String Tokken;

  EmpShiftIntervalApi({required this.Tokken});
  Future<List<EmpIntervalDataclass>> GetData(
      String dateFrom, String dateTo) async {
    List<EmpIntervalDataclass> list = [];
    var request = http.Request(
      'GET',
      Uri.parse(
        "http://$baseUrl/Admin/GetShiftsInPeriod",
      ),
    )..headers.addAll({
        "Authorization": "Bearer $Tokken",
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

    for (var element in bodu["Table"]) {
      list.add(EmpIntervalDataclass.fromMap(element));
    }
    return list;
  }
}
