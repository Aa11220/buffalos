import 'dart:convert';

import 'userapi.dart';
import '../models/itemwithingred.dart';
import '../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final addandupdateProvider = Provider<addandipdate>((ref) {
  final tokken = ref.watch(authprovider).logedin.token;
  return addandipdate(tokken: tokken);
});

class addandipdate {
  final String tokken;

  addandipdate({required this.tokken});

  Future<int> updatewithingrediant(itemwithingred item) async {
    final url = Uri.http(baseUrl, "/Admin/SaveUpdateProductWithIngerdiants");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "text/plain",
          'Authorization': 'Bearer $tokken'
        },
        body: jsonEncode(item.toMap()));
    print(jsonEncode(item.toMap()));
    print(response.statusCode);
    print(response.body);
    return 1;
  }
}
