// create class "categories_api" and add http package to it ?
import 'dart:convert';
import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/models/Category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utility/contants.dart';

final CategoriesApiprovider = Provider((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return CategoriesApi(tokken: token);
});

class CategoriesApi {
  final String tokken;

  CategoriesApi({required this.tokken});

  Future<List<Category>> fetchCategories() async {
    List<Category> catlist = [];
    final url =
        Uri.http(baseUrl, "TblItemCategory/getPage", {"pageSize": "2000"});
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
      for (var element in list) {
        catlist.add(Category.fromMap(element));
      }

      return catlist;
    } catch (e) {
      return [];
    }
  }
}
