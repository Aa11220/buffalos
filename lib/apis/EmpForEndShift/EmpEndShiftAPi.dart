import 'dart:convert';
import 'dart:developer';

import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/EmpEndShift.dart';
import '../userapi.dart';

final EmpEndShiftApiProvider = Provider<EmpEndShiftApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return EmpEndShiftApi(token);
});

class EmpEndShiftApi {
  final String _tokken;
  EmpEndShiftApi(this._tokken);
  Future<List<EmpEndShift>> getallemp() async {
    List<EmpEndShift> list = [];
    try {
      final url =
          Uri.http(baseUrl, "/Admin/GetEmpsforEndShift", {"pageSize": "1000"});
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_tokken",
          "Accept": "text/plain",
        },
      );
      log("${response.statusCode}");
      log(response.body);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        for (var element in body) {
          list.add(EmpEndShift.fromMap(element));
        }
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
