import 'dart:convert';

import 'userapi.dart';
import '../models/kitchen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utility/contants.dart';

final kitchenapiProvider = Provider((ref) {
  final tokken = ref.watch(authprovider).logedin.token;
  return kitchenapi(tokken: tokken);
});

class kitchenapi {
  final String tokken;

  kitchenapi({required this.tokken});

  Future<List<kitchen>> fetchitems() async {
    List<kitchen> itemlist = [];
    final url =
        Uri.http(baseUrl, "/TblPreparArea/getPage", {"pageSize": "2000"});
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
        itemlist.add(kitchen.fromMap(element));
      }

      return itemlist;
    } catch (e) {
      return [];
    }
  }

  Future<kitchen> fetchitem(String itemid) async {
    final url = Uri.http(baseUrl, "/TblPreparArea/getPage",
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

      final result = kitchen.fromMap(list);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> addkitch(String name) async {
    final url = Uri.http(baseUrl, "/TblPreparArea/save");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            "Accept": "text/plain",
            'Authorization': 'Bearer $tokken'
          },
          body: jsonEncode({"areaName": name}));
          
      final responsejson = jsonDecode(response.body);
      print(responsejson);
      final id = responsejson["rs"]["pkPrepareId"];
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
