import "dart:convert";
import "dart:developer";

import "dart:io";

import "package:buffalos/utility/contants.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http/http.dart" as http;

import "../userapi.dart";

final ExpensesApiProvider = Provider<ExpensesApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return ExpensesApi(Tokken: token);
});

class ExpensesApi {
  final String Tokken;

  ExpensesApi({required this.Tokken});
  Future<int> SendExpensess(
      {required int value,
      String? description,
      required int fK_Safe_ID,
      required int fK_Shift_ID,
      bool return_pay = false,
      bool buyBill = false,
      required String payName}) async {
    final url = Uri.http(baseUrl, "Admin/Expenses");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $Tokken'
        },
        body: jsonEncode(
          {
            "value": value,
            "description": description,
            "fK_Safe_ID": fK_Safe_ID,
            "fK_Shift_ID": fK_Shift_ID,
            "return_pay": return_pay,
            "buyBill": buyBill,
            "payName": payName
          },
        ),
      );
      log(response.statusCode.toString());
      return int.tryParse(response.body)!;
    } catch (e) {
      rethrow;
    }
  }

  void addfile(File file, String itemid) async {
    final url = Uri.http(
        baseUrl, "FileUpload/UploadExpensesImages", {"Expense_ID": itemid});
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
