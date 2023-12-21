import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:buffalos/models/SafeTransferModule.dart';
import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../userapi.dart';

final SafeTransferApiProvider = Provider<SafeTransferApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return SafeTransferApi(Tokken: token);
});

class SafeTransferApi {
  final String Tokken;

  SafeTransferApi({required this.Tokken});

  Future<int> setsupplier(SafeTransfer transfer) async {
    final url = Uri.http(baseUrl, "/TblSafeTransfere/save");
    try {
      final resp = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $Tokken'
          },
          body: transfer.toJson());
      log(resp.statusCode.toString());
      log(resp.body);
      final body = jsonDecode(resp.body)["rs"]["pkTransfereId"];
      return body;
    } catch (e) {
      rethrow;
    }
  }

  void addfile(File file, String itemid) async {
    final url = Uri.http(baseUrl, "FileUpload/SafeTransferAttachment",
        {"Safetransfer_ID": itemid});
    final request = http.MultipartRequest("POST", url);
    request.headers.addAll(
      {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $Tokken'
      },
    );
    final multiport = await http.MultipartFile.fromPath("file", file.path);
    request.files.add(multiport);
    var response = await request.send();
    print(response.statusCode);
  }
}
