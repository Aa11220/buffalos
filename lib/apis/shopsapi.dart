import 'dart:convert';

import 'userapi.dart';
import '../models/Stores.dart';
import '../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final StoressApiProvider = Provider<StoressApi>((ref) {
  final tokken = ref.read(authprovider).logedin.token;
  return StoressApi(tokken: tokken);
});

class StoressApi {
  final String tokken;

  StoressApi({required this.tokken});
  Future<List<Stores>> getStores() async {
    try {
      List<Stores> list = [
        Stores(
            pkStoreId: null,
            storeName: "All",
            location: null,
            tel: null,
            kitchen: null,
            main: null)
      ];
      final url = Uri.http(baseUrl, "/TblStore/getPage", {"pageSize": "2000"});
      final response = await http.get(url,
          headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tokken'});
      final json = jsonDecode(response.body);
      final body = json["rs"]["data"];
      for (var element in body) {
        list.add(Stores.fromMap(element));
      }
      return list;
    } on Exception {
      rethrow;
    }
  }
}
