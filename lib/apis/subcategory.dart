import 'dart:convert';

import 'userapi.dart';
import '../models/Category.dart';
import '../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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
        {"pageSize": "2000", "userQuery": "FkCategoryId=1"});
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
}
