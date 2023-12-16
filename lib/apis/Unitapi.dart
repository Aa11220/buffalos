import 'dart:convert';

import '../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/unit.dart';
import 'userapi.dart';

final UnitapiProvider = Provider<Unitapi>((ref) {
  final tokken = ref.watch(authprovider).logedin.token;
  return Unitapi(tokken: tokken);
});

class Unitapi {
  final String tokken;

  Unitapi({required this.tokken});
  Future<List<Unit>> getUnits() async {
    List<Unit> units = [];
    final url = Uri.http(baseUrl, "/TblUnit/getPage", {"pageSize": "2000"});
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokken'
        },
      );
      print(response.body);
      final body = jsonDecode(response.body);
      final res = body["rs"]["data"];
      for (var element in res) {
        units.add(Unit.fromMap(element));
      }
      print(units);
      return units;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> addunit(String unit) async {
    final url = Uri.http(baseUrl, "TblUnit/save");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            "Accept": "text/plain",
            'Authorization': 'Bearer $tokken'
          },
          body: jsonEncode({"unit": unit}));
      final responsejson = jsonDecode(response.body);
      print(responsejson);
      final id = responsejson["rs"]["pkUnitId"];
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
