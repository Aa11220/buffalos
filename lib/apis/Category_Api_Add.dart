// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/CategoryForAdd/Categorry_For_Add.dart';
import '../utility/contants.dart';
import 'package:http/http.dart' as http;

import 'userapi.dart';

final CategoriesAddApiprovider = Provider((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return CategoryApiAdd(tokken: token);
});

class CategoryApiAdd {
  final String tokken;
  CategoryApiAdd({
    required this.tokken,
  });
  Future<List<CategoryForAdd>> fetchCategoriesAdd() async {
    List<CategoryForAdd> catlist = [];
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
        var item = CategoryForAdd.fromMap(element);
        if (item.fkCategory == null) {
          catlist.add(item);
        }
      }

      return catlist;
    } catch (e) {
      return [];
    }
  }
}
