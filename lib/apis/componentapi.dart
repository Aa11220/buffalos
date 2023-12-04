import 'dart:convert';

import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/models/Componentcategory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Material.dart';
import 'package:http/http.dart' as http;

import '../utility/contants.dart';

final componentapiProvider = Provider<componentapi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return componentapi(tokken: token);
});

class componentapi {
  final String tokken;

  componentapi({required this.tokken});

  Future<List<Material>> fetchitems() async {
    List<Material> itemlist = [];
    final url = Uri.http(baseUrl, "/TblMaterial/getPage",
        {"pageSize": "2000", "userQuery": "material=1"});
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

  Future<void> addMaterial(Componnent item) async {
    final url =
        Uri.http(baseUrl, "/Admin/SaveComponentAndComponentComposition");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            "Accept": "text/plain",
            'Authorization': 'Bearer $tokken'
          },
          body: jsonEncode(item.toMap()));
      print(jsonEncode(item.toMap()));
      print(response.statusCode);
      // final responsejson = jsonDecode(response.body);
      print(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
