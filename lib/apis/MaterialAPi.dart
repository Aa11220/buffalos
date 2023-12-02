import 'dart:convert';

import '../models/Material.dart';
import 'userapi.dart';
import '../models/kitchen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utility/contants.dart';

final MaterialapiProvider = Provider((ref) {
  final tokken = ref.watch(authprovider).logedin.token;
  return Materialapi(tokken: tokken);
});

class Materialapi {
  final String tokken;

  Materialapi({required this.tokken});

  Future<List<Material>> fetchitems() async {
    List<Material> itemlist = [];
    final url = Uri.http(baseUrl, "/TblMaterial/getPage", {"pageSize": "2000"});
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokken'
        },
      );
      final body = jsonDecode(response.body);
      final list = body["rs"]["data"];
      print(list);
      for (var element in list) {
        itemlist.add(Material.fromMap(element));
      }

      return itemlist;
    } catch (e) {
      return [];
    }
  }

  Future<Material> fetchitem(String itemid) async {
    final url = Uri.http(baseUrl, "/TblItem/getPage",
        {"pageSize": "2000", "userQuery": "pkPrepareId=$itemid"});
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokken'
        },
      );
      final body = jsonDecode(response.body);
      final list = body["rs"]["data"][0];

      final result = Material.fromMap(list);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> addMaterial(Material item) async {
    final url = Uri.http(baseUrl, "/TblItem/save");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            "Accept": "text/plain",
            'Authorization': 'Bearer $tokken'
          },
          body: jsonEncode(item.toMap()));
      final responsejson = jsonDecode(response.body);
      print(responsejson);
      final id = 1;
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
