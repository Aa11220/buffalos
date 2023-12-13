import 'dart:convert';
import 'dart:developer';

import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/SafeData.dart';

///provider for safe data api
///it Take toke
final SafeDataApiProvider = Provider<SafeDataApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return SafeDataApi(tokken: token);
});

class SafeDataApi {
  final String tokken;

  SafeDataApi({required this.tokken});

  /// Get information about a specified Safe
  Future<List<SafeData>> getsafeData() async {
    final List<SafeData> list = [];
    final url = Uri.http(
      baseUrl,
      "/Admin/SafeBalanceReport",
    );
    final response = await http.get(url,
        headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tokken'});
    log(response.statusCode.toString());
    log(response.body);
    if (200 == response.statusCode) {
      final body = jsonDecode(response.body);
      for (var element in body) {
        list.add(SafeData.fromMap(element));
      }
      return list;
    }
    return [];
  }
}
