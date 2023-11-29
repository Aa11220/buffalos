import 'dart:convert';

import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utility/contants.dart';

final itemapiProvider = Provider((ref) {
  final tokken = ref.watch(authprovider).logedin.token;
  return Itemsapi(tokken: tokken);
});

class Itemsapi {
  final String tokken;

  Itemsapi({required this.tokken});

  Future<List<item>> fetchitems(String catid) async {
    List<item> itemlist = [];
    final url = Uri.http(baseUrl, "TblItem/getPage",
        {"pageSize": "2000", "userQuery": "fkCategoryId=$catid"});
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
        itemlist.add(item.fromMap(element));
      }

      return itemlist;
    } catch (e) {
      return [];
    }
  }

  Future<item> fetchitem(String itemid) async {
    final url = Uri.http(baseUrl, "TblItem/getPage",
        {"pageSize": "2000", "userQuery": "pkItemId=$itemid"});
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

      final result = item.fromMap(list);
      print(result);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
