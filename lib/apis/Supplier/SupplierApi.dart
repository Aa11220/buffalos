import 'dart:convert';
import 'dart:developer';

import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/Supplier/SupplierModule.dart';
import '../userapi.dart';

final SupplierApiProvider = Provider<SupplierApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return SupplierApi(Tokken: token);
});

class SupplierApi {
  final String Tokken;

  SupplierApi({required this.Tokken});
  Future<List<SupllierModule>> getSuppliers() async {
    List<SupllierModule> suppliers = [];
    try {
      final url =
          Uri.http(baseUrl, "/TblSupplier/getPage", {"pageSize": "2000"});
      final response = await http.get(url,
          headers: {'Authorization': 'Bearer $Tokken', "Accept": "text/plain"});
      if (response.statusCode == 200) {
        log(response.body);
        final body = jsonDecode(response.body);
        final list = body["rs"]["data"];
        for (var element in list) {
          suppliers.add(SupllierModule.fromMap(element));
        }
        return suppliers;
      }
      throw Exception("error");
    } catch (e) {
      rethrow;
    }
  }
}
