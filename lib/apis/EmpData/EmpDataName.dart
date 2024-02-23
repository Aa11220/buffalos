import 'dart:convert';

import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../userapi.dart';

final EmpDataNameProvider = Provider<EmpDataNameApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return EmpDataNameApi(Tokken: token);
});

class EmpDataNameApi {
  final String Tokken;

  EmpDataNameApi({required this.Tokken});
  Future<String> GetName(String id) async {
    final url =
        Uri.http(baseUrl, "/TblEmp/getPage", {"userquery": "pkEmpId=$id"});
    final respose = await http.get(url, headers: {
      "Authorization": "Bearer $Tokken",
    });
    final body = jsonDecode(respose.body);
    print(body);
    try {
      final String name = (body["rs"]["data"][0]["empName"]) ?? "";
      return name;
    } catch (e) {
      return "";
    }
  }
}
