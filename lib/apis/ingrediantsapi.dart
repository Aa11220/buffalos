import 'dart:convert';

import 'userapi.dart';
import '../models/ingediants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utility/contants.dart';

class ingrediantApi {
  final String tokken;

  ingrediantApi({required this.tokken});
  Future<List<ingrediants>> getall(String itemid) async {
    final url = Uri.http(baseUrl, "/Admin/GetProductIngrediants",
        {"userQuery": "FKtemID=$itemid"});
    List<ingrediants> mylist = [];
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokken',
          "Accept": "text/plain"
        },
      );

      final body = jsonDecode(response.body);

      for (var element in body) {
        mylist.add(ingrediants.fromMap(element));
      }
      return mylist;
    } catch (e) {
      rethrow;
    }
  }
}

final ingrediantApiprovider = Provider((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return ingrediantApi(tokken: token);
});
