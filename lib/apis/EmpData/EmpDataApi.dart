import '../userapi.dart';
import '../../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import '../../models/EmpDataModule.dart';

final EmpDataApiProvider = Provider<EmpDataApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return EmpDataApi(tokken: token);
});

class EmpDataApi {
  final String _tokken;

  EmpDataApi({required String tokken}) : _tokken = tokken;
  Future<EmpData> Getdata(String Shift) async {
    try {
      final url = Uri.http(baseUrl, "/Admin/GetOpenShiftDetails",
          {"userQuery": "PK_Shift_ID=$Shift"});
      final response = await http.get(url, headers: {
        "Accept": "text/plain",
        "Authorization": "Bearer $_tokken",
      });
      log(response.statusCode.toString());
      log(response.body);
      final body = EmpData.fromJson(response.body);
      log(body.toString());
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
