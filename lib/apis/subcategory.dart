import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/Category.dart';
import '../utility/contants.dart';
import 'userapi.dart';

final subcategoryapiProvider = Provider<Subcategoryapi>((ref) {
  final tokken = ref.watch(authprovider).logedin.token;
  return Subcategoryapi(tokken: tokken);
});

class Subcategoryapi {
  final String tokken;

  Subcategoryapi({required this.tokken});

  Future<List<Category>> getsubcat(String maincategory) async {
    List<Category> catlist = [];
    final url = Uri.http(baseUrl, "TblItemCategory/getPage",
        {"pageSize": "2000", "userQuery": "fkCategoryId=$maincategory"});
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokken'
    });
    print(response.statusCode);
    print(response.body);
    final body = jsonDecode(response.body);
    final list = body["rs"]["data"];
    for (var element in list) {
      catlist.add(Category.fromMap(element));
    }
    return catlist;
  }

  Future<List<int>> addSubCategory(String name, String Categoryid) async {
    final url = Uri.http(baseUrl, "TblItemCategory/save");
    try {
      final responsee = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $tokken'
          },
          body: json.encode({
            "fkCategoryId": int.tryParse(Categoryid),
            "categoryName": name
          }));
      print(responsee.body);
      var body_Map = jsonDecode(responsee.body);
      return [
        body_Map["rs"]["pkCategory"] as int,
        body_Map["rs"]["fkCategoryId"] as int
      ];
    } catch (e) {
      print("Error");
      return [0, 0];
    }
  }
}
