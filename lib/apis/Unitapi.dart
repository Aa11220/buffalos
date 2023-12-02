import 'dart:convert';

import 'package:buffalos/Featuers/Products/widget/ingrediants.dart';
import 'package:buffalos/utility/contants.dart';
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
}
