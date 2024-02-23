import 'dart:convert';

import 'package:buffalos/models/itemwithnotes.dart';

import 'userapi.dart';
import '../models/itemwithingred.dart';
import '../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final addandupdatenoteProvider = Provider<addandipdatenote>((ref) {
  final tokken = ref.watch(authprovider).logedin.token;
  return addandipdatenote(tokken: tokken);
});

class addandipdatenote {
  final String tokken;

  addandipdatenote({required this.tokken});

  Future<int> updatewithingrediant(ItemWithNotes item) async {
    final url = Uri.http(baseUrl, "/Admin/SaveUpdateItemNotes");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "text/plain",
          'Authorization': 'Bearer $tokken'
        },
        body: jsonEncode(item.toMap()));
    print("-----------------updatewithingrediant--------------------------");
    print(jsonEncode(item.toMap()));
    print(response.statusCode);
    print(response.body);
    print("-------------------updatewithingrediant------------------------");
    final itemname = jsonDecode(response.body);

    return itemname;
  }
}
