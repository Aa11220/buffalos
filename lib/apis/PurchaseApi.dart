// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/PurchaseData.dart';
import '../utility/contants.dart';
import 'dart:convert';

import 'userapi.dart';

final PurchaseApiProvider = Provider<PurchaseApi>((ref) {
  final String tokken = ref.watch(authprovider).logedin.token;

  return PurchaseApi(Tooken: tokken);
});

class PurchaseApi {
  final String Tooken;
  PurchaseApi({
    required this.Tooken,
  });
  Future<int> sendPurchase(PurchaseDataModule module) async {
    final url = Uri.http(baseUrl, "Admin/SaveBuyMaterial");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $Tooken'
        },
        body: jsonEncode(module.toMap()));
    print(response.statusCode);
    final body = jsonDecode(response.body);
    return body["rs"]["pkPaymentID"];
  }

  void addfile(File file, String itemid) async {
    final url = Uri.http(
        baseUrl, "FileUpload/UploadExpensesImages", {"Expense_ID": itemid});
    final request = http.MultipartRequest("POST", url);
    request.headers.addAll(
      {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $Tooken'
      },
    );
    final multiport = await http.MultipartFile.fromPath("file", file.path);
    request.files.add(multiport);
    var response = await request.send();
    print(response.statusCode);
  }
}
