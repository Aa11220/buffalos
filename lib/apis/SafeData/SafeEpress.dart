import 'dart:convert';
import 'dart:developer';

import '../../models/SafeExpress/SafeEpressModule.dart';
import '../userapi.dart';
import '../../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

///provider for safe data api
///it Take toke
final SafeDataExpressApiProvider = Provider<SafeDataExpressApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return SafeDataExpressApi(tokken: token);
});

class SafeDataExpressApi {
  final String tokken;

  SafeDataExpressApi({required this.tokken});

  /// Get information about a specified Safe
  Future<List<SafeExpressModule>> getsafeData() async {
    final List<SafeExpressModule> list = [];
    final url = Uri.http(
      baseUrl,
      "/TblSafe/getPage",
    );
    final response = await http.get(url,
        headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tokken'});
    log(response.statusCode.toString());
    log(response.body);
    if (200 == response.statusCode) {
      final body = jsonDecode(response.body);
      final listq = body["rs"]["data"];
      for (var element in listq) {
        list.add(SafeExpressModule.fromMap(element));
      }
      return list;
    }
    return [];
  }
}
